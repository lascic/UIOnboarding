//
//  UIOnboardingViewConfiguration.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

struct UIOnboardingViewConfiguration {
    var appIcon: UIImage
    var firstTitleLine: NSMutableAttributedString
    var secondTitleLine: NSMutableAttributedString
    var features: Array<UIOnboardingFeature>
    let featureStyle: UIOnboardingFeatureStyle
    var textViewConfiguration: UIOnboardingTextViewConfiguration? = nil
    var buttonConfiguration: UIOnboardingButtonConfiguration
    
    init(appIcon: UIImage,
         firstTitleLine: NSMutableAttributedString,
         secondTitleLine: NSMutableAttributedString,
         features: Array<UIOnboardingFeature>,
         featureStyle: UIOnboardingFeatureStyle = .init(),
         textViewConfiguration: UIOnboardingTextViewConfiguration? = nil,
         buttonConfiguration: UIOnboardingButtonConfiguration) {
        self.appIcon = appIcon
        self.firstTitleLine = firstTitleLine
        self.secondTitleLine = secondTitleLine
        self.features = features
        self.featureStyle = featureStyle
        self.textViewConfiguration = textViewConfiguration
        self.buttonConfiguration = buttonConfiguration
    }
}
