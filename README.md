# Photo Editor

A modern photo editing application built with SwiftUI and Core Image.

## Features

- **Image Adjustments:** Real-time control over Brightness, Contrast, and Saturation.
- **Filters:** Apply professional-grade filters like Sepia, Noir, and more.
- **Photo Library Integration:** Seamlessly pick photos and save your edits back to your gallery.
- **Surgical Performance:** Built using optimized Core Image pipelines with a shared `CIContext`.

## Getting Started

### Prerequisites
- Xcode 15.0 or later
- iOS 17.0+ (Simulator or Physical Device)

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/elangbamjohnson/Photo-Editor.git
   ```
2. Open `Photo Editor.xcodeproj` in Xcode.
3. Build and Run on your preferred iOS device or simulator.

## Usage
1. Tap **Select Photo** to choose an image from your library.
2. Toggle **Show Tools** to access editing controls.
3. Use the **Adjust** tab for fine-tuning brightness, contrast, and saturation.
4. Switch to the **Filter** tab to apply cinematic presets.
5. Tap **Save** to export the result back to your Photo Library.

## Permissions
This app requires `NSPhotoLibraryAddUsageDescription` to save edited photos. When prompted, please allow access to ensure the saving functionality works correctly.

## Project Structure

- `ViewModels/`: Application state and business logic.
- `Services/`: Core Image processing wrappers.
- `Views/`: SwiftUI components and layouts.

## Tech Stack

- **Framework:** SwiftUI
- **Image Processing:** Core Image
- **Language:** Swift

## Roadmap
- [ ] Precision Cropping and Aspect Ratio presets.
- [ ] 90-degree Rotation and Mirroring.
- [ ] Advanced Color Curves.
- [ ] Batch processing support.

## License
Distributed under the MIT License. See `LICENSE` for more information.
