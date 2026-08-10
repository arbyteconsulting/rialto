//
//  FMScriptStepHandlers+FilesHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - Files Handlers
// ─────────────────────────────────────────────

struct NewFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .newFile
    static let name = "New File"
    static func matches(textLine: String) -> Bool { textLine == "new file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)New File"
    }
}

struct OpenFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .openFile
    static let name = "Open File"
    static func matches(textLine: String) -> Bool { textLine == "open file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Option state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open File"
    }
}

struct CloseFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .closeFile
    static let name = "Close File"
    static func matches(textLine: String) -> Bool { textLine == "close file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Close File"
    }
}

struct CreateDataFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .createDataFile
    static let name = "Create Data File"
    static func matches(textLine: String) -> Bool { textLine == "create data file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <CreateDirectories state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Create Data File"
    }
}

struct OpenDataFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .openDataFile
    static let name = "Open Data File"
    static func matches(textLine: String) -> Bool { textLine == "open data file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Open Data File"
    }
}

struct CloseDataFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .closeDataFile
    static let name = "Close Data File"
    static func matches(textLine: String) -> Bool { textLine == "close data file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Close Data File"
    }
}

struct ReadFromDataFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .readFromDataFile
    static let name = "Read from Data File"
    static func matches(textLine: String) -> Bool { textLine == "read from data file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <DataSourceType value=\"3\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Read from Data File"
    }
}

struct WriteToDataFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .writeToDataFile
    static let name = "Write to Data File"
    static func matches(textLine: String) -> Bool { textLine == "write to data file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <AppendLineFeed state=\"True\"/>\n        <DataSourceType value=\"1\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Write to Data File"
    }
}

struct GetDataFilePositionHandler: FMScriptStepHandler {
    static let id: FMStepID = .getDataFilePosition
    static let name = "Get Data File Position"
    static func matches(textLine: String) -> Bool { textLine == "get data file position" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Get Data File Position"
    }
}

struct SetDataFilePositionHandler: FMScriptStepHandler {
    static let id: FMStepID = .setDataFilePosition
    static let name = "Set Data File Position"
    static func matches(textLine: String) -> Bool { textLine == "set data file position" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Set Data File Position"
    }
}

struct GetFileExistsHandler: FMScriptStepHandler {
    static let id: FMStepID = .getFileExists
    static let name = "Get File Exists"
    static func matches(textLine: String) -> Bool { textLine == "get file exists" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Get File Exists"
    }
}

struct GetFileSizeHandler: FMScriptStepHandler {
    static let id: FMStepID = .getFileSize
    static let name = "Get File Size"
    static func matches(textLine: String) -> Bool { textLine == "get file size" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Get File Size"
    }
}

struct DeleteFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .deleteFile
    static let name = "Delete File"
    static func matches(textLine: String) -> Bool { textLine == "delete file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Delete File"
    }
}

struct RenameFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .renameFile
    static let name = "Rename File"
    static func matches(textLine: String) -> Bool { textLine == "rename file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\"/>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Rename File"
    }
}

struct RecoverFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .recoverFile
    static let name = "Recover File"
    static func matches(textLine: String) -> Bool { textLine == "recover file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"True\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Recover File"
    }
}

struct GetFolderPathHandler: FMScriptStepHandler {
    static let id: FMStepID = .getFolderPath
    static let name = "Get Folder Path"
    static func matches(textLine: String) -> Bool { textLine == "get folder path" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <AllowFolderCreation state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Get Folder Path"
    }
}

struct ConvertFileHandler: FMScriptStepHandler {
    static let id: FMStepID = .convertFile
    static let name = "Convert File"
    static func matches(textLine: String) -> Bool { textLine == "convert file" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"False\"/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Convert File"
    }
}

struct TruncateTableHandler: FMScriptStepHandler {
    static let id: FMStepID = .truncateTable
    static let name = "Truncate Table"
    static func matches(textLine: String) -> Bool { textLine == "truncate table" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let noInteractState: Bool
        
        if bracketContent.isEmpty {
            noInteractState = false
        } else {
            // Parse structured format: "With dialog: Off ; Table: <Current Table>"
            let components = bracketContent.components(separatedBy: ";")
                .map { $0.trimmingCharacters(in: .whitespaces) }
            
            var tableName: String?
            var dialogFound = false
            var dialogOn = true
            
            for comp in components {
                let low = comp.lowercased()
                if low.hasPrefix("with dialog:") {
                    dialogFound = true
                    let val = comp.dropFirst("With dialog:".count).trimmingCharacters(in: .whitespaces)
                    dialogOn = val.lowercased() != "off"
                } else if low.hasPrefix("table:") {
                    tableName = comp.dropFirst("Table:".count).trimmingCharacters(in: .whitespaces)
                } else if low.hasPrefix("no dialog") {
                    dialogFound = true
                    dialogOn = false
                }
            }
            
            noInteractState = dialogFound ? !dialogOn : false
            
            if let tn = tableName, !tn.isEmpty {
                // XML-entity-escape the table name (character-by-character to avoid tool chain entity corruption)
                let escaped = Self.xmlEscape(tn)
                return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"\(noInteractState ? "True" : "False")\"></NoInteract>\n        <BaseTable id=\"-1\" name=\"\(escaped)\"></BaseTable>\n    </Step>"
            }
        }
        
        let defaultTable = "\u{3C}Current Table\u{3E}"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <NoInteract state=\"\(noInteractState ? "True" : "False")\"></NoInteract>\n        <BaseTable id=\"-1\" name=\"\(defaultTable)\"></BaseTable>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let noInteract = step.parameters["NoInteract.state"]
        let dialog = noInteract == "True" ? "No dialog" : "With dialog"
        let rawName = step.parameters["BaseTable.name"] ?? step.parameters["name"] ?? "<Current Table>"
        return "\(pad)\(prefix)Truncate Table [ \(dialog) ; Table: \(rawName) ]"
    }
    
    /// XML-entity-escape a string value. Uses unicode escapes to avoid tool-chain corruption.
    private static func xmlEscape(_ s: String) -> String {
        var result = ""
        for ch in s {
            switch ch {
            case "\u{0026}": result += "\u{0026}\u{0061}\u{006D}\u{0070}\u{003B}" // &
            case "\u{003C}": result += "\u{0026}\u{006C}\u{0074}\u{003B}"       // <
            case "\u{003E}": result += "\u{0026}\u{0067}\u{0074}\u{003B}"       // >
            default:         result.append(ch)
            }
        }
        return result
    }
}
