//
//  HeaderBarView.swift
//  Rialto
//
//  Created by Richie Whyte on 15/06/2026.
//

import SwiftUI

struct HeaderBarView: View {
    @ObservedObject var vm: TranslatorViewModel
    var onDismiss: () -> Void
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        HStack {
            HStack(alignment: .bottom, spacing: 8) {
                Image(colorScheme == .dark ? "RialtoLogoDark" : "RialtoLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 64)

                Text("The bridge between AI and Filemaker Scripting")
                    .font(Font.FMFont.headerSubtitle)
                    .foregroundColor(Color.FMTheme.textSecondary)
            }
            Spacer()

            Button(action: onDismiss) {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 16))
                    .foregroundColor(Color.FMTheme.textSecondary)
            }
            .buttonStyle(.plain)
            .help("Hide header")
        }
        .padding()
        .background(Color.FMTheme.background)
    }
}
