---
status: implemented
area: chat
platforms:
  - macos-27
---

# Error Handling

## Purpose

Makes failures of the on-device model visible instead of leaving the user with an empty or frozen window.

## User Story

As a user, I want to see what went wrong so that I can fix the setup or retry.

## Acceptance Criteria

- A failed model load replaces the whole view with a `ContentUnavailableView` showing the error description and a `Try Again` button.
- A missing bundled `model/` directory or `metadata.json` instead shows setup instructions without a retry button, since adding bundled resources requires rebuilding the app.
- Selecting `Try Again` starts a new model-loading attempt and shows loading progress while it runs.
- A generation error from an available session is shown as an assistant bubble containing the error description; the conversation stays usable.
- If the model session is unavailable when submitting, the app shows the loading error view with a retry button and preserves the draft without appending a message.
- The app never crashes on a missing model resource or an unavailable session.
- Error text reflects limitations of the local runtime on macOS 27, not a remote service.
