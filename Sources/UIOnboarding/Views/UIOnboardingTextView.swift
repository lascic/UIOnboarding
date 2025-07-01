//
//  UIOnboardingTextView.swift
//  UIOnboarding
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

final class UIOnboardingTextView: UITextView {
    private let configuration: UIOnboardingTextViewConfiguration
    private var onLinkPressed: ((URL) -> Bool)?
            
    init(withConfiguration configuration: UIOnboardingTextViewConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero, textContainer: nil)
        configureTextContent(configuration: configuration)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textAlignment = .center
        backgroundColor = .clear
        textContainerInset = .init(top: 0, left: 0, bottom: 30, right: 0)
        textColor = .secondaryLabel
        if let linkColor = configuration.linkColor {
            tintColor = linkColor
        }
        
        accessibilityHint = "Notice text and link"
        accessibilityTraits = .staticText
        accessibilityValue = "\(configuration.text) \(configuration.linkTitle ?? .init())"
        
        delegate = self
        isEditable = false
        isSelectable = true
        isScrollEnabled = false
        isAccessibilityElement = true
        accessibilityIgnoresInvertColors = true
        adjustsFontForContentSizeCategory = true
        translatesAutoresizingMaskIntoConstraints = false
        
        configureFont()
    }
}

extension UIOnboardingTextView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return onLinkPressed?(URL) ?? true
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.selectedTextRange = nil
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard super.point(inside: point, with: event) else {
            return false
        }
        guard let pos = closestPosition(to: point), let range = tokenizer.rangeEnclosingPosition(pos, with: .character, inDirection: UITextDirection(rawValue: 3)) else {
            return false
        }
        let startIndex = offset(from: beginningOfDocument, to: range.start)
        return attributedText.attribute(.link, at: startIndex, effectiveRange: nil) != nil
    }
}

private extension UIOnboardingTextView {
    func addLinks(_ links: Dictionary<String, String>) {
        guard attributedText.length > 0 else {
            return
        }
        let text: NSMutableAttributedString = .init(attributedString: attributedText)
        
        for (linkText, urlString) in links {
            if linkText.count > 0 {
                let linkRange = text.mutableString.range(of: linkText)
                text.addAttribute(.link, value: urlString, range: linkRange)
            }
        }
        attributedText = text
    }
    
    func configureTextContent(configuration: UIOnboardingTextViewConfiguration) {
        let text: NSMutableAttributedString = .init()
        
        let noticeText = configuration.text
        text.append(.init(string: "\(noticeText)"))
        
        if let noticeLink = configuration.link, let noticeLinkTitle = configuration.linkTitle {
            text.append(.init(string: " \(noticeLinkTitle)"))
            attributedText = text
            
            addLinks([
                noticeLinkTitle: noticeLink,
            ])
            
            onLinkPressed = { (url) in
                return true
            }
        } else {
            attributedText = text
        }
    }
}

extension UIOnboardingTextView {
    func configureFont() {
        let defaultFontSize: CGFloat = 13
        let biggerFontSize: CGFloat = 15
        let maximumDefaultFontSize: CGFloat = 19
        let maximumBiggerFontSize: CGFloat = 21

        if let customFont = UIFont(name: configuration.fontName, size: traitCollection.horizontalSizeClass == .regular ? biggerFontSize : defaultFontSize) {
            if #available(iOS 15.0, *) {
                font =  UIFontMetrics.default.scaledFont(for: customFont)
                maximumContentSizeCategory = .accessibilityMedium
            } else {
                font = UIFontMetrics.default.scaledFont(for: customFont, maximumPointSize: traitCollection.horizontalSizeClass == .regular ? maximumBiggerFontSize : maximumDefaultFontSize)
            }
        } else {
            let weight = configuration.fontWeight ?? .regular
            if #available(iOS 15.0, *) {
                font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular ? biggerFontSize : defaultFontSize, weight: weight))
                maximumContentSizeCategory = .accessibilityMedium
            } else {
                font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular ? biggerFontSize : defaultFontSize, weight: weight), maximumPointSize: traitCollection.horizontalSizeClass == .regular ? maximumBiggerFontSize : maximumDefaultFontSize)
            }
        }
    }
}
