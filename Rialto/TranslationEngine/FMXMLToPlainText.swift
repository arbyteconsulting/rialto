import Foundation

// ─────────────────────────────────────────────
// MARK: - XML Parser
// ─────────────────────────────────────────────

class FMXMLParser: NSObject, XMLParserDelegate {

    private var steps:          [FMScriptStep] = []
    private var currentID:      FMStepID = FMStepID(rawValue: 0)
    private var currentName:    String = ""
    private var currentEnabled: Bool   = true
    private var currentParams:  [String: String] = [:]
    private var currentCalc:    String? = nil
    private var currentComment: String? = nil
    private var currentText:    String = ""

    private var inStep:       Bool = false
    private var inCalc:       Bool = false
    private var inComment:    Bool = false
    private var inRepetition: Bool = false

    func parse(xml: String) -> Result<[FMScriptStep], Error> {
        steps = []
        var processedXML = xml.trimmingCharacters(in: .whitespacesAndNewlines)
        if processedXML.hasPrefix("<Step") {
            processedXML = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<fmxmlsnippet type=\"FMObjectList\">\n\(processedXML)\n</fmxmlsnippet>"
        }
        guard let data = processedXML.data(using: .utf8) else {
            return .failure(NSError(domain: "FMParser", code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid UTF-8 data"]))
        }
        let parser = XMLParser(data: data)
        parser.delegate = self
        if parser.parse() { return .success(steps) }
        else if let error = parser.parserError { return .failure(error) }
        return .success(steps)
    }

    func parser(_ parser: XMLParser, didStartElement el: String,
                namespaceURI: String?, qualifiedName: String?,
                attributes attrs: [String: String] = [:]) {
        currentText = ""
        switch el {
        case "Step":
            inStep      = true
            let rawID   = Int(attrs["id"] ?? "0") ?? 0
            currentID      = FMStepID(rawValue: rawID)
            currentName    = attrs["name"] ?? ""
            currentEnabled = (attrs["enable"] ?? "True") == "True"
            currentParams  = [:]
            currentCalc    = nil
            currentComment = nil
        case "Calculation":
            if !inRepetition { inCalc = true }
        case "Comment":
            inComment = true
        case "Repetition":
            inRepetition = true
        default:
            break
        }

        // Deep namespace attributes using dot notation to prevent key collisions
        for (key, val) in attrs {
            let compoundKey = "\(el).\(key)"
            currentParams[compoundKey] = val
            if currentParams[key] == nil {
                currentParams[key] = val
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement el: String,
                namespaceURI: String?, qualifiedName: String?) {
        let text = currentText.trimmingCharacters(in: .whitespacesAndNewlines)

        switch el {
        case "Step":
            let step = FMScriptStep(
                id: currentID,
                name: currentName,
                enabled: currentEnabled,
                parameters: currentParams,
                calculation: currentCalc,
                comment: currentComment
            )
            steps.append(step)
            inStep = false
        case "Calculation":
            if inCalc {
                currentCalc = text
                inCalc = false
            }
        case "Comment":
            currentComment = text
            inComment = false
        case "Repetition":
            inRepetition = false
        default:
            // Capture ALL element text contents into parameters
            if inStep && !text.isEmpty {
                currentParams[el] = text
            }
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentText += string
    }

    func parser(_ parser: XMLParser, foundCDATA cdataBlock: Data) {
        if let str = String(data: cdataBlock, encoding: .utf8) {
            currentText += str
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - Script Renderer
// ─────────────────────────────────────────────

enum FMScriptRenderer {

    static func renderStep(_ step: FMScriptStep, indentDepth: Int) -> String {
        let pad = String(repeating: "    ", count: indentDepth)
        let prefix = step.enabled ? "" : "// "
        
        // Defer directly to the matching protocol implementation
        if let handler = FMScriptStepRegistry.handler(for: step.id) {
            return handler.renderText(step: step, prefix: prefix, pad: pad)
        }
        
        // Structured fallback for unmapped custom layout steps
        var line = "\(pad)\(prefix)\(step.name)"
        if let calc = step.calculation, !calc.isEmpty {
            line += " [ \(calc) ]"
        }
        return line
    }
    
    // MARK: - Entry Point Decompiler
    
    /// Iterates over an array of parsed FileMaker steps and combines them into a single string.
    static func render(steps: [FMScriptStep]) -> String {
        var lines: [String] = []
        var indentDepth = 0
        
        for step in steps {
            // Adjust indentation level dynamically before rendering structural blocks
            if step.id.isBlockClosing {
                indentDepth = max(0, indentDepth - 1)
            }
            
            // Render the step text line
            let renderedLine = renderStep(step, indentDepth: indentDepth)
            lines.append(renderedLine)
            
            // Push indentation deeper for steps that open structures
            if step.id.isBlockOpening {
                indentDepth += 1
            }
        }
        
        return lines.joined(separator: "\n")
    }
}
