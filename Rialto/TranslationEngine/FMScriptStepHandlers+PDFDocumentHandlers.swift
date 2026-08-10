//
//  FMScriptStepHandlers+PDFDocumentHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - FileMaker 2026 PDF Document Handlers
// ─────────────────────────────────────────────

struct CreatePDFHandler: FMScriptStepHandler {
    static let id: FMStepID = .createPDF
    static let name = "Create PDF"
    static func matches(textLine: String) -> Bool { textLine == "create pdf" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Restore state=\"False\"/>\n        <CreatePDFFile>\n            <Document>\n                <Pages AllPages=\"True\">\n                    <NumberFrom><Calculation><![CDATA[1]]></Calculation></NumberFrom>\n                </Pages>\n            </Document>\n        </CreatePDFFile>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Create PDF [ In-Memory ]"
    }
}

struct ClosePDFHandler: FMScriptStepHandler {
    static let id: FMStepID = .closePDF
    static let name = "Close PDF"
    static func matches(textLine: String) -> Bool { textLine == "close pdf" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <CreateDirectories state=\"False\"/>\n        <AutoOpen state=\"False\"/>\n        <CreateEmail state=\"False\"/>\n        <ClosePDFFile>\n            <PDFSaveType>File</PDFSaveType>\n        </ClosePDFFile>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Close PDF"
    }
}

struct CommitRecordsHandler: FMScriptStepHandler {
    static let id: FMStepID = .commitRecords
    static let name = "Commit Records/Requests"
    static func matches(textLine: String) -> Bool { textLine == "commit records/requests" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let noDialog = bracketContent.lowercased().contains("no dialog") || bracketContent.lowercased().contains("off") ? "True" : "False"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"\(noDialog)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let noInteract = step.parameters["NoInteract.state"] == "True" ? "No dialog" : "With dialog"
        return "\(pad)\(prefix)Commit Records/Requests [ \(noInteract) ]"
    }
}

struct ExitLoopIfHandler: FMScriptStepHandler {
    static let id: FMStepID = .exitLoopIf
    static let name = "Exit Loop If"
    static func matches(textLine: String) -> Bool { textLine == "exit loop if" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Calculation><![CDATA[\(bracketContent)]]></Calculation>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let calc = step.calculation ?? ""
        return "\(pad)\(prefix)Exit Loop If [ \(calc) ]"
    }
}

struct ShowCustomDialogHandler: FMScriptStepHandler {
    static let id: FMStepID = .showCustomDialog
    static let name = "Show Custom Dialog"
    static func matches(textLine: String) -> Bool { textLine == "show custom dialog" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        let titleText = parts.first?.trimmingCharacters(in: .whitespaces) ?? "\"Notice\""
        let msgText = parts.count > 1 ? parts[1].trimmingCharacters(in: .whitespaces) : "\"\""
        
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Title>\n            <Calculation><![CDATA[\(titleText)]]></Calculation>\n        </Title>\n        <Message>\n            <Calculation><![CDATA[\(msgText)]]></Calculation>\n        </Message>\n        <Buttons>\n            <Button CommitState=\"True\">\n                <Calculation><![CDATA[\"OK\"]]></Calculation>\n            </Button>\n            <Button CommitState=\"False\"/>\n            <Button CommitState=\"False\"/>\n        </Buttons>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Show Custom Dialog [ Optional Calculations Structured ]"
    }
}
