//
//  FMScriptStepHandlers+TransactionHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Transaction Handlers
// ─────────────────────────────────────────────

struct OpenTransactionHandler: FMScriptStepHandler {
    static let id: FMStepID = .openTransaction
    static let name = "Open Transaction"
    static func matches(textLine: String) -> Bool { textLine == "open transaction" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let lower = bracketContent.lowercased()
        let skipAutoEntry = lower.contains("skip auto-enter")
        let essForceCommit = lower.contains("override ess") || lower.contains("ess locking")
        let anyOption = skipAutoEntry || essForceCommit || lower.contains("skip data entry validation")
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Option state=\"\(anyOption ? "True" : "False")\"/>\n        <ESSForceCommit state=\"\(essForceCommit ? "True" : "False")\"/>\n        <SkipAutoEntry state=\"\(skipAutoEntry ? "True" : "False")\"/>\n        <Restore state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let opt = step.parameters["Option.state"] ?? step.parameters["Option"] ?? ""
        let skipAuto = step.parameters["SkipAutoEntry.state"] ?? step.parameters["SkipAutoEntry"]
        let essForce = step.parameters["ESSForceCommit.state"] ?? step.parameters["ESSForceCommit"]
        let base = "\(pad)\(prefix)Open Transaction"
        var parts: [String] = []
        if skipAuto == "True" { parts.append("Skip auto-enter options") }
        // "Option" is a general flag that's also set when skip-auto-enter or
        // ESS-override are on; it only implies "skip data entry validation"
        // on its own when neither of those two more specific flags is set.
        if opt == "True" && skipAuto != "True" && essForce != "True" {
            parts.append("Skip data entry validation")
        }
        if essForce == "True" { parts.append("Override ESS locking conflicts") }
        if parts.isEmpty { return base }
        return "\(base) [ \(parts.joined(separator: "; ")) ]"
    }
}

struct CommitTransactionHandler: FMScriptStepHandler {
    static let id: FMStepID = .commitTransaction
    static let name = "Commit Transaction"
    static func matches(textLine: String) -> Bool { textLine == "commit transaction" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Commit Transaction"
    }
}

struct RevertTransactionHandler: FMScriptStepHandler {
    static let id: FMStepID = .revertTransaction
    static let name = "Revert Transaction"
    static func matches(textLine: String) -> Bool { textLine == "revert transaction" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        var condition = ""
        var errorCode = ""
        var errorMsg = ""
        for part in parts {
            let trimmed = part.trimmingCharacters(in: .whitespaces)
            if let range = trimmed.range(of: "condition:", options: .caseInsensitive) {
                condition = String(trimmed[range.upperBound...]).trimmingCharacters(in: .whitespaces)
            } else if let range = trimmed.range(of: "error code:", options: .caseInsensitive) {
                errorCode = String(trimmed[range.upperBound...]).trimmingCharacters(in: .whitespaces)
            } else if let range = trimmed.range(of: "error message:", options: .caseInsensitive) {
                errorMsg = String(trimmed[range.upperBound...]).trimmingCharacters(in: .whitespaces)
            }
        }
        let hasOption = !condition.isEmpty || !errorCode.isEmpty || !errorMsg.isEmpty
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Option state=\"\(hasOption ? "True" : "False")\"/>\n        <Condition><Calculation><![CDATA[\(condition)]]></Calculation></Condition>\n        <ErrorCode><Calculation><![CDATA[\(errorCode)]]></Calculation></ErrorCode>\n        <ErrorMessage><Calculation><![CDATA[\(errorMsg)]]></Calculation></ErrorMessage>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let condition = step.parameters["Condition"] ?? ""
        let errorCode = step.parameters["ErrorCode"] ?? ""
        let errorMsg = step.parameters["ErrorMessage"] ?? ""
        let base = "\(pad)\(prefix)Revert Transaction"
        let parts: [String] = [
            condition.isEmpty ? nil : "Condition: \(condition)",
            errorCode.isEmpty ? nil : "Error Code: \(errorCode)",
            errorMsg.isEmpty ? nil : "Error Message: \(errorMsg)"
        ].compactMap { $0 }
        if parts.isEmpty { return base }
        return "\(base) [ \(parts.joined(separator: "; ")) ]"
    }
}

struct SetRevertTransactionOnErrorHandler: FMScriptStepHandler {
    static let id: FMStepID = .setRevertTransactionOnError
    static let name = "Set Revert Transaction on Error"
    static func matches(textLine: String) -> Bool { textLine == "set revert transaction on error" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let state = bracketContent.lowercased() == "off" ? "False" : "True"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Set state=\"\(state)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let state = step.parameters["Set.state"] == "False" ? "Off" : "On"
        return "\(pad)\(prefix)Set Revert Transaction on Error [ \(state) ]"
    }
}
