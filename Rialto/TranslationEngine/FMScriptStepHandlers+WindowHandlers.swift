//
//  FMScriptStepHandlers+WindowHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Window Handlers
// ─────────────────────────────────────────────

struct AdjustWindowHandler: FMScriptStepHandler {
    static let id: FMStepID = .adjustWindow
    static let name = "Adjust Window"
    static func matches(textLine: String) -> Bool { textLine == "adjust window" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let state = bracketContent.lowercased().contains("resize") ? "ResizeToFit" : "ReduceToFit"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <WindowState value=\"\(state)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let state = step.parameters["WindowState.value"] ?? "ResizeToFit"
        return "\(pad)\(prefix)Adjust Window [ \(state) ]"
    }
}

struct ArrangeAllWindowsHandler: FMScriptStepHandler {
    static let id: FMStepID = .arrangeAllWindows
    static let name = "Arrange All Windows"
    static func matches(textLine: String) -> Bool { textLine == "arrange all windows" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <WindowArrangement value=\"TileHorizontally\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Arrange All Windows"
    }
}

struct CloseWindowHandler: FMScriptStepHandler {
    static let id: FMStepID = .closeWindow
    static let name = "Close Window"
    static func matches(textLine: String) -> Bool { textLine == "close window" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let window = bracketContent.lowercased().contains("name") ? "Name" : "Current"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Window value=\"\(window)\"/>\n        <LimitToWindowsOfCurrentFile state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let window = step.parameters["Window.value"] ?? "Current"
        return "\(pad)\(prefix)Close Window [ \(window) ]"
    }
}

struct FreezeWindowHandler: FMScriptStepHandler {
    static let id: FMStepID = .freezeWindow
    static let name = "Freeze Window"
    static func matches(textLine: String) -> Bool { textLine == "freeze window" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Freeze Window"
    }
}

struct MoveResizeWindowHandler: FMScriptStepHandler {
    static let id: FMStepID = .moveResizeWindow
    static let name = "Move/Resize Window"
    static func matches(textLine: String) -> Bool { textLine == "move/resize window" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Window value=\"Current\"/>\n        <LimitToWindowsOfCurrentFile state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Move/Resize Window"
    }
}

struct NewWindowHandler: FMScriptStepHandler {
    static let id: FMStepID = .newWindow
    static let name = "New Window"
    static func matches(textLine: String) -> Bool { textLine == "new window" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <LayoutDestination value=\"CurrentLayout\"/>\n        <NewWndStyles Style=\"Document\" Close=\"Yes\" Minimize=\"Yes\" Maximize=\"Yes\" Resize=\"Yes\" Styles=\"3606018\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)New Window"
    }
}

struct RefreshWindowHandler: FMScriptStepHandler {
    static let id: FMStepID = .refreshWindow
    static let name = "Refresh Window"
    static func matches(textLine: String) -> Bool { textLine == "refresh window" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Option state=\"False\"/>\n        <FlushSQLData state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Refresh Window"
    }
}

struct ScrollWindowHandler: FMScriptStepHandler {
    static let id: FMStepID = .scrollWindow
    static let name = "Scroll Window"
    static func matches(textLine: String) -> Bool { textLine == "scroll window" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <ScrollOperation value=\"Home\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Scroll Window"
    }
}

struct SelectWindowHandler: FMScriptStepHandler {
    static let id: FMStepID = .selectWindow
    static let name = "Select Window"
    static func matches(textLine: String) -> Bool { textLine == "select window" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Window value=\"Current\"/>\n        <LimitToWindowsOfCurrentFile state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Select Window"
    }
}

struct SetWindowTitleHandler: FMScriptStepHandler {
    static let id: FMStepID = .setWindowTitle
    static let name = "Set Window Title"
    static func matches(textLine: String) -> Bool { textLine == "set window title" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Window value=\"Current\"/>\n        <LimitToWindowsOfCurrentFile state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Set Window Title"
    }
}

struct ShowHideMenubarHandler: FMScriptStepHandler {
    static let id: FMStepID = .showHideMenubar
    static let name = "Show/Hide Menubar"
    static func matches(textLine: String) -> Bool { textLine == "show/hide menubar" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let val = bracketContent.lowercased().contains("show") ? "Show" : "Hide"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <ShowHide value=\"\(val)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let val = step.parameters["ShowHide.value"] ?? "Show"
        return "\(pad)\(prefix)Show/Hide Menubar [ \(val) ]"
    }
}

struct ShowHideToolbarsHandler: FMScriptStepHandler {
    static let id: FMStepID = .showHideToolbars
    static let name = "Show/Hide Toolbars"
    static func matches(textLine: String) -> Bool { textLine == "show/hide toolbars" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let val = bracketContent.lowercased().contains("show") ? "Show" : "Hide"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <ShowHide value=\"\(val)\"/>\n        <IncludeEditRecordToolbar state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let val = step.parameters["ShowHide.value"] ?? "Show"
        return "\(pad)\(prefix)Show/Hide Toolbars [ \(val) ]"
    }
}

struct ShowHideTextRulerHandler: FMScriptStepHandler {
    static let id: FMStepID = .showHideTextRuler
    static let name = "Show/Hide Text Ruler"
    static func matches(textLine: String) -> Bool { textLine == "show/hide text ruler" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let val = bracketContent.lowercased().contains("hide") ? "Hide" : "Show"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <ShowHide value=\"\(val)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let val = step.parameters["ShowHide.value"] ?? "Show"
        return "\(pad)\(prefix)Show/Hide Text Ruler [ \(val) ]"
    }
}

struct ViewAsHandler: FMScriptStepHandler {
    static let id: FMStepID = .viewAs
    static let name = "View As"
    static func matches(textLine: String) -> Bool { textLine == "view as" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let view = bracketContent.lowercased().contains("form") ? "Form" : bracketContent.lowercased().contains("list") ? "List" : "Cycle"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <View value=\"\(view)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let view = step.parameters["View.value"] ?? "Cycle"
        return "\(pad)\(prefix)View As [ \(view) ]"
    }
}

struct ClosePopoverHandler: FMScriptStepHandler {
    static let id: FMStepID = .closePopover
    static let name = "Close Popover"
    static func matches(textLine: String) -> Bool { textLine == "close popover" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Close Popover"
    }
}

struct SetLayoutObjectAnimationHandler: FMScriptStepHandler {
    static let id: FMStepID = .setLayoutObjectAnimation
    static let name = "Set Layout Object Animation"
    static func matches(textLine: String) -> Bool { textLine == "set layout object animation" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let state = bracketContent.lowercased() == "off" ? "False" : "True"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Set state=\"\(state)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let state = step.parameters["Set.state"] == "False" ? "Off" : "On"
        return "\(pad)\(prefix)Set Layout Object Animation [ \(state) ]"
    }
}

struct RefreshObjectHandler: FMScriptStepHandler {
    static let id: FMStepID = .refreshObject
    static let name = "Refresh Object"
    static func matches(textLine: String) -> Bool { textLine == "refresh object" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Refresh Object"
    }
}

struct RefreshPortalHandler: FMScriptStepHandler {
    static let id: FMStepID = .refreshPortal
    static let name = "Refresh Portal"
    static func matches(textLine: String) -> Bool { textLine == "refresh portal" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Refresh Portal"
    }
}

struct PerformJavaScriptInWebViewerHandler: FMScriptStepHandler {
    static let id: FMStepID = .performJavaScriptInWebViewer
    static let name = "Perform JavaScript in Web Viewer"
    static func matches(textLine: String) -> Bool { textLine == "perform javascript in web viewer" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Perform JavaScript in Web Viewer"
    }
}

struct AVPlayerPlayHandler: FMScriptStepHandler {
    static let id: FMStepID = .avPlayerPlay
    static let name = "AVPlayer Play"
    static func matches(textLine: String) -> Bool { textLine == "avplayer play" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Source value=\"Object\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)AVPlayer Play"
    }
}

struct AVPlayerSetPlaybackStateHandler: FMScriptStepHandler {
    static let id: FMStepID = .avPlayerSetPlaybackState
    static let name = "AVPlayer Set Playback State"
    static func matches(textLine: String) -> Bool { textLine == "avplayer set playback state" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let state = bracketContent.lowercased().contains("pause") ? "Paused" : bracketContent.lowercased().contains("play") ? "Playing" : "Stopped"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <PlaybackState value=\"\(state)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let state = step.parameters["PlaybackState.value"] ?? "Stopped"
        return "\(pad)\(prefix)AVPlayer Set Playback State [ \(state) ]"
    }
}

struct AVPlayerSetOptionsHandler: FMScriptStepHandler {
    static let id: FMStepID = .avPlayerSetOptions
    static let name = "AVPlayer Set Options"
    static func matches(textLine: String) -> Bool { textLine == "avplayer set options" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)AVPlayer Set Options"
    }
}

struct EnableTouchKeyboardHandler: FMScriptStepHandler {
    static let id: FMStepID = .enableTouchKeyboard
    static let name = "Enable Touch Keyboard"
    static func matches(textLine: String) -> Bool { textLine == "enable touch keyboard" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let val = bracketContent.lowercased().contains("hide") ? "Hide" : "Show"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <ShowHide value=\"\(val)\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let val = step.parameters["ShowHide.value"] ?? "Show"
        return "\(pad)\(prefix)Enable Touch Keyboard [ \(val) ]"
    }
}
