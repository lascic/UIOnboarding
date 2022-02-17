//
//  UIOnboardingViewConfiguration.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

struct UIOnboardingViewConfiguration {
    var appIcon: UIImage
    var welcomeTitle: NSMutableAttributedString
    var features: Array<UIOnboardingFeature>
    var textViewConfiguration: UIOnboardingTextViewConfiguration
    var buttonConfiguration: UIOnboardingButtonConfiguration
    
    init(appIcon: UIImage,
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
