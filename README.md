<p align="center">
  <img src="docs/assets/Icon.png" width="112" alt="CoreAIChat app icon">
</p>

<h1 align="center">CoreAIChat</h1>

<p align="center">
  <strong>Explore local language models with Apple Core AI.</strong>
</p>

<p align="center">
  A minimal macOS showcase for building an on-device AI chat experience with
  SwiftUI, Core AI, and Foundation Models.
</p>

<p align="center">
  <a href="https://opensource.org/license/mit"><img src="https://img.shields.io/badge/license-MIT-E87524" alt="MIT license"></a>
  <img src="https://img.shields.io/badge/type-showcase-E87524" alt="Showcase project">
  <img src="https://img.shields.io/badge/UI-SwiftUI-E87524" alt="SwiftUI">
  <img src="https://img.shields.io/badge/platform-macOS%2027-E87524" alt="macOS 27">
  <img src="https://img.shields.io/badge/Xcode-27-E87524" alt="Xcode 27">
</p>

## At a Glance

CoreAIChat demonstrates the shortest path from an exported model bundle to a
native, local chat experience on macOS. Load the bundled model, submit a prompt,
and receive a response through Apple's Foundation Models APIs—all without a
remote inference service.

The project is model-agnostic. The included
`gemma_3_4b_it_4bit_dynamic` resource is an example; any compatible language
model supported by Apple's [`coreai-models`](https://github.com/apple/coreai-models)
repository can take its place.

## Highlights

- **Run inference on device:** Load an exported Core AI model directly from the
  app bundle and generate responses locally.
- **Use native frameworks:** Combine SwiftUI, Foundation Models, and
  `CoreAILanguageModels` in a compact reference implementation.
- **Swap compatible models:** Follow a model-specific `coreai-models` recipe,
  then replace the example resource and its name in the app.
- **Keep the interface responsive:** Model loading and response generation use
  Swift concurrency.
- **See the complete chat flow:** The showcase covers loading, prewarming,
  prompt submission, progress feedback, conversation history, and errors.
- **Learn from documented behavior:** Concise feature specifications describe
  the observable model-loading, conversation, and error states.

The implemented behavior is documented in [`docs/features/`](docs/features/),
including [model loading](docs/features/model-loading.md),
[chat conversations](docs/features/chat-conversation.md), and
[error handling](docs/features/error-handling.md).

## Project Status

> [!IMPORTANT]
> CoreAIChat is a **showcase app**, not an App Store product. It is intended for
> learning, experimentation, and demonstrating Apple Core AI integration. It is
> not production-ready and is not distributed through the App Store.

Generated output may be inaccurate, incomplete, or misleading. Model
compatibility and setup requirements can vary between `coreai-models` releases.

## Technology

| Area | Implementation |
| --- | --- |
| Interface | SwiftUI |
| Conversation API | Foundation Models |
| Local model runtime | `CoreAILanguageModels` from `coreai-models` |
| Concurrency | Swift async/await |
| Example model | Gemma 3 4B IT |
| Platform | macOS 27 |

## Getting Started

You need macOS 27 and Xcode 27. Model export can require
substantial disk space and memory; requirements vary by model.

### 1. Prepare the export tools

Install [uv](https://docs.astral.sh/uv/) if it is not already available:

```sh
brew install uv
```

Alternatively, use the official installer:

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Clone Apple's [`coreai-models`](https://github.com/apple/coreai-models)
repository and enter it:

```sh
git clone https://github.com/apple/coreai-models.git
cd coreai-models
```

### 2. Choose and export a model

Choose one of the compatible model recipes in `coreai-models` and follow its
requirements and license terms. For the Gemma 3 example, accept the
[Gemma license terms](https://huggingface.co/google/gemma-3-4b-it), install the
Hugging Face CLI, and authenticate:

```sh
brew install hf
hf auth login --token <YOUR_TOKEN>
```

Then export the model from the `coreai-models` directory:

```sh
uv run coreai.llm.export google/gemma-3-4b-it
```

Exporting can take a few minutes because the source model may need to be
downloaded before conversion. For Gemma 3, the result is written to
`exports/gemma_3_4b_it_4bit_dynamic` and should have this structure:

```text
gemma_3_4b_it_4bit_dynamic/
├── gemma_3_4b_it_4bit_dynamic.aimodel/
├── metadata.json
└── tokenizer/
```

Commands and prerequisites differ between models. Treat the matching recipe in
`coreai-models` as the source of truth.

### 3. Add the model to Xcode

Open the project:

```sh
open CoreAIChat.xcodeproj
```

Add the **complete exported resource directory** to the CoreAIChat app target.
The repository includes an empty `gemma_3_4b_it_4bit_dynamic/` placeholder that
is already referenced by the project and `ViewModel.swift`.

When using another compatible model:

1. Replace the example resource directory in the app target.
2. Update the resource name in `CoreAIChat/ViewModel.swift`.
3. Keep the `.aimodel`, `metadata.json`, and `tokenizer/` resources together.

Exported model files are intentionally not committed to this repository.

### 4. Run the showcase

For a signed local build, create your personal build configuration once:

```sh
cp Config/Local.xcconfig.example Config/Local.xcconfig
```

Then replace `YOUR_TEAM_ID` and the example bundle identifier in
`Config/Local.xcconfig`. The local file is ignored by Git, so developer-specific
signing values do not end up in `project.pbxproj`. Unsigned command-line builds
do not require this file.

Select the `CoreAIChat` scheme in Xcode and run it. Choose **Load Model**, wait
for the local model to load and prewarm, then start a conversation. The first
load can take a little longer.

For a signing-independent compile check, use Xcode 27:

```sh
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer \
xcodebuild -project CoreAIChat.xcodeproj \
  -scheme CoreAIChat \
  -sdk macosx \
  -destination 'platform=macOS' \
  -derivedDataPath /tmp/coreaichat-derived-data \
  CODE_SIGNING_ALLOWED=NO build
```

## Minimal Core AI Example

The central integration is deliberately small. This example uses the included
Gemma 3 resource name; substitute your exported directory name when using a
different compatible model.

```swift
import Foundation
import FoundationModels
import CoreAILanguageModels

func respond(to prompt: String) async throws -> String {
    guard let modelURL = Bundle.main.url(
        forResource: "gemma_3_4b_it_4bit_dynamic",
        withExtension: nil
    ) else {
        throw URLError(.fileDoesNotExist)
    }

    let model = try await CoreAILanguageModel(resourcesAt: modelURL)
    let session = LanguageModelSession(model: model)
    let response = try await session.respond(to: prompt)

    return response.content
}
```

## Repository Layout

```text
CoreAIChat/
├── CoreAIChat/                       SwiftUI app source
├── CoreAIChat.xcodeproj/             Xcode project and package resolution
├── Config/                           Shared and local build settings
├── docs/features/                    Feature behavior and acceptance criteria
├── docs/assets/                      README assets
├── gemma_3_4b_it_4bit_dynamic/       Untracked model-resource placeholder
└── Icon.icon/                        App icon source
```

## License

CoreAIChat is available under the [MIT License](LICENSE). Model weights and
related resources remain subject to their respective licenses.
