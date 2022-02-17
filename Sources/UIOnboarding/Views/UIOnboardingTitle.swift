//
//  UIOnboardingTitle.swift
//  UIOnboarding Example
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

final class UIOnboardingTitle: UILabel {
    private let configuration: UIOnboardingViewConfiguration

    init(withConfiguration configuration: UIOnboardingViewConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        attributedText = self.configuration.welcomeTitle
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        numberOfLines = 2
        lineBreakMode = .byWordWrapping
        font = .systemFont(ofSize: UIScreenType.isiPhoneSE || UIScreenType.isiPhone6s ? 41 : 44, weight: .heavy)
        
        accessibilityHint = "Headline"
        accessibilityTraits = .staticText

        isAccessibilityElement = true
        adjustsFontSizeToFitWidth = true

        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (UIScreenType.setUpPadding() * 2)).isActive = true
    }
}
