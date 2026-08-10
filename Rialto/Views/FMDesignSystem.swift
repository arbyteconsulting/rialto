//
//  FMDesignSystem.swift
//  Rialto
//
//  Created by Richie Whyte on 15/06/2026.
//

import SwiftUI

// ─────────────────────────────────────────────
// MARK: - Color Palette Tokens
// ─────────────────────────────────────────────
extension Color {
    struct FMTheme {
        // App Core Surfaces
        static let background = Color(NSColor.windowBackgroundColor)
        static let panelBackground = Color(NSColor.controlBackgroundColor)
        static let divider = Color.secondary.opacity(0.15)
        
        // Brand Semantic Contexts
        static let xmlAccent = Color.blue
        static let textAccent = Color.green
        static let warningAccent = Color.orange
        
        // Interactive Elements
        static let buttonHover = Color.secondary.opacity(0.15)
        static let textPrimary = Color.primary
        static let textSecondary = Color.secondary
        static let placeholder = Color.gray.opacity(0.7)
    }
}

// ─────────────────────────────────────────────
// MARK: - Typography Hierarchy Tokens
// ─────────────────────────────────────────────
extension Font {
    struct FMFont {
        static let headerTitle = Font.system(size: 14, weight: .bold)
        static let headerSubtitle = Font.system(size: 11, weight: .regular)
        static let panelTitle = Font.system(size: 13, weight: .semibold)
        static let infoLabel = Font.system(size: 11, weight: .medium)
        
        // Execution Workspace Monospace
        static let codeEditor = Font.system(.body, design: .monospaced)
    }
}
