//
//  FMScriptStepHandlers+AccountsSecurityHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Accounts & Security Handlers
// ─────────────────────────────────────────────

struct AddAccountHandler: FMScriptStepHandler {
    static let id: FMStepID = .addAccount
    static let name = "Add Account"
    static func matches(textLine: String) -> Bool { textLine == "add account" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <ChgPwdOnNextLogin value=\"False\"/>\n        <AddAccount>\n            <AccountType>FileMaker</AccountType>\n        </AddAccount>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Add Account"
    }
}

struct DeleteAccountHandler: FMScriptStepHandler {
    static let id: FMStepID = .deleteAccount
    static let name = "Delete Account"
    static func matches(textLine: String) -> Bool { textLine == "delete account" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Delete Account"
    }
}

struct EnableAccountHandler: FMScriptStepHandler {
    static let id: FMStepID = .enableAccount
    static let name = "Enable Account"
    static func matches(textLine: String) -> Bool { textLine == "enable account" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let op = bracketContent.lowercased().contains("deact") ? "Deactivate" : "Activate"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <AccountOperation value=\"\(op)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let op = step.parameters["AccountOperation.value"] ?? "Activate"
        return "\(pad)\(prefix)Enable Account [ \(op) ]"
    }
}

struct ResetAccountPasswordHandler: FMScriptStepHandler {
    static let id: FMStepID = .resetAccountPassword
    static let name = "Reset Account Password"
    static func matches(textLine: String) -> Bool { textLine == "reset account password" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <ChgPwdOnNextLogin value=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Reset Account Password"
    }
}

struct ReLoginHandler: FMScriptStepHandler {
    static let id: FMStepID = .reLogin
    static let name = "Re-Login"
    static func matches(textLine: String) -> Bool { textLine == "re-login" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Re-Login"
    }
}

struct ChangePasswordHandler: FMScriptStepHandler {
    static let id: FMStepID = .changePassword
    static let name = "Change Password"
    static func matches(textLine: String) -> Bool { textLine == "change password" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Change Password"
    }
}

struct SetSessionIdentifierHandler: FMScriptStepHandler {
    static let id: FMStepID = .setSessionIdentifier
    static let name = "Set Session Identifier"
    static func matches(textLine: String) -> Bool { textLine == "set session identifier" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Set Session Identifier"
    }
}
