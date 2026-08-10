//
//  FMScriptStepHandlers+UIPanelHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - UI Panel Openers
// ─────────────────────────────────────────────

struct OpenScriptWorkspaceHandler: FMScriptStepHandler {
    static let id: FMStepID = .openScriptWorkspace
    static let name = "Open Script Workspace"
    static func matches(textLine: String) -> Bool { textLine == "open script workspace" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Script Workspace"
    }
}

struct OpenManageDatabaseHandler: FMScriptStepHandler {
    static let id: FMStepID = .openManageDatabase
    static let name = "Open Manage Database"
    static func matches(textLine: String) -> Bool { textLine == "open manage database" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Manage Database"
    }
}

struct OpenManageLayoutsHandler: FMScriptStepHandler {
    static let id: FMStepID = .openManageLayouts
    static let name = "Open Manage Layouts"
    static func matches(textLine: String) -> Bool { textLine == "open manage layouts" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Manage Layouts"
    }
}

struct OpenManageThemesHandler: FMScriptStepHandler {
    static let id: FMStepID = .openManageThemes
    static let name = "Open Manage Themes"
    static func matches(textLine: String) -> Bool { textLine == "open manage themes" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Manage Themes"
    }
}

struct OpenManageValueListsHandler: FMScriptStepHandler {
    static let id: FMStepID = .openManageValueLists
    static let name = "Open Manage Value Lists"
    static func matches(textLine: String) -> Bool { textLine == "open manage value lists" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Manage Value Lists"
    }
}

struct OpenManageDataSourcesHandler: FMScriptStepHandler {
    static let id: FMStepID = .openManageDataSources
    static let name = "Open Manage Data Sources"
    static func matches(textLine: String) -> Bool { textLine == "open manage data sources" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Manage Data Sources"
    }
}

struct OpenManageContainersHandler: FMScriptStepHandler {
    static let id: FMStepID = .openManageContainers
    static let name = "Open Manage Containers"
    static func matches(textLine: String) -> Bool { textLine == "open manage containers" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Manage Containers"
    }
}

struct OpenFavoritesHandler: FMScriptStepHandler {
    static let id: FMStepID = .openFavorites
    static let name = "Open Favorites"
    static func matches(textLine: String) -> Bool { textLine == "open favorites" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Favorites"
    }
}

struct OpenHostsHandler: FMScriptStepHandler {
    static let id: FMStepID = .openHosts
    static let name = "Open Hosts"
    static func matches(textLine: String) -> Bool { textLine == "open hosts" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Hosts"
    }
}

struct OpenHelpHandler: FMScriptStepHandler {
    static let id: FMStepID = .openHelp
    static let name = "Open Help"
    static func matches(textLine: String) -> Bool { textLine == "open help" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Help"
    }
}

struct OpenSettingsHandler: FMScriptStepHandler {
    static let id: FMStepID = .openSettings
    static let name = "Open Settings"
    static func matches(textLine: String) -> Bool { textLine == "open settings" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Settings"
    }
}

struct OpenFileOptionsHandler: FMScriptStepHandler {
    static let id: FMStepID = .openFileOptions
    static let name = "Open File Options"
    static func matches(textLine: String) -> Bool { textLine == "open file options" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open File Options"
    }
}

struct OpenSharingHandler: FMScriptStepHandler {
    static let id: FMStepID = .openSharing
    static let name = "Open Sharing"
    static func matches(textLine: String) -> Bool { textLine == "open sharing" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Sharing"
    }
}

struct OpenFindReplaceHandler: FMScriptStepHandler {
    static let id: FMStepID = .openFindReplace
    static let name = "Open Find/Replace"
    static func matches(textLine: String) -> Bool { textLine == "open find/replace" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Find/Replace"
    }
}

struct OpenEditSavedFindsHandler: FMScriptStepHandler {
    static let id: FMStepID = .openEditSavedFinds
    static let name = "Open Edit Saved Finds"
    static func matches(textLine: String) -> Bool { textLine == "open edit saved finds" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Edit Saved Finds"
    }
}

struct OpenUploadToHostHandler: FMScriptStepHandler {
    static let id: FMStepID = .openUploadToHost
    static let name = "Open Upload to Host"
    static func matches(textLine: String) -> Bool { textLine == "open upload to host" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Upload to Host"
    }
}

struct SaveCopyAsXMLHandler: FMScriptStepHandler {
    static let id: FMStepID = .saveCopyAsXML
    static let name = "Save a Copy as XML"
    static func matches(textLine: String) -> Bool { textLine == "save a copy as xml" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Option state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Save a Copy as XML"
    }
}
