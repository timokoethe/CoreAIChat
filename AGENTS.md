# AGENTS.md

## Project

CoreAIChat is a minimal macOS SwiftUI demo for running a local language model with Apple Core AI and Foundation Models. It targets macOS 27 beta and requires the matching Xcode beta. The app is not tied to Gemma 3: any compatible language model supported by Apple's [`coreai-models`](https://github.com/apple/coreai-models) repository may be used. The included `gemma_3_4b_it_4bit_dynamic/` directory is only an example.

## Guidelines

- Keep changes small, focused, and consistent with the existing SwiftUI structure.
- Prefer native Swift and SwiftUI APIs; avoid new dependencies unless necessary.
- Preserve async/await usage and keep UI state updates on the main actor.
- Treat model directories such as the included `gemma_3_4b_it_4bit_dynamic/` example as generated assets; do not modify or commit their generated contents.
- Treat Apple's `coreai-models` repository as the source of truth for supported model presets, export commands, exported resource layouts, and `CoreAILanguageModels` runtime APIs.
- For existing behavior, consult `coreai-models` at the revision recorded in `Package.resolved`; compare it with upstream `main` only when intentionally evaluating an update.
- `coreai-models` supplies both the model export tooling and the `CoreAILM` Swift package used by this app. Keep exported resource bundles and the Swift runtime compatible, and preserve the complete exported resource directory rather than copying only the `.aimodel`.
- Do not update the `coreai-models` package reference or `Package.resolved` incidentally. For intentional updates, review the upstream changes, rebuild the app, and smoke-test model loading and one generated response.
- Prefer registered model presets and their model-specific recipes. Use experimental exports or custom compression settings only when explicitly required, and document those deviations in `README.md`.
- Never add secrets, Hugging Face tokens, build artifacts, or user-specific Xcode data.
- Update `README.md` when setup or user-facing behavior changes.
- Keep feature specifications in `docs/features/`, with one Markdown file per feature.
- Use `docs/features/_template.md` when adding a feature specification, and keep its purpose, user story, and acceptance criteria aligned with the implemented behavior.

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
