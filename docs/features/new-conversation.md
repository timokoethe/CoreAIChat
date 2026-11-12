---
status: implemented
area: chat
platforms:
  - macos-27
---

# New Conversation

## Purpose

Starts a fresh local conversation without reloading the bundled model.

## User Story

As a user, I want to clear the current conversation so that I can start a new topic without the previous model context.

## Acceptance Criteria

- The chat toolbar offers a `New Conversation` button.
- Selecting it immediately clears all visible messages and the draft, without a confirmation dialog.
- The next prompt uses a fresh model session with no previous conversation history.
- The model remains loaded and the chat stays ready for input; no network or account is required.
- The button is disabled while a response is running, and reset requests during generation are ignored.
- Resetting affects only the current window and does not modify the bundled model resources.
- If the model session is unavailable, the app shows the loading error view and preserves visible messages and the draft.
