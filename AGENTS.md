# AGENTS.md

## Project

CoreAIChat is a minimal macOS SwiftUI demo for running a local language model with Apple Core AI and Foundation Models. It targets macOS 27 beta and requires the matching Xcode beta. The app is not tied to Gemma 3: any compatible language model supported by Apple's `coreai-models` repository may be used. The included `gemma_3_4b_it_4bit_dynamic/` directory is only an example.

## Guidelines

- Keep changes small, focused, and consistent with the existing SwiftUI structure.
- Prefer native Swift and SwiftUI APIs; avoid new dependencies unless necessary.
- Preserve async/await usage and keep UI state updates on the main actor.
- Treat model directories such as the included `gemma_3_4b_it_4bit_dynamic/` example as generated assets; do not modify or commit their generated contents.
- Never add secrets, Hugging Face tokens, build artifacts, or user-specific Xcode data.
- Update `README.md` when setup or user-facing behavior changes.

## Validation

Build the `CoreAIChat` scheme with the Xcode beta selected:

```bash
DEVELOPER_DIR=/Applications/Xcode-beta.app/Contents/Developer \
xcodebuild -project CoreAIChat.xcodeproj \
  -scheme CoreAIChat \
  -sdk macosx \
  -destination 'platform=macOS' \
  -derivedDataPath /tmp/coreaichat-derived-data \
  CODE_SIGNING_ALLOWED=NO build
```

Report what was changed and which validation was run.
