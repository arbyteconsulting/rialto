//
//  FMScriptStepHandlers+FieldEditingHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Field Editing Handlers
// ─────────────────────────────────────────────

struct SetFieldHandler: FMScriptStepHandler {
    static let id: FMStepID = .setField
    static let name = "Set Field"
    static func matches(textLine: String) -> Bool { textLine == "set field" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        let targetFieldRaw = parts.first?.trimmingCharacters(in: .whitespaces) ?? ""
        
        var calc = ""
        if parts.count > 1 {
            calc = parts[1...].joined(separator: ";").trimmingCharacters(in: .whitespaces)
        }
        
        let ref = FMFieldReference.resolve(targetFieldRaw)
        let tableAttr = ref.table.isEmpty ? "" : " table=\"\(ref.table)\""
        
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Calculation><![CDATA[\(calc)]]></Calculation>\n        <Field\(tableAttr) id=\"\(ref.id)\" name=\"\(ref.field)\"></Field>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let target = step.parameters["Field.name"] ?? "field"
        let calc = step.calculation ?? ""
        return "\(pad)\(prefix)Set Field [ \(target) ; \(calc) ]"
    }
}

struct SetFieldByNameHandler: FMScriptStepHandler {
    static let id: FMStepID = .setFieldByName
    static let name = "Set Field By Name"
    static func matches(textLine: String) -> Bool { textLine == "set field by name" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Set Field By Name"
    }
}

struct InsertCalculatedResultHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertCalculatedResult
    static let name = "Insert Calculated Result"
    static func matches(textLine: String) -> Bool { textLine == "insert calculated result" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert Calculated Result"
    }
}

struct InsertCurrentDateHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertCurrentDate
    static let name = "Insert Current Date"
    static func matches(textLine: String) -> Bool { textLine == "insert current date" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert Current Date"
    }
}

struct InsertCurrentTimeHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertCurrentTime
    static let name = "Insert Current Time"
    static func matches(textLine: String) -> Bool { textLine == "insert current time" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert Current Time"
    }
}

struct InsertCurrentUserNameHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertCurrentUserName
    static let name = "Insert Current User Name"
    static func matches(textLine: String) -> Bool { textLine == "insert current user name" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert Current User Name"
    }
}

struct InsertTextHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertText
    static let name = "Insert Text"
    static func matches(textLine: String) -> Bool { textLine == "insert text" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert Text"
    }
}

struct InsertFromIndexHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertFromIndex
    static let name = "Insert from Index"
    static func matches(textLine: String) -> Bool { textLine == "insert from index" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert from Index"
    }
}

struct InsertFromLastVisitedHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertFromLastVisited
    static let name = "Insert from Last Visited"
    static func matches(textLine: String) -> Bool { textLine == "insert from last visited" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert from Last Visited"
    }
}

struct InsertPictureHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertPicture
    static let name = "Insert Picture"
    static func matches(textLine: String) -> Bool { textLine == "insert picture" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <UniversalPathList type=\"Embedded\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert Picture"
    }
}

struct InsertPDFHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertPDF
    static let name = "Insert PDF"
    static func matches(textLine: String) -> Bool { textLine == "insert pdf" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <UniversalPathList type=\"Embedded\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert PDF"
    }
}

struct InsertFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertFile
    static let name = "Insert File"
    static func matches(textLine: String) -> Bool { textLine == "insert file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <UniversalPathList type=\"Embedded\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert File"
    }
}

struct InsertAudioVideoHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertAudioVideo
    static let name = "Insert Audio/Video"
    static func matches(textLine: String) -> Bool { textLine == "insert audio/video" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <UniversalPathList type=\"Embedded\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert Audio/Video"
    }
}

struct InsertFromURLHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertFromURL
    static let name = "Insert from URL"
    static func matches(textLine: String) -> Bool { textLine == "insert from url" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n        <SelectAll state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert from URL"
    }
}

struct InsertFromDeviceHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertFromDevice
    static let name = "Insert from Device"
    static func matches(textLine: String) -> Bool { textLine == "insert from device" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let source = bracketContent.lowercased().contains("scanner") ? "Scanner" : "Camera"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <InsertFrom value=\"\(source)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let source = step.parameters["InsertFrom.value"] ?? "Camera"
        return "\(pad)\(prefix)Insert from Device [ Source: \(source) ]"
    }
}

struct ReplaceFieldContentsHandler: FMScriptStepHandler {
    static let id: FMStepID = .replaceFieldContents
    static let name = "Replace Field Contents"
    static func matches(textLine: String) -> Bool { textLine == "replace field contents" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n        <Restore state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Replace Field Contents"
    }
}

struct RelookupFieldContentsHandler: FMScriptStepHandler {
    static let id: FMStepID = .relookupFieldContents
    static let name = "Relookup Field Contents"
    static func matches(textLine: String) -> Bool { textLine == "relookup field contents" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Relookup Field Contents"
    }
}

struct SetNextSerialValueHandler: FMScriptStepHandler {
    static let id: FMStepID = .setNextSerialValue
    static let name = "Set Next Serial Value"
    static func matches(textLine: String) -> Bool { textLine == "set next serial value" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        let fieldRaw = parts.first?.trimmingCharacters(in: .whitespaces) ?? ""
        
        var calc = ""
        if parts.count > 1 {
            calc = parts[1...].joined(separator: ";").trimmingCharacters(in: .whitespaces)
        }
        
        let ref = FMFieldReference.resolve(fieldRaw)
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Calculation><![CDATA[\(calc)]]></Calculation>\n        <Field\(FMFieldReference.tableAttr(ref.table)) id=\"\(ref.id)\" name=\"\(ref.field)\"></Field>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let field = step.parameters["Field.name"] ?? ""
        let calc = step.calculation ?? ""
        return "\(pad)\(prefix)Set Next Serial Value [ \(field) ; \(calc) ]"
    }
}

struct ExportFieldContentsHandler: FMScriptStepHandler {
    static let id: FMStepID = .exportFieldContents
    static let name = "Export Field Contents"
    static func matches(textLine: String) -> Bool { textLine == "export field contents" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <CreateDirectories state=\"True\"/>\n        <AutoOpen state=\"False\"/>\n        <CreateEmail state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Export Field Contents"
    }
}
