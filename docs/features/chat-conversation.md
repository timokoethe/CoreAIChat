---
status: implemented
area: chat
platforms:
  - macos-27
---

# Chat Conversation

## Purpose

Lets the user exchange messages with the loaded local model and see the conversation as a scrolling list of bubbles.

## User Story

As a user, I want to type a prompt and get an answer so that I can have a conversation with the on-device model.

## Acceptance Criteria

- The send button and Return key submit the draft only if it is non-empty and no response is running.
- The sent message appears immediately as a user bubble; the draft field is cleared.
- User bubbles are gray and assistant bubbles are near-white in light appearance; both use neutral dark grays in dark appearance, with readable text and no blue bubble fills.
- While the model generates, a progress indicator is shown below the last message and sending is disabled.
- Whenever a user or assistant message is appended, the list scrolls to the newest message even if the user had previously scrolled up.
- Message text is selectable, and generation runs asynchronously without blocking the UI.
