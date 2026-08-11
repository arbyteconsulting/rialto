//
//  AboutView.swift
//  Rialto
//
//  Created by Richie Whyte on 11/08/2026.
//

import SwiftUI

struct AboutView: View {
    private var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    private var build: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }

    var body: some View {
        VStack(spacing: 12) {
            Image("RialtoLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)

            Text("Rialto")
                .font(.title2).bold()

            Text("Version \(version) (\(build))")
                .foregroundStyle(.secondary)

            Text("© 2026 Richard Whyte")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(30)
        .frame(width: 300)
    }
}
