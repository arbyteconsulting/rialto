//
//  FMScriptStepRegistry.swift
//  Rialto
//
//  Created by Richie Whyte on 18/06/2026.
//

import Foundation

/// Parses "Table::Field" references out of plain text (tolerating the stray
/// whitespace variants FileMaker's own "copy as text" export sometimes
/// produces, e.g. "Dashboard: :ModifiedBy" or "Dashboard:: gCap_First_Name"),
/// and assigns each one a stable ID for the current translation pass.
///
/// Real FileMaker field IDs come from the target file's own schema and can't
/// be derived from plain text alone. This assigns sequential IDs in the order
/// each field is first seen within one pass — enough to keep every reference
/// to the same field internally consistent, but it will not match a specific
/// real file's actual field IDs.
enum FMFieldReference {
    private static var cache: [String: Int] = [:]
    private static var nextID = 1

    /// Resets the ID cache. Call once at the start of each full translation
    /// pass so IDs are assigned consistently within that document.
    static func resetSession() {
        cache = [:]
        nextID = 1
    }

    /// Splits "Table::Field" into its table and field name parts.
    static func parse(_ raw: String) -> (table: String, field: String) {
        let trimmed = raw.trimmingCharacters(in: .whitespaces)
        if let range = trimmed.range(of: ":\\s*:", options: .regularExpression) {
            let table = String(trimmed[trimmed.startIndex..<range.lowerBound]).trimmingCharacters(in: .whitespaces)
            let field = String(trimmed[range.upperBound...]).trimmingCharacters(in: .whitespaces)
            return (table, field)
        }
        // No table qualifier found; treat the whole thing as a bare field name.
        return ("", trimmed)
    }

    /// Session-scoped ID for a table/field pair, assigning a new one the
    /// first time this exact pair is encountered.
    static func id(table: String, field: String) -> Int {
        let key = "\(table)::\(field)"
        if let existing = cache[key] { return existing }
        let assigned = nextID
        cache[key] = assigned
        nextID += 1
        return assigned
    }

    /// Parses "Table::Field" and returns the table, field, and assigned ID together.
    static func resolve(_ raw: String) -> (table: String, field: String, id: Int) {
        let (table, field) = parse(raw)
        return (table, field, id(table: table, field: field))
    }

    /// Given a bracket's semicolon-separated parts, picks out the one that
    /// looks like a "Table::Field" reference (tolerating the stray-whitespace
    /// variants) and returns it separately from the remaining option parts —
    /// e.g. for `[ Select ; Dashboard::ModifiedBy ]`, returns
    /// (field: "Dashboard::ModifiedBy", rest: ["Select"]).
    static func extractFieldPart(fromSemicolonParts parts: [String]) -> (field: String?, rest: [String]) {
        var fieldRaw: String? = nil
        var rest: [String] = []
        for part in parts {
            let trimmed = part.trimmingCharacters(in: .whitespaces)
            if fieldRaw == nil, trimmed.range(of: ":\\s*:", options: .regularExpression) != nil {
                fieldRaw = trimmed
            } else {
                rest.append(trimmed)
            }
        }
        return (fieldRaw, rest)
    }

    /// Builds the `table="..." ` attribute fragment for a resolved reference
    /// (omitted entirely when there's no table qualifier).
    static func tableAttr(_ table: String) -> String {
        table.isEmpty ? "" : " table=\"\(table)\""
    }
}

/// Assigns stable, session-scoped IDs to referenced sub-script names (e.g.
/// the "Script:" parameter on Install OnTimer Script, Configure Local
/// Notification, etc). Same caveat as FMFieldReference: real FileMaker
/// script IDs come from the target file's own schema and can't be derived
/// from plain text — this only keeps repeated references to the same script
/// internally consistent within one translation pass.
enum FMScriptReference {
    private static var cache: [String: Int] = [:]
    private static var nextID = 1

    static func resetSession() {
        cache = [:]
        nextID = 1
    }

    static func id(for name: String) -> Int {
        if let existing = cache[name] { return existing }
        let assigned = nextID
        cache[name] = assigned
        nextID += 1
        return assigned
    }
}

/// The strict contract every FileMaker script step must satisfy to guarantee a flawless round-trip translation.
protocol FMScriptStepHandler {
    static var id: FMStepID { get }
    static var name: String { get }
    
    /// Evaluates if a plain-text line label matches this script step definition.
    static func matches(textLine: String) -> Bool
    
    /// Compiles short bracket configurations directly into canonical, paste-ready FileMaker XML.
    static func buildXML(bracketContent: String, isEnabled: Bool) -> String
    
    /// Decompiles a parsed XML step structure back into standard plain-text shorthand.
    static func renderText(step: FMScriptStep, prefix: String, pad: String) -> String
}

/// The Single Source of Truth Registry managing all isolated step implementations.
enum FMScriptStepRegistry {
    static let handlers: [FMScriptStepHandler.Type] = [
        // Control Steps
        CommentStepHandler.self,
        IfStepHandler.self,
        ElseIfStepHandler.self,
        ElseStepHandler.self,
        EndIfStepHandler.self,
        LoopStepHandler.self,
        ExitLoopIfHandler.self,
        EndLoopStepHandler.self,
        SetVariableHandler.self,
        AllowUserAbortHandler.self,
        SetErrorCaptureHandler.self,
        SetErrorLoggingHandler.self,
        ExitScriptHandler.self,
        HaltScriptHandler.self,
        PauseResumeScriptHandler.self,
        PerformScriptHandler.self,
        PerformScriptOnServerHandler.self,
        PerformScriptOnServerWithCallbackHandler.self,
        InstallOnTimerScriptHandler.self,
        SetUseSystemFormatsHandler.self,
        FlushCacheToDiskHandler.self,
        ExitApplicationHandler.self,
        BeepHandler.self,
        SetMultiUserHandler.self,
        SetZoomLevelHandler.self,
        OpenURLHandler.self,
        AllowFormattingBarHandler.self,

        // Navigation & Layout
        GoToLayoutHandler.self,
        GoToRecordRequestPageHandler.self,
        GoToFieldHandler.self,
        GoToPortalRowHandler.self,
        GoToObjectHandler.self,
        GoToRelatedRecordHandler.self,
        GoToNextFieldHandler.self,
        GoToPreviousFieldHandler.self,
        GoToListOfRecordsHandler.self,
        NewRecordRequestHandler.self,
        DuplicateRecordRequestHandler.self,
        DeleteRecordRequestHandler.self,
        DeleteAllRecordsHandler.self,
        DeletePortalRowHandler.self,
        RevertRecordRequestHandler.self,
        OpenRecordRequestHandler.self,
        CopyRecordRequestHandler.self,
        CopyAllRecordsRequestsHandler.self,

        // Find & Sorting
        EnterFindModeHandler.self,
        EnterBrowseModeHandler.self,
        EnterPreviewModeHandler.self,
        PerformFindHandler.self,
        PerformFindReplaceHandler.self,
        PerformQuickFindHandler.self,
        ShowAllRecordsHandler.self,
        ShowOmittedOnlyHandler.self,
        ModifyLastFindHandler.self,
        OmitRecordHandler.self,
        OmitMultipleRecordsHandler.self,
        ConstrainFoundSetHandler.self,
        ExtendFoundSetHandler.self,
        FindMatchingRecordsHandler.self,
        SortRecordsHandler.self,
        SortRecordsByFieldHandler.self,
        UnsortRecordsHandler.self,
        CheckFoundSetHandler.self,
        CheckRecordHandler.self,
        CheckSelectionHandler.self,

        // Field Editing
        SetFieldHandler.self,
        InsertCalculatedResultHandler.self,
        InsertCurrentDateHandler.self,
        InsertCurrentTimeHandler.self,
        InsertCurrentUserNameHandler.self,
        InsertTextHandler.self,
        InsertFromIndexHandler.self,
        InsertFromLastVisitedHandler.self,
        InsertPictureHandler.self,
        InsertPDFHandler.self,
        InsertFileHandler.self,
        InsertAudioVideoHandler.self,
        InsertFromURLHandler.self,
        InsertFromDeviceHandler.self,
        ReplaceFieldContentsHandler.self,
        RelookupFieldContentsHandler.self,
        SetNextSerialValueHandler.self,
        ExportFieldContentsHandler.self,

        // Clipboard
        CutHandler.self,
        CopyHandler.self,
        PasteHandler.self,
        ClearContentHandler.self,
        SelectAllHandler.self,
        UndoRedoHandler.self,
        SetSelectionHandler.self,

        // Window
        AdjustWindowHandler.self,
        ArrangeAllWindowsHandler.self,
        CloseWindowHandler.self,
        FreezeWindowHandler.self,
        MoveResizeWindowHandler.self,
        NewWindowHandler.self,
        RefreshWindowHandler.self,
        ScrollWindowHandler.self,
        SelectWindowHandler.self,
        SetWindowTitleHandler.self,
        ShowHideMenubarHandler.self,
        ShowHideToolbarsHandler.self,
        ShowHideTextRulerHandler.self,
        ViewAsHandler.self,
        ClosePopoverHandler.self,
        SetLayoutObjectAnimationHandler.self,
        RefreshObjectHandler.self,
        RefreshPortalHandler.self,
        PerformJavaScriptInWebViewerHandler.self,
        AVPlayerPlayHandler.self,
        AVPlayerSetPlaybackStateHandler.self,
        AVPlayerSetOptionsHandler.self,
        EnableTouchKeyboardHandler.self,

        // Records
        ImportRecordsHandler.self,
        ExportRecordsHandler.self,
        SaveCopyAsHandler.self,
        SaveRecordsAsExcelHandler.self,
        SaveRecordsAsPDFHandler.self,
        SaveRecordsAsJSONLHandler.self,
        SaveRecordsAsSnapshotLinkHandler.self,
        SaveCopyAsAddonPackageHandler.self,
        PrintHandler.self,
        PrintSetupHandler.self,

        // Files
        NewFileHandler.self,
        OpenFileHandler.self,
        CloseFileHandler.self,
        CreateDataFileHandler.self,
        OpenDataFileHandler.self,
        CloseDataFileHandler.self,
        ReadFromDataFileHandler.self,
        WriteToDataFileHandler.self,
        GetDataFilePositionHandler.self,
        SetDataFilePositionHandler.self,
        GetFileExistsHandler.self,
        GetFileSizeHandler.self,
        DeleteFileHandler.self,
        RenameFileHandler.self,
        RecoverFileHandler.self,
        GetFolderPathHandler.self,
        ConvertFileHandler.self,
        TruncateTableHandler.self,

        // Accounts & Security
        AddAccountHandler.self,
        DeleteAccountHandler.self,
        EnableAccountHandler.self,
        ResetAccountPasswordHandler.self,
        ReLoginHandler.self,
        ChangePasswordHandler.self,
        SetSessionIdentifierHandler.self,

        // Transactions
        OpenTransactionHandler.self,
        CommitTransactionHandler.self,
        RevertTransactionHandler.self,
        SetRevertTransactionOnErrorHandler.self,

        // Data API & SQL
        ExecuteSQLHandler.self,
        ExecuteFMDataAPIHandler.self,
        PerformAppleScriptHandler.self,
        SendDDEExecuteHandler.self,
        SendEventHandler.self,
        SendMailHandler.self,
        DialPhoneHandler.self,
        SpeakHandler.self,
        SetDictionaryHandler.self,
        CorrectWordHandler.self,
        SpellingOptionsHandler.self,
        SelectDictionariesHandler.self,
        EditUserDictionaryHandler.self,
        InstallMenuSetHandler.self,
        InstallPluginFileHandler.self,
        SetWebViewerHandler.self,
        SetFieldByNameHandler.self,
        TriggerClarisConnectFlowHandler.self,
        ConfigureRegionMonitorHandler.self,

        // User Interface
        ShowCustomDialogHandler.self,
        OpenScriptWorkspaceHandler.self,
        OpenManageDatabaseHandler.self,
        OpenManageLayoutsHandler.self,
        OpenManageThemesHandler.self,
        OpenManageValueListsHandler.self,
        OpenManageDataSourcesHandler.self,
        OpenManageContainersHandler.self,
        OpenFavoritesHandler.self,
        OpenHostsHandler.self,
        OpenHelpHandler.self,
        OpenSettingsHandler.self,
        OpenFileOptionsHandler.self,
        OpenSharingHandler.self,
        OpenFindReplaceHandler.self,
        OpenEditSavedFindsHandler.self,
        OpenUploadToHostHandler.self,
        SaveCopyAsXMLHandler.self,

        // AI Steps
        ConfigureAIAccountHandler.self,
        GenerateResponseHandler.self,
        ConfigurePromptTemplateHandler.self,
        ConfigureRAGAccountHandler.self,
        ConfigureRegressionModelHandler.self,
        ConfigureMachineLearningHandler.self,
        FineTuneModelHandler.self,
        PerformFindByNaturalLanguageHandler.self,
        PerformRAGActionHandler.self,
        PerformSemanticFindHandler.self,
        PerformSQLByNaturalLanguageHandler.self,
        InsertEmbeddingHandler.self,
        InsertEmbeddingInFoundSetHandler.self,
        SetAICallLoggingHandler.self,

        // Hardware & Mobile
        ConfigureLocalNotificationHandler.self,
        ConfigureNFCReadingHandler.self,

        // PDF
        CreatePDFHandler.self,
        ClosePDFHandler.self,

        // Records
        CommitRecordsHandler.self,
    ]
    
    private static let byID: [FMStepID: FMScriptStepHandler.Type] = {
        #if DEBUG
        let ids = handlers.map { $0.id }
        assert(Set(ids).count == ids.count, "Duplicate step IDs detected in FMScriptStepRegistry!")
        #endif
        return Dictionary(
            handlers.map { ($0.id, $0) },
            uniquingKeysWith: { first, _ in first }
        )
    }()
    
    static func handler(for id: FMStepID) -> FMScriptStepHandler.Type? {
        return byID[id]
    }
    
    static func handler(for label: String) -> FMScriptStepHandler.Type? {
        let low = label.lowercased().trimmingCharacters(in: .whitespaces)
        return handlers.first(where: { $0.matches(textLine: low) })
    }
}
