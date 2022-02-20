# UIOnboarding

![UIOnboarding Title Page](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/140222%20UIOnboarding%20Result.png)

Configurable animated onboarding screen written programmatically in Swift for UIKit – [inspired](#moodboard) by many Apple-designed user interfaces in iOS – with [Insignia](https://apps.apple.com/ch/app/abzeichen/id1551002238) as an example.

 Designed for iPhone and iPod touch running iOS 13 or higher. Portrait mode only. Supports Dynamic Type, VoiceOver and Reduce Motion.

## Table of Contents

- [Previews](#previews)
    - [Accessibility](#accessibility)
- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [Demo Project Download](#demo-project-download)
- [Usage](#usage)
    - [UIKit](#uikit)
    - [SwiftUI](#swiftui)
- [Configuration](#configuration-example)
- [Moodboard](#moodboard)
- [License](#license)
- [Links](#links)
- [Icon Usage Rights](#icon-usage-rights)
- [Contributions](#contributions)

## Previews

| Default 6.5" | Default 4" |
|-|-|
| ![UIOnboarding Preview 6.5 inch](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/170222%20UIOnboarding%20Example%206.5%22.gif) | <img src='https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/170222%20UIOnboarding%20Example%204%22.gif' img width = 240> |

### Accessibility

| Dynamic Type | VoiceOver | Reduce Motion |
|-|-|-|
|![UIOnboarding Preview Dynamic Type](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/170222%20UIOnboarding%20Example%20Dynamic%20Type.gif)|![UIOnboarding Preview VoiceOver](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/140222%20UIOnboarding%20Example%20VoiceOver.gif)|![UIOnboarding Preview Redcue Motion](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/170222%20UIOnboarding%20Example%20Reduce%20Motion.gif)|

## Installation

### Swift Package Manager

To install ```UIOnboarding``` as a package, add ```https://github.com/lascic/UIOnboarding.git``` in the package manager in Xcode (under File/Add Packages...). Select the version from ```1.0.0``` or the ```main``` branch.

```swift
.package(url: "https://github.com/lascic/UIOnboarding.git", from: "1.0.0")
// or
.package(url: "https://github.com/lascic/UIOnboarding.git", branch: "main")
```

### Demo Project Download

There is a demo project with and without SPM in the ```Demo``` directory: ```Demo/UIOnboarding Demo``` and ```Demo/UIOnboarding Demo SPM```. This folder also provides an example for using it in a SwiftUI app: ```Demo/UIOnboarding SwiftUI```. 

You can download them as a .zip file to run it on a physical device or simulator in Xcode.

Before building and running the project, make sure to set it up with your own provisioning profile.

## Usage 

Setting up the
```UIOnboardingViewController```
takes a [```UIOnboardingViewConfiguration```](#configuration)
as the parameter.

### UIKit

Make sure the view controller you're presenting from is embedded in a ```UINavigationController```. ```OnboardingViewController``` is presented as a full screen view. 

``` swift
//In the view controller you're presenting
import UIOnboarding

let onboardingController: UIOnboardingViewController = .init(withConfiguration: .setUp())
onboardingController.delegate = self
navigationController?.present(onboardingController, animated: false)
```

Dismiss the onboarding view with the provided delegate method.

``` swift
extension ViewController: UIOnboardingViewControllerDelegate {
    func didFinishOnboarding(onboardingViewController: UIOnboardingViewController) {
        onboardingViewController.modalTransitionStyle = .crossDissolve
        onboardingViewController.dismiss(animated: true, completion: nil)
    }
}
```

### SwiftUI

As ```UIOnboardingViewController``` is a UIKit view controller, we rely on SwiftUI's ```UIViewControllerRepresentable``` protocol to make it behave as a ```View```.

Create a ```UIOnboardingView``` struct which implements this protocol and use the ```.fullScreenCover()``` modifier introduced in iOS 14 to show it in your SwiftUI view you're presenting from.

Note that we assign SwiftUI's coordinator as the delegate object for our onboarding view controller.
``` swift
onboardingController.delegate = context.coordinator
```

``` swift 
// In OnboardingView.swift
import SwiftUI
import UIOnboarding

struct UIOnboardingView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIOnboardingViewController

    func makeUIViewController(context: Context) -> UIOnboardingViewController {
        let onboardingController: UIOnboardingViewController = .init(withConfiguration: .setUp())
        onboardingController.delegate = context.coordinator
        return onboardingController
    }
    
    func updateUIViewController(_ uiViewController: UIOnboardingViewController, context: Context) {}
    
    class Coordinator: NSObject, UIOnboardingViewControllerDelegate {
        func didFinishOnboarding(onboardingViewController: UIOnboardingViewController) {
            onboardingViewController.dismiss(animated: true, completion: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        return .init()
    }
}
```

```swift 
// In ContentView.swift
.fullScreenCover(isPresented: $showingOnboarding, content: {
    UIOnboardingView()
        .edgesIgnoringSafeArea(.all)
})
```

## Configuration

```UIOnboardingViewConfiguration``` consists of five components.
1. App Icon as ```UIImage```
2. Welcome Title as ```NSMutableAttributedString```
3. Core Features as ```Array<UIOnboardingFeature>```
4. Notice Text as ```UIOnboardingTextViewConfiguration``` (e.g. Privacy Policy, Terms of Service)
5. Continuation Title as ```UIOnboardingButtonConfiguration```

In a helper struct ```UIOnboardingHelper``` we define these components and combine them in an [extension](#extension) of ```UIOnboardingViewConfiguration```.

### Example

``` swift
import UIOnboarding

struct UIOnboardingHelper {
    //App Icon
    static func setUpIcon() -> UIImage {
        return Bundle.main.appIcon ?? .init(named: "onboarding-icon")!
    }

    //Welcome Title
    static func setUpTitle() -> NSMutableAttributedString {
        let welcomeText: NSMutableAttributedString = .init(string: "Welcome to \n",
                                                           attributes: [.foregroundColor: UIColor.label]),
            appNameText: NSMutableAttributedString = .init(string: Bundle.main.displayName ?? "Insignia",
                                                           attributes: [.foregroundColor: UIColor.init(named: "camou")!])
        welcomeText.append(appNameText)
        return welcomeText
    }

    //Core Features
    static func setUpFeatures() -> Array<UIOnboardingFeature> {
        return .init([
            .init(icon: .init(named: "feature-1")!,
                  title: "Search until found",
                  description: "Over a hundred insignia of the Swiss Armed Forces – each redesigned from the ground up."),
            .init(icon: .init(named: "feature-2")!,
                  title: "Enlist prepared",
                  description: "Practice with the app and pass the rank test on the first run."),
            .init(icon: .init(named: "feature-3")!,
                  title: "#teamarmee",
                  description: "Add name tags of your comrades or cadre. Insignia automatically keeps every name tag you create in iCloud.")
        ])
    }

    //Notice Text
    static func setUpNotice() -> UIOnboardingTextViewConfiguration {
        return .init(icon: .init(named: "onboarding-notice-icon")!,
                     text: "Developed and designed for members of the Swiss Armed Forces.",
                     linkTitle: "Learn more...",
                     link: "https://www.lukmanascic.ch/portfolio/insignia",
                     tint: .init(named: "camou"))
    }

    //Continuation Title
    static func setUpButton() -> UIOnboardingButtonConfiguration {
        return .init(title: "Continue",
                     backgroundColor: .init(named: "camou")!)
    }
}
```


### Extension

``` swift
import UIOnboarding

extension UIOnboardingViewConfiguration {
    //UIOnboardingViewController init
    static func setUp() -> UIOnboardingViewConfiguration {
        return .init(appIcon: UIOnboardingHelper.setUpIcon(),
                     welcomeTitle: UIOnboardingHelper.setUpTitle(),
                     features: UIOnboardingHelper.setUpFeatures(),
                     textViewConfiguration: UIOnboardingHelper.setUpNotice(),
                     buttonConfiguration: UIOnboardingHelper.setUpButton())
    }
}
```

## Moodboard

![UIOnboarding First Moodboard](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/140222%20UIOnboarding%20Moodboard-1.png)
![UIOnboarding Second Moodboard](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/140222%20UIOnboarding%20Moodboard-2.png)

## License

This project is [MIT](https://github.com/lascic/UIOnboarding/blob/main/LICENSE) licensed.

## Icon Usage Rights

Some in-app assets provided for this demo project are part of [Insignia](https://apps.apple.com/ch/app/abzeichen/id1551002238).

© 2021 Copyright Lukman Aščić. All rights reserved.

## Links

Swiss Armed Forces Insignia from the App Store: https://apps.apple.com/ch/app/abzeichen/id1551002238 <br>
Author Twitter: [@lascic](https://twitter.com/lascic) <br>
Author Website: https://lukmanascic.ch

## Contributions

Contributions to UIOnboarding are more than welcome! Please file an issue or submit a pull request.
