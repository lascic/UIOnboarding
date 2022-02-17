//
//  UIOnboardingTextView.swift
//  UIOnboarding Demo
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
        
        let icon: NSTextAttachment = .init()
        let symbol = configuration.icon
        icon.image = symbol
        icon.image = icon.image?.withTintColor(.secondaryLabel)
        
        let logoImageText: NSAttributedString = .init(attachment: icon)
        let text: NSMutableAttributedString = .init()
        text.append(logoImageText)
        
        let noticeText = configuration.text
        text.append(.init(string: "\n\n\(noticeText)"))
        
        if let noticeLink = configuration.link, let noticeLinkTitle = configuration.linkTitle {
            text.append(.init(string: " \(noticeLinkTitle)"))
            attributedText = text
            
            add(links: [
                noticeLinkTitle: noticeLink,
            ])
            
            onLinkPressed = { (url) in
                return true
            }
        } else {
            attributedText = text
        }
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
        if let tintColor = configuration.tint {
            self.tintColor = tintColor
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
        
        if #available(iOS 15.0, *) {
            font =  UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 13))
            maximumContentSizeCategory = .accessibilityMedium
        } else {
            font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 13), maximumPointSize: 19)
        }
    }
    
    private func add(links: Dictionary<String, String>) {
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
