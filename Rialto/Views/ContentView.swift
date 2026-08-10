import SwiftUI

struct ContentView: View {
    @StateObject private var vm = TranslatorViewModel()
    @State private var isHeaderVisible = true

    var body: some View {
        VStack(spacing: 0) {
            if isHeaderVisible {
                HeaderBarView(vm: vm, onDismiss: {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isHeaderVisible = false
                    }
                })
                .transition(.move(edge: .top).combined(with: .opacity))

                Divider()
                    .background(Color.FMTheme.divider)
            }

            EqualTripleSplitView(
                left: EditorPaneView(
                    title: "Plain Text",
                    subtitle: "AI generated Human-readable script",
                    systemImage: "text.alignleft",
                    accentColor: Color.FMTheme.textAccent,
                    text: $vm.plainText,
                    placeholder: "Type or paste your AI generated human-readable script shorthand here…",
                    isHighlighted: vm.lastDirection == .xmlToText && vm.isAnimating,
                    onCopy: { vm.copyPlainText() },
                    onPaste: { vm.pasteToPlain() },
                    onClear: { vm.plainText = "" },
                    onSample: { vm.loadSamplePlainText() },
                    onPasteFromFM: nil,
                    copyLabel: "Copy Text",
                    pasteLabel: "Paste from LLM",
                    showCopyButton: false
                ),
                middle: TranslationControlsColumnView(vm: vm),
                right: EditorPaneView(
                    title: "FileMaker XML",
                    subtitle: "Clipboard snippet",
                    systemImage: "doc.text",
                    accentColor: Color.FMTheme.xmlAccent,
                    text: $vm.xmlText,
                    placeholder: "Paste FileMaker script clipboard XML here…",
                    isHighlighted: vm.lastDirection == .textToXML && vm.isAnimating,
                    onCopy: { vm.copyToFileMaker() },
                    onPaste: { vm.pasteToXML() },
                    onClear: { vm.xmlText = "" },
                    onSample: { vm.loadSampleXML() },
                    onPasteFromFM: { vm.pasteFromFileMaker() },
                    copyLabel: "Copy to FM",
                    showGenericPasteButton: false
                )
            )
            .background(Color.FMTheme.background)

            if let error = vm.errorMessage {
                StatusBarErrorBar(message: error, onDismiss: { vm.errorMessage = nil })
            }
        }
        .frame(minWidth: 850, minHeight: 550)
        .background(WindowTitleController(isVisible: !isHeaderVisible, title: "Rialto"))
        .sheet(isPresented: $vm.showUnhandledAlert) {
            UnhandledStepsSheet(steps: vm.unhandledSteps)
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - Unhandled Steps Sheet
// ─────────────────────────────────────────────

struct UnhandledStepsSheet: View {
    let steps: [TranslatorViewModel.UnhandledStep]
    @Environment(\.dismiss) private var dismiss
    @State private var didCopy: Bool = false

    /// Plain-text rendering of the sheet's contents, suitable for pasting
    /// elsewhere (e.g. into an LLM chat) instead of screenshotting the dialog.
    private var copyableText: String {
        var lines = ["The following script steps have no registered handler and were translated using a generic fallback:"]
        lines.append(contentsOf: steps.map { "• \($0.name) (ID: \($0.id.rawValue))" })
        return lines.joined(separator: "\n")
    }

    private func copyAll() {
        FileMakerPasteboardService.copyString(copyableText)

        didCopy = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            didCopy = false
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(Color.FMTheme.warningAccent)
                Text("Unhandled Script Steps")
                    .font(.headline)
                Spacer()
                Button {
                    copyAll()
                } label: {
                    Label(didCopy ? "Copied" : "Copy", systemImage: didCopy ? "checkmark" : "doc.on.doc")
                }
                .buttonStyle(.bordered)
                .help("Copy this list as text")
                .disabled(steps.isEmpty)

                Button("Dismiss") { dismiss() }
                    .buttonStyle(.borderedProminent)
                    .keyboardShortcut(.escape)
            }
            .padding()

            Divider()

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 4) {
                    Text("The following script steps have no registered handler and were translated using a generic fallback:")
                        .font(.subheadline)
                        .foregroundStyle(Color.FMTheme.textSecondary)
                        .padding(.bottom, 8)

                    ForEach(steps) { step in
                        HStack(spacing: 6) {
                            Text("•")
                                .foregroundStyle(Color.FMTheme.warningAccent)
                            Text(step.name)
                                .font(.system(.body, design: .monospaced))
                            Text("(ID: \(step.id.rawValue))")
                                .font(.caption)
                                .foregroundStyle(Color.FMTheme.textSecondary)
                        }
                    }
                }
                .padding()
            }
            .frame(minWidth: 380, minHeight: 200, maxHeight: 500)
        }
        .frame(width: 480)
    }
}
