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

- On launch the app briefly explains that the bundled model runs locally and shows a prominent `Load Model` button; nothing is loaded until it is pressed.
- While loading, a progress indicator is shown and the UI stays responsive.
- Loading reads the complete exported resource directory bundled with the app, not just the `.aimodel`.
- The app loads the stable `model/` resource directory, so a compatible exported model can replace another without a source-code change.
- After a successful load the session is prewarmed and the chat view appears.
- If the resources are missing or incompatible with the `CoreAILanguageModels` runtime, the error view is shown instead.
