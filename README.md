# Rialto

### The bridge between AI and FileMaker.

Rialto is a native macOS application that converts **AI-generated plain-text FileMaker scripts into scripts that can be pasted directly into the FileMaker Pro Script Workspace.**

AI assistants such as ChatGPT, Claude and Gemini are very good at understanding what a FileMaker script should do and describing the required steps.

The problem is that they don't always produce FileMaker's native script format reliably.

**Rialto is the missing bridge.**

---

## How it works

The workflow is deliberately simple:

```text
┌─────────────────────┐
│         AI          │
│                     │
│  "Create a script   │
│   that..."          │
└──────────┬──────────┘
           │
           │ Plain-text script
           ▼
┌─────────────────────┐
│       RIALTO        │
│                     │
│     Translate       │
└──────────┬──────────┘
           │
           │ FileMaker script
           ▼
┌─────────────────────┐
│     FileMaker Pro   │
│                     │
│   Script Workspace  │
└─────────────────────┘
```

**AI → Plain Text → Rialto → FileMaker**

That's it.

---

## Why Rialto?

Large Language Models are excellent at generating structured plain text, but FileMaker's native script representation is much more difficult for them to produce consistently.

For example, an AI can naturally produce:

```text
Set Variable

Name: $count
Value: 10

Loop

If

Condition: $count > 0

Show Custom Dialog

Title: Countdown
Message: $count

Set Variable

Name: $count
Value: $count - 1

End If

End Loop
```

Rialto translates this into a FileMaker script:

```text
Set Variable [ $count ; Value: 10 ]

Loop

If [ $count > 0 ]

Show Custom Dialog [
    Title: "Countdown";
    Message: $count
]

Set Variable [ $count ; Value: $count - 1 ]

End If

End Loop
```

The resulting script can then be **copied and pasted directly into the FileMaker Pro Script Workspace.**

No manual conversion is required.

---

## The idea

Rialto doesn't try to replace the AI.

It doesn't try to be an AI assistant.

It doesn't require an AI API.

Instead, it lets the AI do what it is good at:

> **Describe the script.**

And lets Rialto do what it is good at:

> **Turn that description into FileMaker script syntax.**

This separation makes the workflow simple and flexible.

You can use Rialto with whichever AI you prefer.

* ChatGPT
* Claude
* Gemini
* Other LLMs
* Local AI models

Rialto doesn't care where the plain text came from.

---

## A typical workflow

### 1. Ask your AI

For example:

> Create a FileMaker script that finds all unpaid invoices, loops through them and sends each customer an email.

### 2. Copy the AI's response

The AI produces a structured plain-text representation of the script.

### 3. Paste it into Rialto

Rialto analyses the script steps and parameters.

### 4. Translate

Rialto generates the corresponding FileMaker script.

### 5. Copy

Copy the result to the clipboard.

### 6. Paste into FileMaker

Paste it directly into the **FileMaker Pro Script Workspace**.

---

## What Rialto is not

Rialto is deliberately focused.

It is not:

* An AI chatbot
* An alternative to ChatGPT or Claude
* A FileMaker replacement
* A cloud service
* An AI API
* A FileMaker plugin

It is a **bridge** between AI-generated plain text and FileMaker scripting.

---

## Features

* Native macOS application
* Built with Swift and SwiftUI
* Converts structured plain text into FileMaker scripts
* Supports a large range of FileMaker script steps
* Handles script parameters and nested structures
* Produces FileMaker-compatible script syntax
* Runs locally on your Mac
* No AI API key required
* Works with any AI capable of producing the required plain-text format
* Output can be copied directly into the FileMaker Script Workspace

---

## Built with Swift

Rialto is a native macOS application built using:

* **Swift**
* **SwiftUI**
* Native macOS frameworks

The project separates the user interface from the translation engine, making the core translation functionality independent of the application interface.

```text
Rialto/
├── Models/
├── Services/
├── TranslationEngine/
├── ViewModels/
├── Views/
└── Assets.xcassets/
```

---

## Requirements

* macOS
* FileMaker Pro
* Xcode (for building from source)

Supported macOS and FileMaker versions will be documented as the project develops.

---

## Installation

Download the latest release from the GitHub **Releases** page.

Alternatively, clone the repository and build Rialto using Xcode.

```bash
git clone https://github.com/YOUR-USERNAME/rialto.git
```

Open:

```text
Rialto.xcodeproj
```

in Xcode and build the application.

---

## Screenshots

*Screenshots and an animated demonstration will be added here.*

The ideal workflow is simple enough to demonstrate in a few seconds:

```text
AI
 ↓
Copy
 ↓
Rialto
 ↓
Translate
 ↓
Copy
 ↓
FileMaker Script Workspace
 ↓
Paste
```

---

## Project Status

Rialto is an open-source project under active development.

The core translation engine is functional and supports a substantial range of FileMaker script steps.

There will inevitably be FileMaker script steps, parameters and edge cases that need further refinement.

If you find something that doesn't translate correctly, please report it.

---

## Contributing

Contributions, bug reports and suggestions are welcome.

If you encounter a translation problem, please include:

* The plain-text input
* The generated output
* The expected FileMaker script
* Your FileMaker version, where relevant

This makes it much easier to reproduce and fix translation issues.

---

## Roadmap

Possible future development includes:

* Additional FileMaker script-step support
* Improved parameter handling
* Better validation and error reporting
* Syntax highlighting
* Improved editing and navigation
* FileMaker version awareness
* Expanded automated testing
* Improved clipboard integration
* Additional AI workflow integrations

The roadmap will evolve based on feedback from FileMaker developers using Rialto.

---

## Why "Rialto"?

The name has a couple of connections.

**Rialto is a village in Dublin, Ireland**, beside where the author lives.

It is also the name of the famous **Rialto Bridge in Venice**, which connects the two sides of the Grand Canal.

The name seemed fitting for an application whose purpose is to provide a bridge between two worlds:

**AI ↔ FileMaker**

AI generates the plain-text representation of a FileMaker script. Rialto translates it into a FileMaker script that can be pasted directly into the FileMaker Pro Script Workspace.

**AI writes the script. Rialto makes it FileMaker.**


## Licence

Rialto is released under the MIT License.

See [LICENSE](LICENSE) for details.

---

## Author

**Richard Whyte**

Rialto was created as an exploration of how Large Language Models can be used more effectively in FileMaker development.

If you find Rialto useful, please ⭐ star the repository and share it with other FileMaker developers.

---

# Rialto

### AI writes the script. Rialto makes it FileMaker.

**AI → Plain Text → Rialto → FileMaker**
