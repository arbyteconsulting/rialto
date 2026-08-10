//
//  FMScriptStepHandlers+NavigationLayoutHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Navigation & Layout Handlers
// ─────────────────────────────────────────────

struct GoToLayoutHandler: FMScriptStepHandler {
    static let id: FMStepID = .goToLayout
    static let name = "Go to Layout"
    static func matches(textLine: String) -> Bool { textLine == "go to layout" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <LayoutDestination value=\"OriginalLayout\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let dest = step.parameters["LayoutDestination.value"] ?? "OriginalLayout"
        return "\(pad)\(prefix)Go to Layout [ \(dest) ]"
    }
}

struct GoToRecordRequestPageHandler: FMScriptStepHandler {
    static let id: FMStepID = .goToRecordRequestPage
    static let name = "Go to Record/Request/Page"
    static func matches(textLine: String) -> Bool { textLine == "go to record/request/page" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let loc = bracketContent.lowercased().contains("last") ? "Last" : "First"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n        <RowPageLocation value=\"\(loc)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let loc = step.parameters["RowPageLocation.value"] ?? "First"
        return "\(pad)\(prefix)Go to Record/Request/Page [ \(loc) ]"
    }
}

struct GoToFieldHandler: FMScriptStepHandler {
    static let id: FMStepID = .goToField
    static let name = "Go to Field"
    static func matches(textLine: String) -> Bool { textLine == "go to field" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        let (fieldRaw, rest) = FMFieldReference.extractFieldPart(fromSemicolonParts: parts)
        let selectAll = rest.joined(separator: " ").lowercased().contains("select")
        let ref = FMFieldReference.resolve(fieldRaw ?? "")
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"\(selectAll ? "True" : "False")\"/>\n        <Field\(FMFieldReference.tableAttr(ref.table)) id=\"\(ref.id)\" name=\"\(ref.field)\"></Field>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let field = step.parameters["Field.name"] ?? ""
        return "\(pad)\(prefix)Go to Field [ \(field) ]"
    }
}

struct GoToPortalRowHandler: FMScriptStepHandler {
    static let id: FMStepID = .goToPortalRow
    static let name = "Go to Portal Row"
    static func matches(textLine: String) -> Bool { textLine == "go to portal row" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let loc = bracketContent.lowercased().contains("last") ? "Last" : "First"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <RowPageLocation value=\"\(loc)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let loc = step.parameters["RowPageLocation.value"] ?? "First"
        return "\(pad)\(prefix)Go to Portal Row [ \(loc) ]"
    }
}

struct GoToObjectHandler: FMScriptStepHandler {
    static let id: FMStepID = .goToObject
    static let name = "Go to Object"
    static func matches(textLine: String) -> Bool { textLine == "go to object" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Go to Object"
    }
}

struct GoToRelatedRecordHandler: FMScriptStepHandler {
    static let id: FMStepID = .goToRelatedRecord
    static let name = "Go to Related Record"
    static func matches(textLine: String) -> Bool { textLine == "go to related record" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Restore state=\"False\"/>\n        <LayoutDestination value=\"CurrentLayout\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Go to Related Record"
    }
}

struct GoToNextFieldHandler: FMScriptStepHandler {
    static let id: FMStepID = .goToNextField
    static let name = "Go to Next Field"
    static func matches(textLine: String) -> Bool { textLine == "go to next field" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Go to Next Field"
    }
}

struct GoToPreviousFieldHandler: FMScriptStepHandler {
    static let id: FMStepID = .goToPreviousField
    static let name = "Go to Previous Field"
    static func matches(textLine: String) -> Bool { textLine == "go to previous field" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Go to Previous Field"
    }
}

struct GoToListOfRecordsHandler: FMScriptStepHandler {
    static let id: FMStepID = .goToListOfRecords
    static let name = "Go to List of Records"
    static func matches(textLine: String) -> Bool { textLine == "go to list of records" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <LayoutDestination value=\"CurrentLayout\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Go to List of Records"
    }
}

struct NewRecordRequestHandler: FMScriptStepHandler {
    static let id: FMStepID = .newRecordRequest
    static let name = "New Record/Request"
    static func matches(textLine: String) -> Bool { textLine == "new record/request" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)New Record/Request"
    }
}

struct DuplicateRecordRequestHandler: FMScriptStepHandler {
    static let id: FMStepID = .duplicateRecordRequest
    static let name = "Duplicate Record/Request"
    static func matches(textLine: String) -> Bool { textLine == "duplicate record/request" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Duplicate Record/Request"
    }
}

struct DeleteRecordRequestHandler: FMScriptStepHandler {
    static let id: FMStepID = .deleteRecordRequest
    static let name = "Delete Record/Request"
    static func matches(textLine: String) -> Bool { textLine == "delete record/request" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Delete Record/Request"
    }
}

struct DeleteAllRecordsHandler: FMScriptStepHandler {
    static let id: FMStepID = .deleteAllRecords
    static let name = "Delete All Records"
    static func matches(textLine: String) -> Bool { textLine == "delete all records" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Delete All Records"
    }
}

struct DeletePortalRowHandler: FMScriptStepHandler {
    static let id: FMStepID = .deletePortalRow
    static let name = "Delete Portal Row"
    static func matches(textLine: String) -> Bool { textLine == "delete portal row" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Delete Portal Row"
    }
}

struct RevertRecordRequestHandler: FMScriptStepHandler {
    static let id: FMStepID = .revertRecordRequest
    static let name = "Revert Record/Request"
    static func matches(textLine: String) -> Bool { textLine == "revert record/request" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Revert Record/Request"
    }
}

struct OpenRecordRequestHandler: FMScriptStepHandler {
    static let id: FMStepID = .openRecordRequest
    static let name = "Open Record/Request"
    static func matches(textLine: String) -> Bool { textLine == "open record/request" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Record/Request"
    }
}

struct CopyRecordRequestHandler: FMScriptStepHandler {
    static let id: FMStepID = .copyRecordRequest
    static let name = "Copy Record/Request"
    static func matches(textLine: String) -> Bool { textLine == "copy record/request" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Copy Record/Request"
    }
}

struct CopyAllRecordsRequestsHandler: FMScriptStepHandler {
    static let id: FMStepID = .copyAllRecordsRequests
    static let name = "Copy All Records/Requests"
    static func matches(textLine: String) -> Bool { textLine == "copy all records/requests" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Copy All Records/Requests"
    }
}
