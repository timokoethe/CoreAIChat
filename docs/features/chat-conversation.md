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

- The draft supports multiple lines, including pasted text. Shift-Return inserts a newline; the field wraps long lines, grows from one to six visible lines, and scrolls internally for longer drafts. The send button stays aligned with the bottom of the field.
- The send button and Return submit the draft only if it contains non-whitespace text and no response is running. Return does not insert a newline, including when sending is disabled. Leading and trailing whitespace is removed before sending; internal line breaks are preserved.
- Shift-Return inserts a newline at the cursor or replaces the selected text with a newline, leaving the cursor directly after it.
- The input's glass background keeps an 18-point corner radius as the field grows.
- Submission requires an available model session; otherwise the app shows the loading error view and preserves the draft without appending a user message.
- The sent message appears immediately as a user bubble; the draft field is cleared.
- User bubbles are gray and assistant bubbles are near-white in light appearance; both use neutral dark grays in dark appearance, with readable text and no blue bubble fills.
- While the model generates, a progress indicator is shown below the last message and sending is disabled.
- Whenever a user or assistant message is appended, the list scrolls to the newest message even if the user had previously scrolled up.
- Message text is selectable, and generation runs asynchronously without blocking the UI.
- Each window keeps its own conversation in memory; messages are not persisted between app launches.
