//
//  FMScriptStepHandlers+ClipboardHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Clipboard Handlers
// ─────────────────────────────────────────────

struct CutHandler: FMScriptStepHandler {
    static let id: FMStepID = .cut
    static let name = "Cut"
    static func matches(textLine: String) -> Bool { textLine == "cut" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        let (fieldRaw, rest) = FMFieldReference.extractFieldPart(fromSemicolonParts: parts)
        let selectAll = rest.joined(separator: " ").lowercased().contains("select")
        let ref = FMFieldReference.resolve(fieldRaw ?? "")
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"\(selectAll ? "True" : "False")\"/>\n        <Field\(FMFieldReference.tableAttr(ref.table)) id=\"\(ref.id)\" name=\"\(ref.field)\"></Field>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let field = step.parameters["Field.name"] ?? ""
        return "\(pad)\(prefix)Cut [ \(field) ]"
    }
}

struct CopyHandler: FMScriptStepHandler {
    static let id: FMStepID = .copy
    static let name = "Copy"
    static func matches(textLine: String) -> Bool { textLine == "copy" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        let (fieldRaw, rest) = FMFieldReference.extractFieldPart(fromSemicolonParts: parts)
        let selectAll = rest.joined(separator: " ").lowercased().contains("select")
        let ref = FMFieldReference.resolve(fieldRaw ?? "")
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"\(selectAll ? "True" : "False")\"/>\n        <Field\(FMFieldReference.tableAttr(ref.table)) id=\"\(ref.id)\" name=\"\(ref.field)\"></Field>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let field = step.parameters["Field.name"] ?? ""
        return "\(pad)\(prefix)Copy [ \(field) ]"
    }
}

struct PasteHandler: FMScriptStepHandler {
    static let id: FMStepID = .paste
    static let name = "Paste"
    static func matches(textLine: String) -> Bool { textLine == "paste" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoStyle state=\"True\"/>\n        <SelectAll state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Paste"
    }
}

struct ClearContentHandler: FMScriptStepHandler {
    static let id: FMStepID = .clearContent
    static let name = "Clear"
    static func matches(textLine: String) -> Bool { textLine == "clear" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        let (fieldRaw, rest) = FMFieldReference.extractFieldPart(fromSemicolonParts: parts)
        let selectAll = rest.joined(separator: " ").lowercased().contains("select")
        let ref = FMFieldReference.resolve(fieldRaw ?? "")
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"\(selectAll ? "True" : "False")\"/>\n        <Field\(FMFieldReference.tableAttr(ref.table)) id=\"\(ref.id)\" name=\"\(ref.field)\"></Field>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let field = step.parameters["Field.name"] ?? ""
        return "\(pad)\(prefix)Clear [ \(field) ]"
    }
}

struct SelectAllHandler: FMScriptStepHandler {
    static let id: FMStepID = .selectAll
    static let name = "Select All"
    static func matches(textLine: String) -> Bool { textLine == "select all" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Select All"
    }
}

struct UndoRedoHandler: FMScriptStepHandler {
    static let id: FMStepID = .undoRedo
    static let name = "Undo/Redo"
    static func matches(textLine: String) -> Bool { textLine == "undo/redo" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let val = bracketContent.lowercased().contains("redo") ? "Redo" : "Undo"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <UndoRedo value=\"\(val)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let val = step.parameters["UndoRedo.value"] ?? "Undo"
        return "\(pad)\(prefix)Undo/Redo [ \(val) ]"
    }
}

struct SetSelectionHandler: FMScriptStepHandler {
    static let id: FMStepID = .setSelection
    static let name = "Set Selection"
    static func matches(textLine: String) -> Bool { textLine == "set selection" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        let (fieldRaw, rest) = FMFieldReference.extractFieldPart(fromSemicolonParts: parts)
        
        var startVal = ""
        var endVal = ""
        for part in rest {
            if let range = part.range(of: "start position:", options: .caseInsensitive) {
                startVal = String(part[range.upperBound...]).trimmingCharacters(in: .whitespaces)
            } else if let range = part.range(of: "end position:", options: .caseInsensitive) {
                endVal = String(part[range.upperBound...]).trimmingCharacters(in: .whitespaces)
            }
        }
        
        let ref = FMFieldReference.resolve(fieldRaw ?? "")
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <StartPosition><Calculation><![CDATA[\(startVal)]]></Calculation></StartPosition>\n        <EndPosition><Calculation><![CDATA[\(endVal)]]></Calculation></EndPosition>\n        <Field\(FMFieldReference.tableAttr(ref.table)) id=\"\(ref.id)\" name=\"\(ref.field)\"></Field>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let field = step.parameters["Field.name"] ?? ""
        return "\(pad)\(prefix)Set Selection [ \(field) ]"
    }
}
