//
//  FMScriptStepHandlers+DataAPISQLHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Data API & SQL Handlers
// ─────────────────────────────────────────────

struct ExecuteSQLHandler: FMScriptStepHandler {
    static let id: FMStepID = .executeSQL
    static let name = "Execute SQL"
    static func matches(textLine: String) -> Bool { textLine == "execute sql" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Execute SQL"
    }
}

struct ExecuteFMDataAPIHandler: FMScriptStepHandler {
    static let id: FMStepID = .executeFMDataAPI
    static let name = "Execute FileMaker Data API"
    static func matches(textLine: String) -> Bool { textLine == "execute filemaker data api" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Execute FileMaker Data API"
    }
}

struct PerformAppleScriptHandler: FMScriptStepHandler {
    static let id: FMStepID = .performAppleScript
    static let name = "Perform AppleScript"
    static func matches(textLine: String) -> Bool { textLine == "perform applescript" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <ContentType value=\"Text\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Perform AppleScript"
    }
}

struct SendDDEExecuteHandler: FMScriptStepHandler {
    static let id: FMStepID = .sendDDEExecute
    static let name = "Send DDE Execute"
    static func matches(textLine: String) -> Bool { textLine == "send dde execute" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <ContentType value=\"File\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Send DDE Execute"
    }
}

struct SendEventHandler: FMScriptStepHandler {
    static let id: FMStepID = .sendEvent
    static let name = "Send Event"
    static func matches(textLine: String) -> Bool { textLine == "send event" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <ContentType value=\"File\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Send Event"
    }
}

struct SendMailHandler: FMScriptStepHandler {
    static let id: FMStepID = .sendMail
    static let name = "Send Mail"
    static func matches(textLine: String) -> Bool { textLine == "send mail" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Send Mail"
    }
}

struct DialPhoneHandler: FMScriptStepHandler {
    static let id: FMStepID = .dialPhone
    static let name = "Dial Phone"
    static func matches(textLine: String) -> Bool { textLine == "dial phone" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Dial Phone"
    }
}

struct SpeakHandler: FMScriptStepHandler {
    static let id: FMStepID = .speak
    static let name = "Speak"
    static func matches(textLine: String) -> Bool { textLine == "speak" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SpeechOptions WaitForCompletion=\"True\" VoiceId=\"0\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Speak"
    }
}

struct SetDictionaryHandler: FMScriptStepHandler {
    static let id: FMStepID = .setDictionary
    static let name = "Set Dictionary"
    static func matches(textLine: String) -> Bool { textLine == "set dictionary" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <MainDictionary value=\"US English\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Set Dictionary"
    }
}

struct CorrectWordHandler: FMScriptStepHandler {
    static let id: FMStepID = .correctWord
    static let name = "Correct Word"
    static func matches(textLine: String) -> Bool { textLine == "correct word" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Correct Word"
    }
}

struct SpellingOptionsHandler: FMScriptStepHandler {
    static let id: FMStepID = .spellingOptions
    static let name = "Spelling Options"
    static func matches(textLine: String) -> Bool { textLine == "spelling options" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Spelling Options"
    }
}

struct SelectDictionariesHandler: FMScriptStepHandler {
    static let id: FMStepID = .selectDictionaries
    static let name = "Select Dictionaries"
    static func matches(textLine: String) -> Bool { textLine == "select dictionaries" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Select Dictionaries"
    }
}

struct EditUserDictionaryHandler: FMScriptStepHandler {
    static let id: FMStepID = .editUserDictionary
    static let name = "Edit User Dictionary"
    static func matches(textLine: String) -> Bool { textLine == "edit user dictionary" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Edit User Dictionary"
    }
}

struct InstallMenuSetHandler: FMScriptStepHandler {
    static let id: FMStepID = .installMenuSet
    static let name = "Install Menu Set"
    static func matches(textLine: String) -> Bool { textLine == "install menu set" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <CustomMenuSet id=\"1\" name=\"[Standard FileMaker Menus]\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Install Menu Set"
    }
}

struct InstallPluginFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .installPluginFile
    static let name = "Install Plug-In File"
    static func matches(textLine: String) -> Bool { textLine == "install plug-in file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Install Plug-In File"
    }
}

struct SetWebViewerHandler: FMScriptStepHandler {
    static let id: FMStepID = .setWebViewer
    static let name = "Set Web Viewer"
    static func matches(textLine: String) -> Bool { textLine == "set web viewer" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Action value=\"Reset\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Set Web Viewer"
    }
}

struct TriggerClarisConnectFlowHandler: FMScriptStepHandler {
    static let id: FMStepID = .triggerClarisConnectFlow
    static let name = "Trigger Claris Connect Flow"
    static func matches(textLine: String) -> Bool { textLine == "trigger claris connect flow" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n        <SelectAll state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Trigger Claris Connect Flow"
    }
}

struct ConfigureRegionMonitorHandler: FMScriptStepHandler {
    static let id: FMStepID = .configureRegionMonitor
    static let name = "Configure Region Monitor Script"
    static func matches(textLine: String) -> Bool { textLine == "configure region monitor script" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        
        var monitorType = "iBeacon"
        var scriptName = ""
        var rangeName = ""
        var uuid = ""
        var major = ""
        var minor = ""
        
        for part in parts {
            let trimmed = part.trimmingCharacters(in: .whitespacesAndNewlines)
            let lower = trimmed.lowercased()
            
            if lower.hasPrefix("monitor:") {
                monitorType = String(trimmed.dropFirst("monitor:".count)).trimmingCharacters(in: .whitespacesAndNewlines)
            } else if lower.hasPrefix("name:") {
                rangeName = String(trimmed.dropFirst("name:".count)).trimmingCharacters(in: .whitespacesAndNewlines)
            } else if lower.hasPrefix("script:") {
                var s = String(trimmed.dropFirst("script:".count)).trimmingCharacters(in: .whitespacesAndNewlines)
                if s.hasPrefix("\"") && s.hasSuffix("\"") && s.count >= 2 {
                    s = String(s.dropFirst().dropLast())
                }
                scriptName = s
            } else if lower.hasPrefix("uuid:") {
                uuid = String(trimmed.dropFirst("uuid:".count)).trimmingCharacters(in: .whitespacesAndNewlines)
            } else if lower.hasPrefix("major:") {
                major = String(trimmed.dropFirst("major:".count)).trimmingCharacters(in: .whitespacesAndNewlines)
            } else if lower.hasPrefix("minor:") {
                minor = String(trimmed.dropFirst("minor:".count)).trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        let scriptID = FMScriptReference.id(for: scriptName)
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Text></Text>\n        <Script id=\"\(scriptID)\" name=\"\(scriptName)\"></Script>\n        <MonitorType value=\"\(monitorType)\">\n            <RangeName><Calculation><![CDATA[\(rangeName)]]></Calculation></RangeName>\n            <ProximityUUID><Calculation><![CDATA[\(uuid)]]></Calculation></ProximityUUID>\n            <MajorID><Calculation><![CDATA[\(major)]]></Calculation></MajorID>\n            <MinorID><Calculation><![CDATA[\(minor)]]></Calculation></MinorID>\n        </MonitorType>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let type = step.parameters["MonitorType.value"] ?? "iBeacon"
        return "\(pad)\(prefix)Configure Region Monitor Script [ MonitorType: \(type) ]"
    }
}
