Vove iOS SDK
============

Overview
--------

VoveSDK is a comprehensive solution designed to facilitate ID verification and Know Your Customer (KYC) compliance effortlessly within your iOS applications. By integrating VoveSDK, you can enable secure and efficient user identity verification, leveraging our robust backend APIs for session token generation and verification status management.

Getting Started
---------------

### Installation

VoveSDK is available through [CocoaPods](https://cocoapods.org/). To integrate VoveSDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'VoveSDK'
```

Then, run the following command in your terminal:

```bash
pod install
```

### Initialization

To initialize VoveSDK in your application, you should perform the initialization at the app startup, typically in your `AppDelegate.swift` or `SceneDelegate.swift` file, depending on your project setup.

#### AppDelegate.swift

```swift

import UIKit
import VoveSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize VoveSDK
        Vove.initialize()

        return true
    }
}
```

#### SceneDelegate.swift

For projects using SceneDelegate:

```swift
import UIKit
import VoveSDK

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Initialize VoveSDK
        Vove.initialize()
    }
}
```

Starting an ID Verification Session
-----------------------------------

To start an ID verification session, you need a session token that should be generated from your backend by interacting with VoveSDK's APIs. Once you have the session token, you can start the verification session as follows:

```swift

Vove.startIDVerificationSession(sessionToken: "your_session_token_here") { result in
    switch result {
    case .success:
        print("Verification successful")
    case .pending:
        print("Verification pending")
    case .failure(let error):
        print("Verification failed: \(error.localizedDescription)")
    case .canceled:
        print("Verification canceled")
    }
}
```

Handling Verification Status
----------------------------

VoveSDK provides three status callbacks for the ID verification process: `success`, `pending`, and `failed`. It's crucial to handle each status appropriately in your application to ensure a smooth user experience.

### Success

The `success` status indicates that the user's ID verification has been successfully completed. You can proceed with the user's access to the application's features or services.

### Pending

The `pending` status means that the user's ID verification is still in progress and hasn't been concluded yet. You may need to inform the user to wait or check back later.

### Failed

The `failed` status occurs when the ID verification process fails. It's important to handle this case by informing the user of the failure and potentially guiding them on how to retry the verification process.

### Canceled

The `canceled` status indicates that the user has canceled the ID verification process. You should handle this case by updating the UI or providing the user with an option to restart the verification process.

Conclusion
----------

By following this guide, you should be able to integrate VoveSDK into your iOS application smoothly, enabling efficient and secure ID verification and KYC compliance. For further assistance or questions, please contact our support team.
