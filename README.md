# UIOnboarding

![UIOnboarding Title Page](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/290422-iphone-ipad-1.1.0.png)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flascic%2FUIOnboarding%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/lascic/UIOnboarding)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flascic%2FUIOnboarding%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/lascic/UIOnboarding)

Configurable animated onboarding screen written programmatically in Swift for UIKit – inspired by the Apple Stocks app – with [Insignia](https://apps.apple.com/ch/app/abzeichen/id1551002238) as an example.

Developed and designed by [Lukman Aščić](https://twitter.com/lascic).

UIOnboarding supports iPhone, iPad and iPod touch running iOS and iPadOS 13 or higher, including core accessibility features such as Dynamic Type, VoiceOver, Reduce Motion for all devices and Split View and Slide Over for iPad.

## Table of Contents

- [Previews](#previews)
    - [iPhone and iPod touch](#iphone-and-ipod-touch)
    - [iPad](#ipad)
    - [Accessibility](#accessibility)
    - [Split View](#split-view)
    - [Slide Over](#slide-over)
- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [Demo Project Download](#demo-project-download)
- [Usage](#usage)
    - [UIKit](#uikit)
    - [SwiftUI](#swiftui)
- [Configuration](#configuration)
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

### Accessibility

| Dynamic Type | VoiceOver | Reduce Motion |
|-|-|-|
|![UIOnboarding Preview Dynamic Type](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/290422-iphone-1.1.0/290422-iphone-dynamic-type.gif)|![UIOnboarding Preview VoiceOver](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-iphone-1.1.0/290422-iphone-voice-over.gif)|![UIOnboarding Preview Redcue Motion](https://raw.githubusercontent.com/lascic/UIOnboarding/main/readme-resources/290422-iphone-1.1.0/290422-reduce-motion.gif)|

### Split View

| 1/3 iPad Landscape | 1/2 iPad Landscape | 2/3 iPad Landscape |
|-|-|-|
|![UIOnboarding Slit View 1/3 Landscape](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-split-view-landscape-3.png?raw=true)|![UIOnboarding Slit View 1/2 Landscape](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-split-view-landscape-1.png?raw=true)|![UIOnboarding Slit View 2/3 Landscape](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-split-view-landscape-2.png?raw=true)|

| 1/3 iPad Portrait | 2/3 iPad Portrait |
|-|-|
|![UIOnboarding Slit View 1/3 Portrait](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-split-view-portrait-2.png?raw=true)|![UIOnboarding Slit View 2/3 Portrait](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-split-view-portrait-1.png?raw=true)|

### Slide Over

| iPad Portrait | iPad Landscape |
|-|-|
|![UIOnboarding Slide Over Portrait](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-slide-over-portrait.png?raw=true)|![UIOnboarding Slide Over Landscape](https://github.com/lascic/UIOnboarding/blob/main/readme-resources/290422-ipad-1.1.0/290422-ipad-slide-over-landscape.png?raw=true)|

## Installation

### Swift Package Manager

To install ```UIOnboarding``` as a package, add ```https://github.com/lascic/UIOnboarding.git``` in the package manager in Xcode (under File/Add Packages...). Select the version from ```1.1.3``` or the ```main``` branch.

```swift
.package(url: "https://github.com/lascic/UIOnboarding.git", from: "1.1.3")
// or
.package(url: "https://github.com/lascic/UIOnboarding.git", branch: "main")
```

### Demo Project Download

There is a demo project with and without SPM in the ```Demo``` directory: ```Demo/UIOnboarding Demo``` and ```Demo/UIOnboarding Demo SPM```. This folder also provides an example for using it in a SwiftUI app: ```Demo/UIOnboarding SwiftUI```. 

You can download them as a .zip file to run it on a physical device or simulator in Xcode.

Before building and running the project, make sure to set it up with your own provisioning profile.

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

We rely on SwiftUI's ```UIViewControllerRepresentable``` protocol to make the UIKit ```UIOnboardingViewController``` behave as a SwfitUI ```View```.

Create an ```OnboardingView``` struct which implements the protocol and use the ```.fullScreenCover()``` modifier introduced in iOS and iPadOS 14 to show it in your SwiftUI view you're presenting from.

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

```UIOnboardingViewConfiguration``` consists of five components.
1. App Icon as ```UIImage```
2. Welcome Title as ```NSMutableAttributedString```
3. Core Features as ```Array<UIOnboardingFeature>```
4. Notice Text as ```UIOnboardingTextViewConfiguration``` (e.g. Privacy Policy, Terms of Service, Portfolio Website)
5. Continuation Title as ```UIOnboardingButtonConfiguration```

In a helper struct ```UIOnboardingHelper``` we define these components and combine them in an [extension](#extension) of ```UIOnboardingViewConfiguration```.

### Example

``` swift
import UIKit
import UIOnboarding

struct UIOnboardingHelper {
    // App Icon
    static func setUpIcon() -> UIImage {
        return Bundle.main.appIcon ?? .init(named: "onboarding-icon")!
    }

    // Welcome Title
    static func setUpTitle() -> NSMutableAttributedString {
        let welcomeText: NSMutableAttributedString = .init(string: "Welcome to \n",
                                                           attributes: [.foregroundColor: UIColor.label]),
            appNameText: NSMutableAttributedString = .init(string: Bundle.main.displayName ?? "Insignia",
                                                           attributes: [.foregroundColor: UIColor.init(named: "camou")!])
        welcomeText.append(appNameText)
        return welcomeText
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
                     backgroundColor: .init(named: "camou")!)
    }
}
```


### Extension

``` swift
import UIOnboarding

extension UIOnboardingViewConfiguration {
    // UIOnboardingViewController init
    static func setUp() -> UIOnboardingViewConfiguration {
        return .init(appIcon: UIOnboardingHelper.setUpIcon(),
                     welcomeTitle: UIOnboardingHelper.setUpTitle(),
                     features: UIOnboardingHelper.setUpFeatures(),
                     textViewConfiguration: UIOnboardingHelper.setUpNotice(),
                     buttonConfiguration: UIOnboardingHelper.setUpButton())
    }
}
```

## Further Setup

You may present the onboarding screen only once (on first app launch) with the help of a ```User Defaults``` flag. Note that an unspecified UserDefaults ```bool(forKey:)``` key is set to ```false``` by default.

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

The Insignia app icon and Insignia feature cell assets are copyright Lukman Aščić. All rights reserved. None of these materials or parts of it may be reproduced or distributed by any means without prior written permission of the copyright owner.
