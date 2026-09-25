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

- A failed model load replaces the whole view with a `ContentUnavailableView` showing the error description.
- A failed generation is shown as an assistant bubble containing the error description; the conversation stays usable.
- The app never crashes on a missing model resource or an unavailable session.
- Error text reflects limitations of the local runtime on macOS 27, not a remote service.
