//
//  FMScriptStepHandlers+HardwareMobileHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Hardware & Mobile Handlers
// ─────────────────────────────────────────────

struct ConfigureLocalNotificationHandler: FMScriptStepHandler {
    static let id: FMStepID = .configureLocalNotification
    static let name = "Configure Local Notification"
    static func matches(textLine: String) -> Bool { textLine == "configure local notification" }
    
    private static let fieldLabels: [(label: String, key: String)] = [
        ("name:", "Name"),
        ("delay:", "Delay"),
        ("title:", "Title"),
        ("body:", "Body"),
        ("button 1 label:", "Button1Label"),
        ("button 2 label:", "Button2Label"),
        ("button 3 label:", "Button3Label"),
        ("button 1 foreground:", "Button1ForceFgnd"),
        ("button 2 foreground:", "Button2ForceFgnd"),
        ("button 3 foreground:", "Button3ForceFgnd"),
        ("show when app in foreground:", "ShowWhenAppInForeground")
    ]
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        
        var action = "Queue"
        var scriptName = ""
        var values: [String: String] = [:]
        
        for part in parts {
            let trimmed = part.trimmingCharacters(in: .whitespacesAndNewlines)
            let lower = trimmed.lowercased()
            
            if lower.hasPrefix("action:") {
                action = String(trimmed.dropFirst("action:".count)).trimmingCharacters(in: .whitespacesAndNewlines)
                continue
            }
            if lower.hasPrefix("script:") {
                var s = String(trimmed.dropFirst("script:".count)).trimmingCharacters(in: .whitespacesAndNewlines)
                if s.hasPrefix("\"") && s.hasSuffix("\"") && s.count >= 2 {
                    s = String(s.dropFirst().dropLast())
                }
                scriptName = s
                continue
            }
            for (label, key) in fieldLabels where lower.hasPrefix(label) {
                values[key] = String(trimmed.dropFirst(label.count)).trimmingCharacters(in: .whitespacesAndNewlines)
                break
            }
        }
        
        var inner = ""
        for (_, key) in fieldLabels {
            if let val = values[key] {
                inner += "<\(key)><Calculation><![CDATA[\(val)]]></Calculation></\(key)>"
            }
        }
        
        let scriptID = FMScriptReference.id(for: scriptName)
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Script id=\"\(scriptID)\" name=\"\(scriptName)\"></Script>\n        <Action value=\"\(action)\">\(inner)</Action>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let action = step.parameters["Action.value"] ?? "Queue"
        return "\(pad)\(prefix)Configure Local Notification [ Action: \(action) ]"
    }
}

struct ConfigureNFCReadingHandler: FMScriptStepHandler {
    static let id: FMStepID = .configureNFCReading
    static let name = "Configure NFC Reading"
    static func matches(textLine: String) -> Bool { textLine == "configure nfc reading" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        
        var action = "Read"
        var scriptName = ""
        var timeout = ""
        var continuousReading = ""
        var jsonOutput = ""
        
        for part in parts {
            let trimmed = part.trimmingCharacters(in: .whitespacesAndNewlines)
            let lower = trimmed.lowercased()
            
            if lower.hasPrefix("action:") {
                action = String(trimmed.dropFirst("action:".count)).trimmingCharacters(in: .whitespacesAndNewlines)
            } else if lower.hasPrefix("script:") {
                var s = String(trimmed.dropFirst("script:".count)).trimmingCharacters(in: .whitespacesAndNewlines)
                if s.hasPrefix("\"") && s.hasSuffix("\"") && s.count >= 2 {
                    s = String(s.dropFirst().dropLast())
                }
                scriptName = s
            } else if lower.hasPrefix("timeout:") {
                timeout = String(trimmed.dropFirst("timeout:".count)).trimmingCharacters(in: .whitespacesAndNewlines)
            } else if lower.hasPrefix("continuous reading:") {
                continuousReading = String(trimmed.dropFirst("continuous reading:".count)).trimmingCharacters(in: .whitespacesAndNewlines)
            } else if lower.hasPrefix("format result as json:") {
                jsonOutput = String(trimmed.dropFirst("format result as json:".count)).trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        let scriptID = FMScriptReference.id(for: scriptName)
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Script id=\"\(scriptID)\" name=\"\(scriptName)\"></Script>\n        <Action value=\"\(action)\">\n            <Timeout><Calculation><![CDATA[\(timeout)]]></Calculation></Timeout>\n            <ReadMultiple><Calculation><![CDATA[\(continuousReading)]]></Calculation></ReadMultiple>\n            <JSONOutput><Calculation><![CDATA[\(jsonOutput)]]></Calculation></JSONOutput>\n        </Action>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let action = step.parameters["Action.value"] ?? "Read"
        return "\(pad)\(prefix)Configure NFC Reading [ Action: \(action) ]"
    }
}
