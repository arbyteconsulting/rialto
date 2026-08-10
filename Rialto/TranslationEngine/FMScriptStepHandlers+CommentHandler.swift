//
//  FMScriptStepHandlers+CommentHandler.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Comment Handler
// ─────────────────────────────────────────────

struct CommentStepHandler: FMScriptStepHandler {
    static let id: FMStepID = .comment
    static let name = "# (comment)"
    static func matches(textLine: String) -> Bool { textLine == "# (comment)" || textLine.hasPrefix("#") }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let commentText = bracketContent.isEmpty ? "" : bracketContent
        return "    <Step enable=\"True\" id=\"\(id)\" name=\"\(name)\">\n        <Text>\(commentText)</Text>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        // The XML parser captures <Text> element content into parameters["Text"]
        let text = step.parameters["Text"] ?? step.comment ?? ""
        if text.isEmpty {
            return "\(pad)\(prefix)#"
        }
        return "\(pad)\(prefix)# \(text)"
    }
}
