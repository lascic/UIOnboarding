//
//  UIOnboardingTitleLabel.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

final class UIOnboardingTitleLabel: UIIntrinsicLabel {
    private lazy var fontSize: CGFloat = traitCollection.horizontalSizeClass == .regular ? 80 : (UIScreenType.isiPhoneSE || UIScreenType.isiPhone6s ? 41 : 44)

    init(attributedText: NSAttributedString) {
        super.init(frame: .zero)
        self.attributedText = attributedText
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        numberOfLines = 1
        lineBreakMode = .byWordWrapping
        
        if font.familyName == ".AppleSystemUIFont", font.fontName == ".SFUI-Regular" {
            font = .systemFont(ofSize: fontSize, weight: .heavy)
        }

        accessibilityHint = "Headline"
        accessibilityTraits = .staticText

        isAccessibilityElement = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.5
    }
}

extension UIOnboardingTitleLabel {
    func updateFontSize(_ fontSize: CGFloat) {
        guard let attributedString = attributedText else { return }
        let originalFont = font
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
        mutableAttributedString.enumerateAttributes(in: NSRange(location: 0,
                                                                length: mutableAttributedString.length),
                                                    options: []) { attributes, range, _ in
            if let font = attributes[.font] as? UIFont {
                let multiplier = font.pointSize / (originalFont?.pointSize ?? font.pointSize)
                let newFont = font.withSize(fontSize * multiplier)
                mutableAttributedString.addAttribute(.font, value: newFont, range: range)
            }
        }
        
        self.attributedText = mutableAttributedString
    }
    
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
        
    func calculateActualFontSize() -> CGFloat {
        let maximumSizedLabel: UILabel = .init()
        maximumSizedLabel.font = font
        maximumSizedLabel.text = text
        maximumSizedLabel.sizeToFit()
        
        var actualFontSize: CGFloat = font.pointSize * (bounds.size.width / maximumSizedLabel.bounds.size.width);
        
        actualFontSize = actualFontSize < font.pointSize ? actualFontSize : self.font.pointSize; // Set the actual font size if default is not given
        
        return actualFontSize
    }
}
