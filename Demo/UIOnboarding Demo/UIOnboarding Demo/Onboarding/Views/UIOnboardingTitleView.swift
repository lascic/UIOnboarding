//
//  UIOnboardingTitleView.swift
//  UIOnboarding Demo
//
//  Created by Felix Lisczyk on 10.06.22.
//

import UIKit

final class UIOnboardingTitleView: UIStackView {
    private let configuration: UIOnboardingViewConfiguration
    private let welcomeLabel: UIOnboardingTitleLabel
    private let titleLabel: UIOnboardingTitleLabel
    
    init(withConfiguration configuration: UIOnboardingViewConfiguration) {
        self.configuration = configuration
        self.welcomeLabel = .init(attributedText: configuration.welcomeTitle)
        self.titleLabel = .init(attributedText: configuration.appTitle)
        
        super.init(frame: .zero)
        axis = .vertical
        
        addArrangedSubview(welcomeLabel)
        addArrangedSubview(titleLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIOnboardingTitleView {
    func setLineHeight(lineHeight: CGFloat) {
        welcomeLabel.setLineHeight(lineHeight: lineHeight)
        titleLabel.setLineHeight(lineHeight: lineHeight)
    }
    
    func setFont(font: UIFont) {
        welcomeLabel.font = font
        titleLabel.font = font
    }
}
