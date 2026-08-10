//
//  StatusBarErrorBar.swift
//  Rialto
//
//  Created by Richie Whyte on 15/06/2026.
//

import SwiftUI

struct StatusBarErrorBar: View {
    let message: String
    let onDismiss: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(Color.FMTheme.warningAccent)
                .font(.subheadline)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(Color.FMTheme.textPrimary)
                .lineLimit(2)
            Spacer()
            Button(action: onDismiss) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(Color.FMTheme.textSecondary)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.FMTheme.warningAccent.opacity(0.1))
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.FMTheme.warningAccent.opacity(0.3)),
            alignment: .top
        )
    }
}
