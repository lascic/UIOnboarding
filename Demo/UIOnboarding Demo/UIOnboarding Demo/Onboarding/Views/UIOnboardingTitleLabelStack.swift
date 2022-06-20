//
//  UIOnboardingTitleLabelStack.swift
//  UIOnboarding Demo
//
//  Created by Felix Lisczyk on 10.06.22.
//

import UIKit

final class UIOnboardingTitleLabelStack: UIStackView {
    private let configuration: UIOnboardingViewConfiguration
    private let firstTitleLineLabel: UIOnboardingTitleLabel, secondTitleLineLabel: UIOnboardingTitleLabel
    
    init(withConfiguration configuration: UIOnboardingViewConfiguration) {
        self.configuration = configuration
        firstTitleLineLabel = .init(attributedText: configuration.firstTitleLine)
        secondTitleLineLabel = .init(attributedText: configuration.secondTitleLine)
        
        super.init(frame: .zero)
        axis = .vertical
        
        addArrangedSubview(firstTitleLineLabel)
        addArrangedSubview(secondTitleLineLabel)
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
        firstTitleLineLabel.setLineHeight(lineHeight: lineHeight)
        secondTitleLineLabel.setLineHeight(lineHeight: lineHeight)
    }
    
    func setFont(font: UIFont) {
        firstTitleLineLabel.font = font
        secondTitleLineLabel.font = font
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
        let welcomeLabelFontSize: CGFloat = firstTitleLineLabel.calculateActualFontSize()
        let appNameLabelFontSize: CGFloat = secondTitleLineLabel.calculateActualFontSize()
        
        if welcomeLabelFontSize < appNameLabelFontSize {
            secondTitleLineLabel.font = firstTitleLineLabel.font.withSize(welcomeLabelFontSize)
        } else if appNameLabelFontSize < welcomeLabelFontSize {
            firstTitleLineLabel.font = secondTitleLineLabel.font.withSize(appNameLabelFontSize)
        }
    }
}
