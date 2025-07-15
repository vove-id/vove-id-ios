# VoveSnap

A UIKit component for capturing and uploading identity document images within the VoveSDK.

## Features

- Document scanning using device camera
- File selection from device (PDF, JPG, PNG, HEIC)
- Automatic document detection and capture
- Manual capture option as fallback
- Front and back side capture support
- Real-time upload progress tracking
- Light and dark mode support
- Configurable appearance and text
- iOS 13+ compatibility

## Usage

VoveSnap is designed to be easy to integrate into your application. The main entry point is `VoveSnapViewController`, which manages the entire scanning and uploading process.

### Basic Integration

```swift
import VoveSDK
import Combine

// 1. Create a configuration
var config = VoveSnapViewController.Config()
config.brandColor = .blue
config.accentColor = .white
config.idleTitle = "Scan your Address Proof"
config.uploadTitle = "Uploading Document..."
config.requiresBackSide = false  // Set to true to capture both sides
config.uploadFileButton = "UPLOAD FROM DEVICE" // Custom text for upload button

// 2. Create an upload function
let uploadFunction: VoveSnapViewController.UploadFunction = { imageData, progressHandler in
    // Your upload implementation goes here
    // This function should:
    //  - Accept the image data to upload
    //  - Report progress via the progressHandler (values 0.0-1.0)
    //  - Return a publisher that emits the document ID on success
    //  - Or complete with an error if the upload fails
    
    // Example using a publishing subject
    let subject = PassthroughSubject<String, Error>()
    
    // Start your upload process
    yourUploadImplementation(imageData) { progress in
        progressHandler(progress)  // Report progress back to UI
    } completion: { result in
        switch result {
        case .success(let documentId):
            subject.send(documentId)
            subject.send(completion: .finished)
        case .failure(let error):
            subject.send(completion: .failure(error))
        }
    }
    
    return subject.eraseToAnyPublisher()
}

// 3. Present the view controller
let voveSnapVC = VoveSnapViewController(
    config: config,
    uploadFunction: uploadFunction,
    onResult: { result in
        switch result {
        case .success(let documentId):
            print("Document uploaded with ID: \(documentId)")
            // Handle successful upload
            
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
            // Handle error
        }
    }
)

present(voveSnapVC, animated: true)
```

## Configuration Options

The `VoveSnapViewController.Config` struct allows you to customize the appearance and behavior:

| Property | Type | Description |
|----------|------|-------------|
| `brandColor` | `Color` | Primary color for UI elements |
| `accentColor` | `Color` | Secondary color for UI elements |
| `idleTitle` | `String` | Title shown in the initial screen |
| `uploadTitle` | `String` | Title shown during upload |
| `showBackCopy` | `String` | Text shown when prompting for back side |
| `idleButton` | `String` | Text for the main action button |
| `uploadFileButton` | `String` | Text for the upload from device button |
| `focusHint` | `String` | Text for camera focus hint |
| `requiresBackSide` | `Bool` | Whether to capture both sides |

## User Flows

### Camera Capture Flow
1. User taps the "CONTINUE" button on the idle screen
2. Camera view appears with automatic document detection
3. Document is captured automatically when stable, or manually after timeout
4. Preview screen shows the captured document for review
5. User confirms or retakes the image
6. Upload progress is shown in real-time
7. Success animation displays when complete

### File Upload Flow
1. User taps the "UPLOAD FROM DEVICE" button on the idle screen
2. System file picker appears allowing selection of PDF or image files
3. If an image is selected, preview screen shows the image for review
4. If a PDF is selected, upload begins immediately
5. Upload progress is shown in real-time
6. Success animation displays when complete

## Upload Function

The upload function is a crucial part of the integration that connects your backend services to VoveSnap. It has the following signature:

```swift
typealias UploadFunction = (Data, @escaping (Double) -> Void) -> AnyPublisher<String, Error>
```

Where:
- `Data` - The image data to upload
- `(Double) -> Void` - A progress reporting callback (values from 0.0 to 1.0)
- Returns a Combine `Publisher` that emits a String (document ID) on success or an Error on failure

## Example Implementation with URLSession

See the `VoveSnapUsageExample.swift` file for a complete example of implementing an upload function using URLSession with progress tracking.

## Requirements

- iOS 13.0+
- Swift 5.0+
- Combine framework

## Installation

Add to your `Package.swift`:

```swift
.package(url: "https://github.com/your-org/VoveSnap.git", from: "1.0.0")
```

Or use Xcode's Swift Package Manager UI.

## Converting Base64 to File

If you need to save the base64 string as a file in your app:

```swift
func saveBase64AsFile(base64String: String) -> URL? {
    guard let data = Data(base64Encoded: base64String) else {
        return nil
    }
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let filename = "document_\(Date().timeIntervalSince1970).jpg"
    let fileURL = documentsDirectory.appendingPathComponent(filename)
    
    do {
        try data.write(to: fileURL)
        return fileURL
    } catch {
        print("Error saving file: \(error)")
        return nil
    }
}
```

## Supported File Types

When using the file upload functionality, the following file types are supported:
- PDF documents
- JPEG/JPG images
- PNG images
- HEIC images (iOS High Efficiency Image Format)

## License
MIT 