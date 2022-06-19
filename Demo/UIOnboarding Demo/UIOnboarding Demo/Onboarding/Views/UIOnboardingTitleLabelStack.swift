//
//  UIOnboardingTitleLabelStack.swift
//  UIOnboarding Demo
//
//  Created by Felix Lisczyk on 10.06.22.
//

import UIKit

final class UIOnboardingTitleLabelStack: UIStackView {
    private let configuration: UIOnboardingViewConfiguration
    private let welcomeLabel: UIOnboardingTitleLabel
    private let appNameLabel: UIOnboardingTitleLabel
    
    init(withConfiguration configuration: UIOnboardingViewConfiguration) {
        self.configuration = configuration
        self.welcomeLabel = .init(attributedText: configuration.welcomeTitle)
        self.appNameLabel = .init(attributedText: configuration.appTitle)
        
        super.init(frame: .zero)
        axis = .vertical
        
        addArrangedSubview(welcomeLabel)
        addArrangedSubview(appNameLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        determineFontSize()
    }
}

extension UIOnboardingTitleLabelStack {
    func setLineHeight(lineHeight: CGFloat) {
        welcomeLabel.setLineHeight(lineHeight: lineHeight)
        appNameLabel.setLineHeight(lineHeight: lineHeight)
    }
    
    func setFont(font: UIFont) {
        welcomeLabel.font = font
        appNameLabel.font = font
    }
}

private extension UIOnboardingTitleLabelStack {
    /// Adjusts the font size for both welcome and app name labels depending on which one has the smaller font size. Helpful for localized projects.
    ///
    /// The UIOnboardingTitleLabel instances are designed to have the same fixed font size, regardless of Dynamic Text setting. This is because the title should be kept short for the animation at the beginning and to give space for the listed features to fit.
    ///
    /// However, if either the welcome text or app name text can not fit the font size it is being assigned to, the method determines the minimum font size and applies it for both in the title label stack.
    ///
    /// This is usually the case for longer  welcome title label texts. It is not best practice to use long app names. If that would be the case, the method also checks whether the app name is longer than the welcome text and adjusts the font sizes accordingly.
    func determineFontSize() {
        let welcomeLabelFontSize: CGFloat = welcomeLabel.calculateActualFontSize()
        let appNameLabelFontSize: CGFloat = appNameLabel.calculateActualFontSize()
        
        if welcomeLabelFontSize < appNameLabelFontSize {
            appNameLabel.font = welcomeLabel.font.withSize(welcomeLabelFontSize)
        } else if appNameLabelFontSize < welcomeLabelFontSize {
            welcomeLabel.font = appNameLabel.font.withSize(appNameLabelFontSize)
        }
    }
}
