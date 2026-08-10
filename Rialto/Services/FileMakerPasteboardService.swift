//
//  FileMakerPasteboardService.swift
//  Rialto
//
//  Created by Richie Whyte on 21/07/2026.
//

import AppKit

enum PasteboardError: LocalizedError {
    case encodingFailed
    case noDataFound
    case decodingFailed(firstBytesHex: String)

    var errorDescription: String? {
        switch self {
        case .encodingFailed:
            return "Failed to encode XML as UTF-16."
        case .noDataFound:
            return "No FileMaker data found on clipboard. Copy script steps in FileMaker first (⌘C)."
        case .decodingFailed(let hex):
            return "Could not decode FM clipboard data. First bytes: \(hex)"
        }
    }
}

enum FileMakerPasteboardService {
    private static let fmType = NSPasteboard.PasteboardType("com.filemaker.script-step")
    private static let legacyType = NSPasteboard.PasteboardType("CorePasteboardFlavorType 0x584D5353")

    static func copyToFileMaker(xmlText: String) -> Result<Void, Error> {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()

        // Ensure the XML is properly wrapped in the fmxmlsnippet envelope
        var xml = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !xml.contains("fmxmlsnippet") {
            xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<fmxmlsnippet type=\"FMObjectList\">\n\(xml)\n</fmxmlsnippet>"
        }
        if !xml.hasPrefix("<?xml") {
            xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" + xml
        }

        guard let utf16Data = xml.data(using: .utf16) else {
            return .failure(PasteboardError.encodingFailed)
        }

        pasteboard.declareTypes([fmType, legacyType, .string], owner: nil)
        pasteboard.setData(utf16Data, forType: fmType)
        pasteboard.setData(utf16Data, forType: legacyType)
        pasteboard.setString(xml, forType: .string)
        return .success(())
    }

    static func copyPlainText(_ plainText: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(plainText, forType: .string)
    }

    /// Copies an arbitrary plain-text string to the system clipboard.
    /// Used e.g. to let the user copy the "Unhandled Script Steps" list as
    /// text instead of taking a screenshot.
    static func copyString(_ string: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(string, forType: .string)
    }

    static func readPlainText() -> String? {
        return NSPasteboard.general.string(forType: .string)
    }

    static func readFromFileMaker() -> Result<String, Error> {
        let pasteboard = NSPasteboard.general

        for type in [fmType, legacyType] {
            guard let data = pasteboard.data(forType: type) else { continue }

            // Try encodings in order of likelihood for FM clipboard data
            let encodings: [String.Encoding] = [
                .utf16,
                .utf16LittleEndian,
                .utf16BigEndian,
                .utf8,
                .isoLatin1,
                .windowsCP1252
            ]

            for encoding in encodings {
                if let str = String(data: data, encoding: encoding),
                   str.contains("<Step") || str.contains("fmxmlsnippet") {
                    let formatted = str.replacingOccurrences(of: "</Step>", with: "</Step>\n")
                    return .success(formatted)
                }
            }

            // No encoding produced valid FM XML — return first bytes hex for debugging
            let hex = data.prefix(32).map { String(format: "%02x", $0) }.joined(separator: " ")
            return .failure(PasteboardError.decodingFailed(firstBytesHex: hex))
        }

        // Fallback: plain string clipboard that already looks like FM XML
        if let str = pasteboard.string(forType: .string),
           str.contains("fmxmlsnippet") || str.contains("<Step") {
            let formatted = str.replacingOccurrences(of: "</Step>", with: "</Step>\n")
            return .success(formatted)
        }

        return .failure(PasteboardError.noDataFound)
    }
}
