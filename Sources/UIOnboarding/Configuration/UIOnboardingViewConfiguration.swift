//
//  UIOnboardingViewConfiguration.swift
//  UIOnboarding
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

public struct UIOnboardingViewConfiguration {
    public var appIcon: UIImage
    public var firstTitleLine: NSMutableAttributedString
    public var secondTitleLine: NSMutableAttributedString
    public var features: Array<UIOnboardingFeature>
    public var textViewConfiguration: UIOnboardingTextViewConfiguration? = nil
    public var buttonConfiguration: UIOnboardingButtonConfiguration
    
    public init(appIcon: UIImage,
                firstTitleLine: NSMutableAttributedString,
                secondTitleLine: NSMutableAttributedString,
                features: Array<UIOnboardingFeature>,
                textViewConfiguration: UIOnboardingTextViewConfiguration? = nil,
                buttonConfiguration: UIOnboardingButtonConfiguration) {
        self.appIcon = appIcon
        self.firstTitleLine = firstTitleLine
        self.secondTitleLine = secondTitleLine
        self.features = features
        self.textViewConfiguration = textViewConfiguration
        self.buttonConfiguration = buttonConfiguration
    }
}
