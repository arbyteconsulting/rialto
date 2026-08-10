//
//  FMScriptStepHandlers+AIActionHandlers.swift
//  Rialto
//
//  Split from FMScriptStepRegistry.swift on 07/08/2026.
//

import Foundation

// ─────────────────────────────────────────────
// MARK: - AI Action Handlers (FM 2025/2026 Core)
// ─────────────────────────────────────────────

struct ConfigureAIAccountHandler: FMScriptStepHandler {
    static let id: FMStepID = .configureAIAccount
    static let name = "Configure AI Account"
    static func matches(textLine: String) -> Bool { textLine == "configure ai account" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        var provider = "ChatGPT"
        if bracketContent.lowercased().contains("provider:") {
            provider = bracketContent.components(separatedBy: "Provider:").last?.trimmingCharacters(in: .whitespaces) ?? "ChatGPT"
        }
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <LLMType value=\"\(provider)\"></LLMType>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let provider = step.parameters["LLMType.value"] ?? "ChatGPT"
        return "\(pad)\(prefix)Configure AI Account [ Provider: \(provider) ]"
    }
}

struct GenerateResponseHandler: FMScriptStepHandler {
    static let id: FMStepID = .generateResponse
    static let name = "Generate Response from Model"
    static func matches(textLine: String) -> Bool { textLine == "generate response from model" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let streaming = bracketContent.lowercased().contains("on") ? "True" : "False"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Stream state=\"\(streaming)\"></Stream>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let stream = step.parameters["Stream.state"] == "True" ? "Streaming: On" : "Streaming: Off"
        return "\(pad)\(prefix)Generate Response from Model [ \(stream) ]"
    }
}

struct ConfigurePromptTemplateHandler: FMScriptStepHandler {
    static let id: FMStepID = .configurePromptTemplate
    static let name = "Configure Prompt Template"
    static func matches(textLine: String) -> Bool { textLine == "configure prompt template" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        var provider = ""
        if bracketContent.lowercased().contains("provider:") {
            provider = bracketContent.components(separatedBy: "Provider:").last?.trimmingCharacters(in: .whitespaces) ?? ""
        }
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <ConfigurePromptTemplate ModelProvider=\"\(provider)\"></ConfigurePromptTemplate>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let provider = step.parameters["ConfigurePromptTemplate.ModelProvider"] ?? ""
        return "\(pad)\(prefix)Configure Prompt Template [ Provider: \(provider) ]"
    }
}

struct ConfigureRAGAccountHandler: FMScriptStepHandler {
    static let id: FMStepID = .configureRAGAccount
    static let name = "Configure RAG Account"
    static func matches(textLine: String) -> Bool { textLine == "configure rag account" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <VerifySSLCertificates state=\"False\"/>\n        <ConfigureRAGAccount/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Configure RAG Account"
    }
}

struct ConfigureRegressionModelHandler: FMScriptStepHandler {
    static let id: FMStepID = .configureRegressionModel
    static let name = "Configure Regression Model"
    static func matches(textLine: String) -> Bool { textLine == "configure regression model" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <LLMTrain>\n            <LLMTrainAction>LLMTrainTrainModel</LLMTrainAction>\n            <LLMAlgorithm>LLMTrainAlgForest</LLMAlgorithm>\n        </LLMTrain>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Configure Regression Model"
    }
}

struct ConfigureMachineLearningHandler: FMScriptStepHandler {
    static let id: FMStepID = .configureMachineLearning
    static let name = "Configure Machine Learning Model"
    static func matches(textLine: String) -> Bool { textLine == "configure machine learning model" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <ConfigureCoreML>Uninstall</ConfigureCoreML>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Configure Machine Learning Model"
    }
}

struct FineTuneModelHandler: FMScriptStepHandler {
    static let id: FMStepID = .fineTuneModel
    static let name = "Fine-Tune Model"
    static func matches(textLine: String) -> Bool { textLine == "fine-tune model" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Option state=\"False\"/>\n        <FineTuneLLM>\n            <DataSource>DataTable</DataSource>\n        </FineTuneLLM>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Fine-Tune Model"
    }
}

struct PerformFindByNaturalLanguageHandler: FMScriptStepHandler {
    static let id: FMStepID = .performFindByNaturalLanguage
    static let name = "Perform Find by Natural Language"
    static func matches(textLine: String) -> Bool { textLine == "perform find by natural language" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <SelectAll state=\"True\"/>\n        <LLMCreateFind>\n            <Action>Query</Action>\n        </LLMCreateFind>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Perform Find by Natural Language"
    }
}

struct PerformRAGActionHandler: FMScriptStepHandler {
    static let id: FMStepID = .performRAGAction
    static let name = "Perform RAG Action"
    static func matches(textLine: String) -> Bool { textLine == "perform rag action" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <RAGSpace>\n            <RAGSpaceAction>Add</RAGSpaceAction>\n            <DataSource>FromText</DataSource>\n        </RAGSpace>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Perform RAG Action"
    }
}

struct PerformSemanticFindHandler: FMScriptStepHandler {
    static let id: FMStepID = .performSemanticFind
    static let name = "Perform Semantic Find"
    static func matches(textLine: String) -> Bool { textLine == "perform semantic find" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <LLMSemanticFind>\n            <Query type=\"1\"/>\n            <Records type=\"1\"/>\n        </LLMSemanticFind>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Perform Semantic Find"
    }
}

struct PerformSQLByNaturalLanguageHandler: FMScriptStepHandler {
    static let id: FMStepID = .performSQLByNaturalLanguage
    static let name = "Perform SQL Query by Natural Language"
    static func matches(textLine: String) -> Bool { textLine == "perform sql query by natural language" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Option state=\"False\"/>\n        <PerformSQLQuerybyNaturalLanguage>\n            <Action>Query</Action>\n            <OptionsSelectionType>By List</OptionsSelectionType>\n        </PerformSQLQuerybyNaturalLanguage>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Perform SQL Query by Natural Language"
    }
}

struct InsertEmbeddingHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertEmbedding
    static let name = "Insert Embedding"
    static func matches(textLine: String) -> Bool { textLine == "insert embedding" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <LLMEmbedding/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert Embedding"
    }
}

struct InsertEmbeddingInFoundSetHandler: FMScriptStepHandler {
    static let id: FMStepID = .insertEmbeddingInFoundSet
    static let name = "Insert Embedding in Found Set"
    static func matches(textLine: String) -> Bool { textLine == "insert embedding in found set" }
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <LLMBulkEmbedding/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        return "\(pad)\(prefix)Insert Embedding in Found Set"
    }
}

struct SetAICallLoggingHandler: FMScriptStepHandler {
    static let id: FMStepID = .setAICallLogging
    static let name = "Set AI Call Logging"
    static func matches(textLine: String) -> Bool { textLine == "set ai call logging" }   
    
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String {
        let state = bracketContent.lowercased() == "off" ? "False" : "True"
        return "    <Step enable=\"\(isEnabled ? "True" : "False")\" id=\"\(id)\" name=\"\(name)\">\n        <Set state=\"\(state)\"/>\n        <LLMDebugLog/>\n    </Step>"
    }
    
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String {
        let state = step.parameters["Set.state"] == "False" ? "Off" : "On"
        return "\(pad)\(prefix)Set AI Call Logging [ \(state) ]"
    }
}
