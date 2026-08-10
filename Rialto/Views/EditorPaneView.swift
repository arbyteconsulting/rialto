//
//  EditorPaneView.swift
//  Rialto
//
//  Created by Richie Whyte on 15/06/2026.
//

import SwiftUI

struct EditorPaneView: View {
    // Core structural parameters
    let title: String
    let subtitle: String
    let systemImage: String
    let accentColor: Color
    @Binding var text: String
    let placeholder: String
    let isHighlighted: Bool
    
    // Required action closures
    let onCopy: () -> Void
    let onPaste: () -> Void
    let onClear: () -> Void
    let onSample: () -> Void
    var onPasteFromFM: (() -> Void)? = nil
    
    // Optional configuration properties
    var copyLabel: String = "Copy"
    var pasteLabel: String = "Paste"
    var showCopyButton: Bool = true
    var showGenericPasteButton: Bool = true

    var body: some View {
        VStack(spacing: 0) {
            // Header Component
            PaneHeaderBar(
                title: title,
                subtitle: subtitle,
                systemImage: systemImage,
                accentColor: accentColor,
                textCount: text.count,
                onClear: onClear,
                onSample: onSample
            )

            // Monospaced Code Frame Panel
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(Font.FMFont.codeEditor)
                        .foregroundColor(Color.FMTheme.placeholder)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .lineSpacing(4)
                }

                TextEditor(text: $text)
                    .font(Font.FMFont.codeEditor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .scrollContentBackground(.hidden)
            }
            .background(isHighlighted ? accentColor.opacity(0.08) : Color.FMTheme.panelBackground)

            Divider()
                .background(Color.FMTheme.divider)

            // Footer Actions Component
            PaneFooterBar(
                copyLabel: copyLabel,
                pasteLabel: pasteLabel,
                showCopyButton: showCopyButton,
                showGenericPasteButton: showGenericPasteButton,
                onCopy: onCopy,
                onPaste: onPaste,
                onPasteFromFM: onPasteFromFM
            )
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - Internal Helper Components
// ─────────────────────────────────────────────

struct PaneHeaderBar: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let accentColor: Color
    let textCount: Int
    let onClear: () -> Void
    let onSample: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: systemImage)
                .font(.title3)
                .foregroundColor(accentColor)

            VStack(alignment: .leading, spacing: 1) {
                Text(title)
                    .font(Font.FMFont.panelTitle)
                    .foregroundColor(Color.FMTheme.textPrimary)
                Text(subtitle)
                    .font(Font.FMFont.headerSubtitle)
                    .foregroundColor(Color.FMTheme.textSecondary)
            }

            Spacer()

            if textCount > 0 {
                // Fixed: Explicit closure block execution
                Button("Clear", action: { onClear() })
                    .buttonStyle(.borderless)
                    .font(Font.FMFont.infoLabel)
            } else {
                // Fixed: Explicit closure block execution
                Button("Load Sample", action: { onSample() })
                    .buttonStyle(.borderless)
                    .font(Font.FMFont.infoLabel)
                    .foregroundColor(accentColor)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.FMTheme.background)
    }
}

struct PaneFooterBar: View {
    let copyLabel: String
    var pasteLabel: String = "Paste"
    var showCopyButton: Bool = true
    var showGenericPasteButton: Bool = true
    let onCopy: () -> Void
    let onPaste: () -> Void
    var onPasteFromFM: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 8) {
            if showCopyButton {
                // Fixed: Explicit execution wrap
                Button(action: { onCopy() }) {
                    Label(copyLabel, systemImage: "doc.on.doc")
                }
                .buttonStyle(.borderedProminent)
            }

            if showGenericPasteButton {
                if showCopyButton {
                    Button(action: { onPaste() }) {
                        Label(pasteLabel, systemImage: "doc.on.clipboard")
                    }
                    .buttonStyle(.bordered)
                } else {
                    // Sole primary action for this pane — style it prominent.
                    Button(action: { onPaste() }) {
                        Label(pasteLabel, systemImage: "doc.on.clipboard")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }

            if let pasteFM = onPasteFromFM {
                // Fixed: Explicit execution wrap
                Button(action: { pasteFM() }) {
                    Text("Paste Raw Clipboard")
                }
                .buttonStyle(.bordered)
            }
            Spacer()
        }
        .padding(8)
        .background(Color.FMTheme.background)
    }
}
