//
//  UIOnboardingViewConfiguration.swift
//  UIOnboarding
//
//  Created by Vyacheslav on 12.07.2023.
//

import UIKit

// MARK: - UIOnboardingViewConfiguration
public struct UIOnboardingViewConfiguration {
    // MARK: - Feature
    public enum Feature {
        case plain(UIOnboardingFeature)
        case checkBox(UIOnboardingFeatureCheckBox)
    }

    // MARK: - Properties
    var appIcon: UIImage
    var firstTitleLine: NSMutableAttributedString
    var secondTitleLine: NSMutableAttributedString
    var features: [Feature]
    var textViewConfiguration: UIOnboardingTextViewConfiguration? = nil
    var buttonConfiguration: UIOnboardingButtonConfiguration

    // MARK: - Init
    public init(
        appIcon: UIImage,
        firstTitleLine: NSMutableAttributedString,
        secondTitleLine: NSMutableAttributedString,
        features: [Feature],
        textViewConfiguration: UIOnboardingTextViewConfiguration? = nil,
        buttonConfiguration: UIOnboardingButtonConfiguration
    ) {
        self.appIcon = appIcon
        self.firstTitleLine = firstTitleLine
        self.secondTitleLine = secondTitleLine
        self.features = features
        self.textViewConfiguration = textViewConfiguration
        self.buttonConfiguration = buttonConfiguration
    }
}
