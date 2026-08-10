//
//  FMScriptStepHandlers+CoreControlHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Core Control Step Handlers
// ─────────────────────────────────────────────

struct IfStepHandler: FMScriptStepHandler {
    static let id: FMStepID = .ifStep
    static let name = "If"
    static func matches(textLine: String) -> Bool { textLine == "if" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Restore state=\"False\"/>\n        <Calculation><![CDATA[\(bracketContent)]]></Calculation>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)If [ \(step.calculation ?? "") ]"
    }
}

struct ElseIfStepHandler: FMScriptStepHandler {
    static let id: FMStepID = .elseIf
    static let name = "Else If"
    static func matches(textLine: String) -> Bool { textLine == "else if" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Restore state=\"False\"/>\n        <Calculation><![CDATA[\(bracketContent)]]></Calculation>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Else If [ \(step.calculation ?? "") ]"
    }
}

struct ElseStepHandler: FMScriptStepHandler {
    static let id: FMStepID = .elseStep
    static let name = "Else"
    static func matches(textLine: String) -> Bool { textLine == "else" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Restore state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Else"
    }
}

struct EndIfStepHandler: FMScriptStepHandler {
    static let id: FMStepID = .endIf
    static let name = "End If"
    static func matches(textLine: String) -> Bool { textLine == "end if" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)End If"
    }
}

struct LoopStepHandler: FMScriptStepHandler {
    static let id: FMStepID = .loop
    static let name = "Loop"
    static func matches(textLine: String) -> Bool { textLine == "loop" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        var flushVal = "Always"
        if let range = bracketContent.range(of: "flush:", options: .caseInsensitive) {
            let parsed = String(bracketContent[range.upperBound...]).trimmingCharacters(in: .whitespaces)
            let validValues = ["Always", "Minimum", "Defer"]
            if validValues.contains(where: { $0.caseInsensitiveCompare(parsed) == .orderedSame }) {
                flushVal = validValues.first(where: { $0.caseInsensitiveCompare(parsed) == .orderedSame }) ?? "Always"
            }
        }
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Restore state=\"False\"/>\n        <FlushType value=\"\(flushVal)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let flush = step.parameters["FlushType.value"] ?? step.parameters["FlushType"] ?? ""
        if !flush.isEmpty {
            return "\(pad)\(prefix)Loop [ Flush: \(flush) ]"
        }
        return "\(pad)\(prefix)Loop"
    }
}

struct EndLoopStepHandler: FMScriptStepHandler {
    static let id: FMStepID = .endLoop
    static let name = "End Loop"
    static func matches(textLine: String) -> Bool { textLine == "end loop" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)End Loop"
    }
}

struct SetVariableHandler: FMScriptStepHandler {
    static let id: FMStepID = .setVariable
    static let name = "Set Variable"
    static func matches(textLine: String) -> Bool { textLine == "set variable" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        let rawName = parts.first?.trimmingCharacters(in: .whitespaces) ?? "$variable"
        
        var calc = ""
        if parts.count > 1 {
            let remainder = parts[1...].joined(separator: ";")
            calc = remainder.replacingOccurrences(of: "Value:", with: "", options: .caseInsensitive)
                            .trimmingCharacters(in: .whitespaces)
        }
        
        // Critical Paste Trap: Set Variable requires strict nested element schema (<Value><Calculation>...)
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Value>\n            <Calculation><![CDATA[\(calc)]]></Calculation>\n        </Value>\n        <Repetition><Calculation><![CDATA[1]]></Calculation></Repetition>\n        <Name>\(rawName)</Name>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let name = step.parameters["Name.value"] ?? step.parameters["Name"] ?? "$var"
        let calc = step.calculation ?? ""
        return "\(pad)\(prefix)Set Variable [ \(name) ; Value: \(calc) ]"
    }
}

struct AllowUserAbortHandler: FMScriptStepHandler {
    static let id: FMStepID = .allowUserAbort
    static let name = "Allow User Abort"
    static func matches(textLine: String) -> Bool { textLine == "allow user abort" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let state = bracketContent.lowercased() == "off" ? "False" : "True"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Set state=\"\(state)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let state = step.parameters["Set.state"] == "False" ? "Off" : "On"
        return "\(pad)\(prefix)Allow User Abort [ \(state) ]"
    }
}

struct SetErrorCaptureHandler: FMScriptStepHandler {
    static let id: FMStepID = .setErrorCapture
    static let name = "Set Error Capture"
    static func matches(textLine: String) -> Bool { textLine == "set error capture" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let state = bracketContent.lowercased() == "off" ? "False" : "True"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Set state=\"\(state)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let state = step.parameters["Set.state"] == "True" ? "On" : "Off"
        return "\(pad)\(prefix)Set Error Capture [ \(state) ]"
    }
}

struct SetErrorLoggingHandler: FMScriptStepHandler {
    static let id: FMStepID = .setErrorLogging
    static let name = "Set Error Logging"
    static func matches(textLine: String) -> Bool { textLine == "set error logging" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let state = bracketContent.lowercased() == "off" ? "False" : "True"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Option state=\"\(state)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let state = step.parameters["Option.state"] == "True" ? "On" : "Off"
        return "\(pad)\(prefix)Set Error Logging [ \(state) ]"
    }
}

struct HaltScriptHandler: FMScriptStepHandler {
    static let id: FMStepID = .haltScript
    static let name = "Halt Script"
    static func matches(textLine: String) -> Bool { textLine == "halt script" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Halt Script"
    }
}

struct ExitScriptHandler: FMScriptStepHandler {
    static let id: FMStepID = .exitScript
    static let name = "Exit Script"
    static func matches(textLine: String) -> Bool { textLine == "exit script" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let calc = bracketContent.replacingOccurrences(of: "Text Result:", with: "", options: .caseInsensitive)
                                 .trimmingCharacters(in: .whitespaces)
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Calculation><![CDATA[\(calc)]]></Calculation>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let calc = step.calculation ?? ""
        return "\(pad)\(prefix)Exit Script [ Text Result: \(calc) ]"
    }
}

struct PauseResumeScriptHandler: FMScriptStepHandler {
    static let id: FMStepID = .pauseResumeScript
    static let name = "Pause/Resume Script"
    static func matches(textLine: String) -> Bool { textLine == "pause/resume script" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let pauseTime = bracketContent.lowercased().contains("indefinitely") ? "Indefinitely" : "0"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <PauseTime value=\"\(pauseTime)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let pause = step.parameters["PauseTime.value"] ?? "0"
        return "\(pad)\(prefix)Pause/Resume Script [ \(pause) ]"
    }
}

struct PerformScriptHandler: FMScriptStepHandler {
    static let id: FMStepID = .performScript
    static let name = "Perform Script"
    static func matches(textLine: String) -> Bool { textLine == "perform script" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let scriptName = step.parameters["Script.name"] ?? step.parameters["Script"] ?? ""
        let specified = scriptName.isEmpty ? "" : " [ \(scriptName) ]"
        return "\(pad)\(prefix)Perform Script\(specified)"
    }
}

struct PerformScriptOnServerHandler: FMScriptStepHandler {
    static let id: FMStepID = .performScriptOnServer
    static let name = "Perform Script on Server"
    static func matches(textLine: String) -> Bool { textLine == "perform script on server" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let wait = bracketContent.lowercased().contains("wait") ? "True" : "False"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <WaitForCompletion state=\"\(wait)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let wait = step.parameters["WaitForCompletion.state"] == "True" ? "Wait" : "No wait"
        let scriptName = step.parameters["Script.name"] ?? step.parameters["Script"] ?? ""
        let base = "\(pad)\(prefix)Perform Script on Server"
        if !scriptName.isEmpty {
            return "\(base) [ \(scriptName) ; Wait for completion: \(wait) ]"
        }
        return "\(base) [ \(wait) ]"
    }
}

struct PerformScriptOnServerWithCallbackHandler: FMScriptStepHandler {
    static let id: FMStepID = .performScriptOnServerWithCallback
    static let name = "Perform Script on Server with Callback"
    static func matches(textLine: String) -> Bool { textLine == "perform script on server with callback" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <CallbackScriptState value=\"Continue\"/>\n        <CallbackScript/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let scriptName = step.parameters["Script.name"] ?? step.parameters["Script"] ?? ""
        let state = step.parameters["CallbackScriptState.value"] ?? "Continue"
        let base = "\(pad)\(prefix)Perform Script on Server with Callback"
        if !scriptName.isEmpty {
            return "\(base) [ \(scriptName) ; State: \(state) ]"
        }
        return base
    }
}

struct InstallOnTimerScriptHandler: FMScriptStepHandler {
    static let id: FMStepID = .installOnTimerScript
    static let name = "Install OnTimer Script"
    static func matches(textLine: String) -> Bool { textLine == "install ontimer script" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let parts = bracketContent.components(separatedBy: ";")
        var scriptName = parts.first?.trimmingCharacters(in: .whitespaces) ?? ""
        if scriptName.hasPrefix("\"") && scriptName.hasSuffix("\"") && scriptName.count >= 2 {
            scriptName = String(scriptName.dropFirst().dropLast())
        }
        
        var interval = ""
        if parts.count > 1, let range = parts[1].range(of: "interval:", options: .caseInsensitive) {
            interval = String(parts[1][range.upperBound...]).trimmingCharacters(in: .whitespaces)
        }
        
        let scriptID = FMScriptReference.id(for: scriptName)
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Interval><Calculation><![CDATA[\(interval)]]></Calculation></Interval>\n        <Script id=\"\(scriptID)\" name=\"\(scriptName)\"></Script>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let scriptName = step.parameters["Script.name"] ?? step.parameters["Script"] ?? ""
        let interval = step.parameters["Interval"] ?? step.calculation ?? ""
        let base = "\(pad)\(prefix)Install OnTimer Script"
        if !scriptName.isEmpty || !interval.isEmpty {
            return "\(base) [ \(scriptName) ; Interval: \(interval) ]"
        }
        return base
    }
}

struct SetUseSystemFormatsHandler: FMScriptStepHandler {
    static let id: FMStepID = .setUseSystemFormats
    static let name = "Set Use System Formats"
    static func matches(textLine: String) -> Bool { textLine == "set use system formats" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let state = bracketContent.lowercased() == "off" ? "False" : "True"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Set state=\"\(state)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let state = step.parameters["Set.state"] == "False" ? "Off" : "On"
        return "\(pad)\(prefix)Set Use System Formats [ \(state) ]"
    }
}

struct FlushCacheToDiskHandler: FMScriptStepHandler {
    static let id: FMStepID = .flushCacheToDisk
    static let name = "Flush Cache to Disk"
    static func matches(textLine: String) -> Bool { textLine == "flush cache to disk" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Flush Cache to Disk"
    }
}

struct ExitApplicationHandler: FMScriptStepHandler {
    static let id: FMStepID = .exitApplication
    static let name = "Exit Application"
    static func matches(textLine: String) -> Bool { textLine == "exit application" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Exit Application"
    }
}

struct BeepHandler: FMScriptStepHandler {
    static let id: FMStepID = .beep
    static let name = "Beep"
    static func matches(textLine: String) -> Bool { textLine == "beep" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Beep"
    }
}

struct SetMultiUserHandler: FMScriptStepHandler {
    static let id: FMStepID = .setMultiUser
    static let name = "Set Multi-User"
    static func matches(textLine: String) -> Bool { textLine == "set multi-user" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let val = bracketContent.lowercased().contains("off") ? "False" : "True"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <MultiUser value=\"\(val)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let val = step.parameters["MultiUser.value"] == "False" ? "Off" : "On"
        return "\(pad)\(prefix)Set Multi-User [ \(val) ]"
    }
}

struct SetZoomLevelHandler: FMScriptStepHandler {
    static let id: FMStepID = .setZoomLevel
    static let name = "Set Zoom Level"
    static func matches(textLine: String) -> Bool { textLine == "set zoom level" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let zoom = bracketContent.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let zoomVal = zoom.isEmpty ? "100" : zoom
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Zoom value=\"\(zoomVal)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let zoom = step.parameters["Zoom.value"] ?? "100"
        return "\(pad)\(prefix)Set Zoom Level [ \(zoom)% ]"
    }
}

struct OpenURLHandler: FMScriptStepHandler {
    static let id: FMStepID = .openURL
    static let name = "Open URL"
    static func matches(textLine: String) -> Bool { textLine == "open url" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open URL"
    }
}

struct AllowFormattingBarHandler: FMScriptStepHandler {
    static let id: FMStepID = .allowFormattingBar
    static let name = "Allow Formatting Bar"
    static func matches(textLine: String) -> Bool { textLine == "allow formatting bar" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let state = bracketContent.lowercased() == "on" ? "True" : "False"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Set state=\"\(state)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let state = step.parameters["Set.state"] == "True" ? "On" : "Off"
        return "\(pad)\(prefix)Allow Formatting Bar [ \(state) ]"
    }
}
