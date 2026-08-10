//
//  TranslationControlsColumn.swift
//  Rialto
//
//  Created by Richie Whyte on 15/06/2026.
//

import SwiftUI

struct TranslationControlsColumnView: View {
    @ObservedObject var vm: TranslatorViewModel

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            // To Text Decomposition Flow
            ControlButtonElement(
                systemImage: "arrow.left.circle.fill",
                helpText: "Translate XML to Plain Text (⌘←)",
                action: { vm.translateToPlain() }
            )
            .keyboardShortcut(.leftArrow, modifiers: [.command])

            // To XML Compilation Flow
            ControlButtonElement(
                systemImage: "arrow.right.circle.fill",
                helpText: "Translate Plain Text to XML (⌘→)",
                action: { vm.translateToXML() }
            )
            .keyboardShortcut(.rightArrow, modifiers: [.command])

            Spacer()
        }
        .frame(width: 50)
        .padding(.vertical)
        .background(Color.FMTheme.background)
    }
}

private struct ControlButtonElement: View {
    let systemImage: String
    let helpText: String
    let action: () -> Void
    
    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 28))
                .foregroundColor(isHovered ? Color.FMTheme.textPrimary : Color.FMTheme.textSecondary)
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(isHovered ? Color.FMTheme.buttonHover : Color.clear)
                )
        }
        .buttonStyle(.plain)
        .help(helpText)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.1)) { isHovered = hovering }
        }
    }
}
