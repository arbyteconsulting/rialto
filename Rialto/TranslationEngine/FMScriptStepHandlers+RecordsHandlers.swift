//
//  FMScriptStepHandlers+RecordsHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Records Handlers
// ─────────────────────────────────────────────

struct ImportRecordsHandler: FMScriptStepHandler {
    static let id: FMStepID = .importRecords
    static let name = "Import Records"
    static func matches(textLine: String) -> Bool { textLine == "import records" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n        <Restore state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Import Records"
    }
}

struct ExportRecordsHandler: FMScriptStepHandler {
    static let id: FMStepID = .exportRecords
    static let name = "Export Records"
    static func matches(textLine: String) -> Bool { textLine == "export records" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n        <Restore state=\"False\"/>\n        <CreateDirectories state=\"True\"/>\n        <AutoOpen state=\"False\"/>\n        <CreateEmail state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Export Records"
    }
}

struct SaveCopyAsHandler: FMScriptStepHandler {
    static let id: FMStepID = .saveCopyAs
    static let name = "Save a Copy as"
    static func matches(textLine: String) -> Bool { textLine == "save a copy as" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <CreateDirectories state=\"True\"/>\n        <AutoOpen state=\"False\"/>\n        <CreateEmail state=\"False\"/>\n        <SaveAsType value=\"Copy\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Save a Copy as"
    }
}

struct SaveRecordsAsExcelHandler: FMScriptStepHandler {
    static let id: FMStepID = .saveRecordsAsExcel
    static let name = "Save Records as Excel"
    static func matches(textLine: String) -> Bool { textLine == "save records as excel" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n        <Restore state=\"False\"/>\n        <CreateDirectories state=\"True\"/>\n        <AutoOpen state=\"False\"/>\n        <CreateEmail state=\"False\"/>\n        <SaveType value=\"BrowsedRecords\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Save Records as Excel"
    }
}

struct SaveRecordsAsPDFHandler: FMScriptStepHandler {
    static let id: FMStepID = .saveRecordsAsPDF
    static let name = "Save Records as PDF"
    static func matches(textLine: String) -> Bool { textLine == "save records as pdf" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n        <Restore state=\"False\"/>\n        <CreateDirectories state=\"True\"/>\n        <AutoOpen state=\"False\"/>\n        <CreateEmail state=\"False\"/>\n        <PDFOptions source=\"RecordsBeingBrowsed\">\n            <Document>\n                <Pages AllPages=\"True\"/>\n            </Document>\n        </PDFOptions>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Save Records as PDF"
    }
}

struct SaveRecordsAsJSONLHandler: FMScriptStepHandler {
    static let id: FMStepID = .saveRecordsAsJSONL
    static let name = "Save Records as JSONL"
    static func matches(textLine: String) -> Bool { textLine == "save records as jsonl" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <CreateDirectories state=\"False\"/>\n        <AutoOpen state=\"False\"/>\n        <CreateEmail state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Save Records as JSONL"
    }
}

struct SaveRecordsAsSnapshotLinkHandler: FMScriptStepHandler {
    static let id: FMStepID = .saveRecordsAsSnapshotLink
    static let name = "Save Records as Snapshot Link"
    static func matches(textLine: String) -> Bool { textLine == "save records as snapshot link" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <CreateDirectories state=\"True\"/>\n        <CreateEmail state=\"False\"/>\n        <SaveType value=\"BrowsedRecords\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Save Records as Snapshot Link"
    }
}

struct SaveCopyAsAddonPackageHandler: FMScriptStepHandler {
    static let id: FMStepID = .saveCopyAsAddonPackage
    static let name = "Save a Copy as Add-on Package"
    static func matches(textLine: String) -> Bool { textLine == "save a copy as add-on package" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <LinkAvail state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Save a Copy as Add-on Package"
    }
}

struct PrintHandler: FMScriptStepHandler {
    static let id: FMStepID = .print
    static let name = "Print"
    static func matches(textLine: String) -> Bool { textLine == "print" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n        <Restore state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Print"
    }
}

struct PrintSetupHandler: FMScriptStepHandler {
    static let id: FMStepID = .printSetup
    static let name = "Print Setup"
    static func matches(textLine: String) -> Bool { textLine == "print setup" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n        <Restore state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Print Setup"
    }
}
