//
//  UIOnboardingTitle.swift
//  UIOnboarding Example
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

final class UIOnboardingTitle: UILabel {
    private let configuration: UIOnboardingViewConfiguration
    private lazy var fontSize: CGFloat = traitCollection.horizontalSizeClass == .regular ? 80 : (UIScreenType.isiPhoneSE || UIScreenType.isiPhone6s ? 41 : 44)

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
        
        font = .systemFont(ofSize: fontSize, weight: .heavy)
        
        accessibilityHint = "Headline"
        accessibilityTraits = .staticText

        isAccessibilityElement = true
        adjustsFontSizeToFitWidth = true
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (UIScreenType.setUpPadding() * 2)).isActive = true
    }
}

extension UIOnboardingTitle {
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle: NSMutableParagraphStyle = .init()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = textAlignment

        let attrString: NSMutableAttributedString = .init()
        if (attributedText != nil) {
            attrString.append(attributedText!)
        } else {
            attrString.append(.init(string: text!))
            attrString.addAttribute(.font, value: font as Any, range: .init(location: 0, length: attrString.length))
        }
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: attrString.length))
        attributedText = attrString
    }
}
