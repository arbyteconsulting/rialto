import Foundation

// ─────────────────────────────────────────────
// MARK: - Plain Text → FM Clipboard XML
// ─────────────────────────────────────────────

enum FMPlainTextBuilder {

    static func build(plainText: String) -> String {
        FMFieldReference.resetSession()
        FMScriptReference.resetSession()
        let rawLines = plainText.components(separatedBy: .newlines)
        var output: [String] = []
        var joined: [String] = []
        
        // Accumulate complete steps by verifying balance of bracket closures
        var currentAccumulation = ""
        
        for raw in rawLines {
            let trimmedLine = raw.trimmingCharacters(in: .whitespaces)

            if currentAccumulation.isEmpty {
                // Not currently inside a multi-line step; blank separator lines
                // between top-level steps are simply skipped.
                if trimmedLine.isEmpty { continue }
                currentAccumulation = trimmedLine
            } else {
                // We're mid-way through an unclosed bracket span (e.g. a
                // multi-line calculation). Preserve the line break rather than
                // flattening to a space — calculations can contain "//" line
                // comments, which run to the end of the physical line, so
                // collapsing them onto one line silently swallows any code
                // that follows the "//" into the comment.
                currentAccumulation += "\n" + trimmedLine
            }
            
            // Count total open vs closed brackets to manage multi-line calculations safely
            let openCount = currentAccumulation.filter { $0 == "[" }.count
            let closeCount = currentAccumulation.filter { $0 == "]" }.count
            
            if openCount == closeCount {
                joined.append(currentAccumulation)
                currentAccumulation = ""
            }
        }
        // Catch any remaining unclosed buffer blocks safely
        if !currentAccumulation.isEmpty {
            joined.append(currentAccumulation)
        }

        for line in joined {
            if let xml = stepXML(for: line) { output.append(xml) }
        }
        
        // Collapse each step XML to a single line (matching FileMaker's compact format)
        // while preserving whitespace inside CDATA blocks and attribute values.
        let joinedSteps = output
            .map { collapseToSingleLine($0) }
            .joined(separator: "\n")

        return """
            <?xml version="1.0" encoding="UTF-8"?>
            <fmxmlsnippet type="FMObjectList">\(joinedSteps)
            </fmxmlsnippet>
            """
    }


    private static func stepXML(for line: String) -> String? {
        let content = line.trimmingCharacters(in: .whitespaces)

        // A bare "#" prefix is FileMaker's own Comment step ("# (comment)", id 89) —
        // whatever follows is free text, not a step name to look up. This must be
        // checked before the disabled-step logic below, since disabled steps use a
        // different marker ("//").
        if content.hasPrefix("#") {
            let commentText = String(content.dropFirst()).trimmingCharacters(in: .whitespaces)
            return CommentStepHandler.buildXML(bracketContent: commentText, isEnabled: true)
        }

        // "//" marks a disabled step: strip the marker and translate the remainder
        // normally, but with enable="False".
        var body = content
        let en: String
        if body.hasPrefix("//") {
            en = "False"
            body = String(body.dropFirst(2)).trimmingCharacters(in: .whitespaces)
        } else {
            en = "True"
        }

        // Always extract label (strips brackets if present, returns whole string if not)
        let labelText = label(body)
        let bracketText = bracket(body)
        
        // Defer instantly to the protocol-driven registration module
        if let handler = FMScriptStepRegistry.handler(for: labelText) {
            return handler.buildXML(bracketContent: bracketText, isEnabled: en == "True")
        }
        
        // Catch-all fallback layout for unmapped fields or structural gaps
        return "    <Step enable=\"\(en)\" id=\"0\" name=\"\(labelText)\">\n        <Calculation><![CDATA[\(bracketText)]]></Calculation>\n    </Step>"
    }

    private static func bracket(_ line: String) -> String {
        guard let s = line.firstIndex(of: "["), let e = line.lastIndex(of: "]") else { return "" }
        return String(line[line.index(after: s)..<e]).trimmingCharacters(in: .whitespaces)
    }

    /// Extracts the step command name by removing any parameter bracket blocks
    /// e.g., "Set Variable [ $x ; Value: 1 ]" -> "Set Variable"
    private static func label(_ line: String) -> String {
        if let bracketIndex = line.firstIndex(of: "[") {
            return line[..<bracketIndex].trimmingCharacters(in: .whitespaces)
        }
        return line
    }

    /// Collapses a multi-line XML step to a single line by removing newlines
    /// and collapsing whitespace between XML tags, while preserving
    /// whitespace inside CDATA sections and attribute values.
    private static func collapseToSingleLine(_ xml: String) -> String {
        let cdataOpen = "<![CDATA["
        let cdataClose = "]]>"
        
        var result = ""
        var remainder = Substring(xml)
        
        while let openRange = remainder.range(of: cdataOpen) {
            // Collapse everything before this CDATA block as normal markup.
            result += collapseMarkup(String(remainder[remainder.startIndex..<openRange.lowerBound]))
            
            let afterOpen = remainder[openRange.upperBound...]
            if let closeRange = afterOpen.range(of: cdataClose) {
                // Copy the CDATA block — including its internal newlines,
                // since calculations rely on them (e.g. "//" line comments
                // terminate at the newline; collapsing would swallow
                // whatever code follows on the same joined line).
                result += remainder[openRange.lowerBound..<closeRange.upperBound]
                remainder = remainder[closeRange.upperBound...]
            } else {
                // Unterminated CDATA (shouldn't normally happen) — copy the rest verbatim.
                result += remainder[openRange.lowerBound...]
                remainder = Substring("")
                break
            }
        }
        result += collapseMarkup(String(remainder))
        
        return result.trimmingCharacters(in: .whitespaces)
    }
    
    /// Collapses newlines/whitespace in plain XML markup (i.e. text known to be
    /// outside any CDATA section).
    private static func collapseMarkup(_ segment: String) -> String {
        let noNewlines = segment.replacingOccurrences(of: "\n", with: "")
        return noNewlines.replacingOccurrences(
            of: ">\\s+<",
            with: "><",
            options: .regularExpression
        )
    }
}
