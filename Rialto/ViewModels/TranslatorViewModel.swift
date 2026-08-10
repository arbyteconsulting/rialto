import SwiftUI
import Combine

enum TranslationDirection {
    case xmlToText
    case textToXML
}


@MainActor
class TranslatorViewModel: ObservableObject {
    @Published var xmlText: String = ""
    @Published var plainText: String = ""
    @Published var errorMessage: String? = nil
    @Published var lastDirection: TranslationDirection? = nil
    @Published var isAnimating: Bool = false

    /// Carries both the step name and raw ID for unhandled step reporting.
    struct UnhandledStep: Identifiable {
        let id: FMStepID
        let name: String
    }

    @Published var unhandledSteps: [UnhandledStep] = []
    @Published var showUnhandledAlert: Bool = false

    // MARK: - XML → Plain Text

    func translateToPlain() {
        let input = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !input.isEmpty else {
            errorMessage = "XML input is empty."
            return
        }

        let parser = FMXMLParser()
        switch parser.parse(xml: input) {
        case .success(let steps):
            if steps.isEmpty {
                errorMessage = "No script steps found in XML. Make sure it's a valid FM clipboard snippet."
            } else {
                // Collect all steps with no registered handler (excluding comments)
                let unmapped = steps.filter { step in
                    step.id != .comment && FMScriptStepRegistry.handler(for: step.id) == nil
                }
                if !unmapped.isEmpty {
                    self.unhandledSteps = unmapped.map { UnhandledStep(id: $0.id, name: $0.name) }
                    self.showUnhandledAlert = true
                }

                plainText = FMScriptRenderer.render(steps: steps)
                errorMessage = nil
                lastDirection = .xmlToText
                triggerAnimation()
            }
        case .failure(let error):
            errorMessage = "XML parse error: \(error.localizedDescription)"
        }
    }

    // MARK: - Plain Text → XML

    func translateToXML() {
        let input = plainText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !input.isEmpty else {
            errorMessage = "Plain text input is empty."
            return
        }

        xmlText = FMPlainTextBuilder.build(plainText: input)
        errorMessage = nil
        lastDirection = .textToXML
        triggerAnimation()
    }

    // MARK: - Clipboard

    func copyToFileMaker() {
        switch FileMakerPasteboardService.copyToFileMaker(xmlText: xmlText) {
        case .success:
            errorMessage = nil
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
    }

    func copyPlainText() {
        FileMakerPasteboardService.copyPlainText(plainText)
    }

    func pasteToXML() {
        if let str = FileMakerPasteboardService.readPlainText() {
            xmlText = str
        }
    }

    func pasteFromFileMaker() {
        switch FileMakerPasteboardService.readFromFileMaker() {
        case .success(let str):
            xmlText = str
            errorMessage = nil
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
    }

    func pasteToPlain() {
        if let str = FileMakerPasteboardService.readPlainText() {
            plainText = str
        }
    }

    func clearAll() {
        xmlText = ""
        plainText = ""
        errorMessage = nil
        lastDirection = nil
        unhandledSteps = []
        showUnhandledAlert = false
    }

    private func triggerAnimation() {
        isAnimating = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.isAnimating = false
        }
    }

    // MARK: - Sample Data

    func loadSampleXML() {
        xmlText = """
<?xml version="1.0" encoding="UTF-8"?>
<fmxmlsnippet type="FMObjectList">
    <Step enable="True" id="86" name="Set Error Capture">
        <Set state="True"/>
    </Step>
    <Step enable="True" id="141" name="Set Variable">
        <Name value="$result"/>
        <Repetition value="1"/>
        <Calculation><![CDATA["Hello World"]]></Calculation>
    </Step>
    <Step enable="True" id="68" name="If">
        <Calculation><![CDATA[IsEmpty ( $result )]]></Calculation>
    </Step>
    <Step enable="True" id="87" name="Show Custom Dialog">
        <Title value="Error"/>
        <Message value="Result is empty"/>
    </Step>
    <Step enable="True" id="103" name="Exit Script">
        <Calculation><![CDATA[False]]></Calculation>
    </Step>
    <Step enable="True" id="70" name="End If"/>
    <Step enable="True" id="75" name="Commit Records/Requests">
        <NoInteract state="True"/>
    </Step>
</fmxmlsnippet>
"""
    }

    func loadSamplePlainText() {
        plainText = """
Set Error Capture [ On ]
Set Variable [ $counter ; Value: 0 ]
Loop
    Set Variable [ $counter ; Value: $counter + 1 ]
    If [ $counter > 10 ]
        Exit Loop If [ True ]
    End If
End Loop
Commit Records/Requests [ No dialog ]
"""
    }
}
