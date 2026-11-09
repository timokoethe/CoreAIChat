---
status: implemented
area: model-session
platforms:
  - macos-27
---

# Model Loading

## Purpose

Loads the bundled exported model resources into a `CoreAILanguageModel` and opens a `LanguageModelSession`, so chatting runs fully on device.

## User Story

As a user, I want to load the local model with one click so that I can start chatting without any network or account.

## Acceptance Criteria

- On launch, if the bundled `model/` directory and its `metadata.json` exist, the app briefly explains that the bundled model runs locally and shows a prominent `Load Model` button; nothing is loaded until it is pressed.
- If the directory or `metadata.json` is missing, the app shows `Model Resources Missing` with instructions to copy the complete export into `model/`, rebuild, and consult Getting Started in `README.md`. No load or retry button is shown.
- While loading, a progress indicator is shown and the UI stays responsive.
- Loading reads the complete exported resource directory bundled with the app, not just the `.aimodel`.
- The app loads the stable `model/` resource directory, so a compatible exported model can replace another without a source-code change.
- The app waits for the model engine to load successfully before prewarming the session and showing the chat view; engine-loading failures show the error view.
- Further validation of model resources is performed by `CoreAILanguageModels`; invalid or incompatible resources show the loading error view instead.
