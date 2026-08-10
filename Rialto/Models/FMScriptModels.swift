import Foundation

// Represents a single parsed FileMaker script step
struct FMScriptStep {
    let id: FMStepID
    let name: String
    let enabled: Bool
    let parameters: [String: String]
    let calculation: String?
    let comment: String?
}
