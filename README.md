# UIOnboarding

![UIOnboarding Title Page](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/290422-iphone-ipad-1.1.0.png)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flascic%2FUIOnboarding%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/lascic/UIOnboarding)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flascic%2FUIOnboarding%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/lascic/UIOnboarding)

UIOnboarding is an animated, configurable welcome screen in a Swift Package – inspired by Apple's [Stocks](https://apps.apple.com/us/app/stocks/id1069512882) app. 

It supports iPhone, iPad and iPod touch running iOS and iPadOS 13 or higher, including core accessibility features such as Dynamic Type, Reduce Motion and VoiceOver for all devices – Split View and Slide Over for iPad.

Developed and designed by [Lukman Aščić](https://twitter.com/lascic). <br>

## Table of Contents

- [Previews](#previews)
    - [iPhone and iPod touch](#iphone-and-ipod-touch)
    - [iPad](#ipad)
        - [Split View](#split-view)
        - [Slide Over](#slide-over)
    - [Accessibility](#accessibility)
- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [Demo Project Download](#demo-project-download)
- [Usage](#usage)
    - [UIKit](#uikit)
    - [SwiftUI](#swiftui)
        - [Setup](#full-setup)
- [Configuration](#configuration)
    - [Localization (Welcome Title)](#welcome-title-localization)
    - [Extension](#extension)
- [Further Setup](#further-setup)
- [Further Readings](#further-readings)
- [Copyright](#copyright)

## Previews

### iPhone and iPod touch

| Default 6.5" | Default 4" |
|-|-|
| ![UIOnboarding Preview 6.5 inch](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/290422-iphone-1.1.0/290422-iphone-6.5-inch.gif) | <img src='https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/290422-iphone-1.1.0/290422-iphone-4-inch.gif' img width = 240> |

### iPad

| 12.9" Portrait | 12.9" Landscape |
|-|-|
| ![UIOnboarding Preview 12.9 inch Portrait](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/290422-ipad-1.1.0/290422-ipad-dark-portrait.gif) | ![UIOnboarding Preview 12.9 inch Landscape](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/290422-ipad-1.1.0/290422-ipad-dark-landscape.gif) |

#### Split View

| 1/3 iPad Landscape | 1/2 iPad Landscape | 2/3 iPad Landscape |
|-|-|-|
|![UIOnboarding Slit View 1/3 Landscape](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-split-view-landscape-3.png?raw=true)|![UIOnboarding Slit View 1/2 Landscape](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-split-view-landscape-1.png?raw=true)|![UIOnboarding Slit View 2/3 Landscape](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-split-view-landscape-2.png?raw=true)|

| 1/3 iPad Portrait | 2/3 iPad Portrait |
|-|-|
|![UIOnboarding Slit View 1/3 Portrait](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-split-view-portrait-2.png?raw=true)|![UIOnboarding Slit View 2/3 Portrait](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-split-view-portrait-1.png?raw=true)|

#### Slide Over

| iPad Portrait | iPad Landscape |
|-|-|
|![UIOnboarding Slide Over Portrait](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-slide-over-portrait.png?raw=true)|![UIOnboarding Slide Over Landscape](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-slide-over-landscape.png?raw=true)|

### Accessibility

| Dynamic Type | VoiceOver | Reduce Motion |
|-|-|-|
|![UIOnboarding Preview Dynamic Type](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/290422-iphone-1.1.0/290422-iphone-dynamic-type.gif)|![UIOnboarding Preview VoiceOver](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-iphone-1.1.0/290422-iphone-voice-over.gif)|![UIOnboarding Preview Redcue Motion](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/290422-iphone-1.1.0/290422-reduce-motion.gif)|

## Installation

### Swift Package Manager

Add ```https://github.com/lascic/UIOnboarding.git``` in the package manager in Xcode (under File/Add Packages...). Select the version from ```1.2.0``` or the ```main``` branch.

```swift
.package(url: "https://github.com/lascic/UIOnboarding.git", from: "1.2.0")
// or
.package(url: "https://github.com/lascic/UIOnboarding.git", branch: "main")
```

### Demo Project

Three demo projects can be found in the [```/Demo```](https://github.com/lascic/UIOnboarding/tree/main/Demo) directory, including an example for utilizing UIOnboarding in a SwiftUI app.

Clone the repo or download the demo projects as a .zip file to open and run them on a physical device or simulator in Xcode.

Before building and running the projects, make sure to set them up with your own provisioning profile.

## Usage 

```UIOnboardingViewController```
takes a [```UIOnboardingViewConfiguration```](#configuration) parameter for setup.

### UIKit

Make sure the view controller you're presenting from is embedded in a ```UINavigationController```. ```OnboardingViewController``` has been set up to be presented as a full screen view. 

``` swift
// In the view controller you're presenting
import UIKit
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

SwiftUI's ```UIViewControllerRepresentable``` protocol makes the UIKit ```UIOnboardingViewController``` behave as a SwfitUI ```View```.

Create an ```OnboardingView``` struct implementing the protocol and use the ```.fullScreenCover()``` modifier introduced in iOS and iPadOS 14 to show it in the SwiftUI view you're presenting from.

``` swift
.fullScreenCover(isPresented: $showingOnboarding, content: {
    OnboardingView.init()
        .edgesIgnoringSafeArea(.all)
}
```

Note that we assign SwiftUI's coordinator as the delegate object for our onboarding view controller.
``` swift
onboardingController.delegate = context.coordinator
```

#### Full Setup

``` swift 
// In OnboardingView.swift
import SwiftUI
import UIOnboarding

struct OnboardingView: UIViewControllerRepresentable {
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
import SwiftUI

struct ContentView: View {
    @State private var showingOnboarding = true
    
    var body: some View {
        NavigationView {
            Text("Hello, UIOnboarding!")
                .toolbar {
                    Button {
                        showingOnboarding = true
                    } label: {
                        Image(systemName: "repeat")
                    }
                }
                .fullScreenCover(isPresented: $showingOnboarding, content: {
                    OnboardingView.init()
                        .edgesIgnoringSafeArea(.all)
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider { 
    static var previews: some View {
        ContentView.init()
    }
}
```

## Configuration

```UIOnboardingViewConfiguration``` consists of six, non-optional component types.
1. App Icon as ```UIImage```
2. First Welcome Title Line as ```NSMutableAttributedString```
3. Second Welcome Title Line as ```NSMutableAttributedString```
4. Core Features as ```Array<UIOnboardingFeature>```
5. Notice Text as ```UIOnboardingTextViewConfiguration``` (e.g. Privacy Policy, Terms of Service, Portfolio, Website)
6. Continuation Title as ```UIOnboardingButtonConfiguration```

Create a helper struct ```UIOnboardingHelper``` defining these components and combine them in an [extension](#extension) of ```UIOnboardingViewConfiguration```.

### Example

``` swift
import UIKit
import UIOnboarding

struct UIOnboardingHelper {
    // App Icon
    static func setUpIcon() -> UIImage {
        return Bundle.main.appIcon ?? .init(named: "onboarding-icon")!
    }

    // First Title Line
    // Welcome Text
    static func setUpFirstTitleLine() -> NSMutableAttributedString {
        .init(string: "Welcome to", attributes: [.foregroundColor: UIColor.label])
    }
    
    // Second Title Line
    // App Name
    static func setUpSecondTitleLine() -> NSMutableAttributedString {
        .init(string: Bundle.main.displayName ?? "Insignia", attributes: [
            .foregroundColor: UIColor.init(named: "camou")!
        ])
    }

    // Core Features
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

    // Notice Text
    static func setUpNotice() -> UIOnboardingTextViewConfiguration {
        return .init(icon: .init(named: "onboarding-notice-icon")!,
                     text: "Developed and designed for members of the Swiss Armed Forces.",
                     linkTitle: "Learn more...",
                     link: "https://www.lukmanascic.ch/portfolio/insignia",
                     tint: .init(named: "camou"))
    }

    // Continuation Title
    static func setUpButton() -> UIOnboardingButtonConfiguration {
        return .init(title: "Continue",
                     titleColor: .white, // Optional, `.white` by default
                     backgroundColor: .init(named: "camou")!)
    }
}
```

### Welcome Title Localization

If the welcome title only needs one line (in another language for example), simply provide an empty `NSMutableAttributedString` value for either parameter. `UIOnboardingTitleLabelStack` automatically resizes itself to the corresponding line count, with no additional changes needed.

Below an example in Portuguese, leaving the second title line blank.
```swift
// First Title Line
// App Name
static func setUpFirstTitleLine() -> NSMutableAttributedString {
    return .init(string: Bundle.main.displayName ?? "Distintivos", attributes: [
            .foregroundColor: UIColor.init(named: "camou")!
    ])
}

// Second Title Line
// Empty
static func setUpSecondTitleLine() -> NSMutableAttributedString {
    return .init(string: "")
}
```

### Extension

``` swift
import UIOnboarding

extension UIOnboardingViewConfiguration {
    // UIOnboardingViewController init
    static func setUp() -> UIOnboardingViewConfiguration {
        return .init(appIcon: UIOnboardingHelper.setUpIcon(),
                     firstTitleLine: UIOnboardingHelper.setUpFirstTitleLine(),
                     secondTitleLine: UIOnboardingHelper.setUpSecondTitleLine(),
                     features: UIOnboardingHelper.setUpFeatures(),
                     textViewConfiguration: UIOnboardingHelper.setUpNotice(),
                     buttonConfiguration: UIOnboardingHelper.setUpButton())
    }
}
```

## Further Setup

You may present the weclome screen only once (on first app launch) with the help of a ```User Defaults``` flag. Note that an unspecified UserDefaults ```bool(forKey:)``` key is set to ```false``` by default.

``` swift 
if !UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") {
    showOnboarding()
}
```

Toggle onboarding completion in the provided delegate method.

``` swift
func didFinishOnboarding(onboardingViewController: OnboardingViewController) {
    onboardingViewController.modalTransitionStyle = .crossDissolve
    onboardingViewController.dismiss(animated: true) { 
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }
}
```

## Further Readings
- [Developing Accessible iOS Apps](https://link.springer.com/book/10.1007/978-1-4842-5308-3) by [Daniel Devesa Derksen-Staats](https://twitter.com/dadederk?s=21)
- [Dynamic Type](https://developer.apple.com/videos/play/wwdc2017/245/#:~:text=The%20Dynamic%20Type%20settings%20can,enable%20five%20even%20larger%20sizes.) in UIKit
- [Typography](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/) in [Apple's Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/overview/themes/)
- [Text Size and Weight](https://developer.apple.com/design/human-interface-guidelines/accessibility/overview/text-size-and-weight/) in [Apple's Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/overview/themes/)
- [VoiceOver](https://developer.apple.com/documentation/accessibility/supporting_voiceover_in_your_app) in UIKit
- [```isReduceMotionEnabled```](https://developer.apple.com/documentation/uikit/uiaccessibility/1615133-isreducemotionenabled) in UIKit
- [```traitCollectionDidChange(_:)```](https://developer.apple.com/documentation/uikit/uitraitenvironment/1623516-traitcollectiondidchange) in UIKit
- [```viewWillTransition(to:with:)```](https://developer.apple.com/documentation/uikit/uicontentcontainer/1621466-viewwilltransition) in UIKit
- [```UIViewControllerRepresentable```](https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable) in SwiftUI
- [```makeCoordinator()```](https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable/makecoordinator()-32trb) in SwiftUI
- [```UserDefaults```](https://developer.apple.com/documentation/foundation/userdefaults) in Foundation

## Copyright

UIOnboarding is [MIT](https://github.com/lascic/UIOnboarding/blob/main/LICENSE) licensed.

The [Insignia](https://apps.apple.com/ch/app/abzeichen/id1551002238) app icon and [Insignia](https://apps.apple.com/ch/app/abzeichen/id1551002238) feature cell assets are copyright Lukman Aščić. All rights reserved. None of these materials or parts of it may be reproduced or distributed by any means without prior written permission of the copyright owner.
