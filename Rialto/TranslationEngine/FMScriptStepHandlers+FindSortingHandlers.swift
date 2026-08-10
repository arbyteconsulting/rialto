//
//  FMScriptStepHandlers+FindSortingHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Find & Sorting Handlers
// ─────────────────────────────────────────────

struct EnterFindModeHandler: FMScriptStepHandler {
    static let id: FMStepID = .enterFindMode
    static let name = "Enter Find Mode"
    static func matches(textLine: String) -> Bool { textLine == "enter find mode" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let pauseState = bracketContent.lowercased().contains("on") ? "True" : "False"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Pause state=\"\(pauseState)\"/>\n        <Restore state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let pause = step.parameters["Pause.state"] == "True" ? "On" : "Off"
        return "\(pad)\(prefix)Enter Find Mode [ Pause: \(pause) ]"
    }
}

struct EnterBrowseModeHandler: FMScriptStepHandler {
    static let id: FMStepID = .enterBrowseMode
    static let name = "Enter Browse Mode"
    static func matches(textLine: String) -> Bool { textLine == "enter browse mode" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Pause state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Enter Browse Mode"
    }
}

struct EnterPreviewModeHandler: FMScriptStepHandler {
    static let id: FMStepID = .enterPreviewMode
    static let name = "Enter Preview Mode"
    static func matches(textLine: String) -> Bool { textLine == "enter preview mode" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Pause state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Enter Preview Mode"
    }
}

struct PerformFindHandler: FMScriptStepHandler {
    static let id: FMStepID = .performFind
    static let name = "Perform Find"
    static func matches(textLine: String) -> Bool { textLine == "perform find" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Restore state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Perform Find [ ]"
    }
}

struct PerformFindReplaceHandler: FMScriptStepHandler {
    static let id: FMStepID = .performFindReplace
    static let name = "Perform Find/Replace"
    static func matches(textLine: String) -> Bool { textLine == "perform find/replace" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <FindReplaceOperation MatchWholeWords=\"False\" MatchCase=\"False\" WithinOptions=\"All\" AcrossOptions=\"All\" direction=\"Forward\" type=\"FindNext\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Perform Find/Replace"
    }
}

struct PerformQuickFindHandler: FMScriptStepHandler {
    static let id: FMStepID = .performQuickFind
    static let name = "Perform Quick Find"
    static func matches(textLine: String) -> Bool { textLine == "perform quick find" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Perform Quick Find"
    }
}

struct ShowAllRecordsHandler: FMScriptStepHandler {
    static let id: FMStepID = .showAllRecords
    static let name = "Show All Records"
    static func matches(textLine: String) -> Bool { textLine == "show all records" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Show All Records"
    }
}

struct ShowOmittedOnlyHandler: FMScriptStepHandler {
    static let id: FMStepID = .showOmittedOnly
    static let name = "Show Omitted Only"
    static func matches(textLine: String) -> Bool { textLine == "show omitted only" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Show Omitted Only"
    }
}

struct ModifyLastFindHandler: FMScriptStepHandler {
    static let id: FMStepID = .modifyLastFind
    static let name = "Modify Last Find"
    static func matches(textLine: String) -> Bool { textLine == "modify last find" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Modify Last Find"
    }
}

struct OmitRecordHandler: FMScriptStepHandler {
    static let id: FMStepID = .omitRecord
    static let name = "Omit Record"
    static func matches(textLine: String) -> Bool { textLine == "omit record" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Omit Record"
    }
}

struct OmitMultipleRecordsHandler: FMScriptStepHandler {
    static let id: FMStepID = .omitMultipleRecords
    static let name = "Omit Multiple Records"
    static func matches(textLine: String) -> Bool { textLine == "omit multiple records" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Omit Multiple Records"
    }
}

struct ConstrainFoundSetHandler: FMScriptStepHandler {
    static let id: FMStepID = .constrainFoundSet
    static let name = "Constrain Found Set"
    static func matches(textLine: String) -> Bool { textLine == "constrain found set" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Restore state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Constrain Found Set"
    }
}

struct ExtendFoundSetHandler: FMScriptStepHandler {
    static let id: FMStepID = .extendFoundSet
    static let name = "Extend Found Set"
    static func matches(textLine: String) -> Bool { textLine == "extend found set" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Restore state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Extend Found Set"
    }
}

struct FindMatchingRecordsHandler: FMScriptStepHandler {
    static let id: FMStepID = .findMatchingRecords
    static let name = "Find Matching Records"
    static func matches(textLine: String) -> Bool { textLine == "find matching records" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <FindMatchingRecordsByField value=\"FindMatchingReplace\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Find Matching Records"
    }
}

struct SortRecordsHandler: FMScriptStepHandler {
    static let id: FMStepID = .sortRecords
    static let name = "Sort Records"
    static func matches(textLine: String) -> Bool { textLine == "sort records" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n        <Restore state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Sort Records"
    }
}

struct SortRecordsByFieldHandler: FMScriptStepHandler {
    static let id: FMStepID = .sortRecordsByField
    static let name = "Sort Records by Field"
    static func matches(textLine: String) -> Bool { textLine == "sort records by field" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let direction = bracketContent.lowercased().contains("desc") ? "SortDescending" : "SortAscending"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SortRecordsByField value=\"\(direction)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let dir = step.parameters["SortRecordsByField.value"] == "SortDescending" ? "Descending" : "Ascending"
        return "\(pad)\(prefix)Sort Records by Field [ \(dir) ]"
    }
}

struct UnsortRecordsHandler: FMScriptStepHandler {
    static let id: FMStepID = .unsortRecords
    static let name = "Unsort Records"
    static func matches(textLine: String) -> Bool { textLine == "unsort records" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Unsort Records"
    }
}

struct CheckFoundSetHandler: FMScriptStepHandler {
    static let id: FMStepID = .checkFoundSet
    static let name = "Check Found Set"
    static func matches(textLine: String) -> Bool { textLine == "check found set" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Check Found Set"
    }
}

struct CheckRecordHandler: FMScriptStepHandler {
    static let id: FMStepID = .checkRecord
    static let name = "Check Record"
    static func matches(textLine: String) -> Bool { textLine == "check record" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Check Record"
    }
}

struct CheckSelectionHandler: FMScriptStepHandler {
    static let id: FMStepID = .checkSelection
    static let name = "Check Selection"
    static func matches(textLine: String) -> Bool { textLine == "check selection" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Check Selection"
    }
}
