//
//  FMScriptStepHandlers+ToggleHelpers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Utility: Simple On/Off toggles
// ─────────────────────────────────────────────

/// Helper for steps with a simple `<Set state="True/False"/>` pattern
struct SimpleSetToggleHandler: FMScriptStepHandler {
    static var id: FMStepID { fatalError("override") }
    static var name: String { fatalError("override") }
    static func matches(textLine: String) -> Bool { false }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let state = bracketContent.lowercased() == "off" ? "False" : "True"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Set state=\"\(state)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let state = step.parameters["Set.state"] == "False" ? "Off" : "On"
        return "\(pad)\(prefix)\(name) [ \(state) ]"
    }
}
