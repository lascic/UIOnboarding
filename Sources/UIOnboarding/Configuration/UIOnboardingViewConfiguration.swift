//
//  UIOnboardingViewConfiguration.swift
//  UIOnboarding Example
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

public struct UIOnboardingViewConfiguration {
    public var appIcon: UIImage
    public var welcomeTitle: NSMutableAttributedString
    public var features: Array<UIOnboardingFeature>
    public var textViewConfiguration: UIOnboardingTextViewConfiguration
    public var buttonConfiguration: UIOnboardingButtonConfiguration
    
    public init(appIcon: UIImage,
         welcomeTitle: NSMutableAttributedString,
         features: Array<UIOnboardingFeature>,
         textViewConfiguration: UIOnboardingTextViewConfiguration,
         buttonConfiguration: UIOnboardingButtonConfiguration) {
        self.appIcon = appIcon
        self.welcomeTitle = welcomeTitle
        self.features = features
        self.textViewConfiguration = textViewConfiguration
        self.buttonConfiguration = buttonConfiguration
    }
}
