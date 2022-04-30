//
//  UIOnboardingButton.swift
//  UIOnboarding Example
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

final class UIOnboardingButton: UIButton {
    weak var delegate: UIOnboardingButtonDelegate?
    
    convenience init(withConfiguration configuration: UIOnboardingButtonConfiguration) {
        self.init(type: .system)
        setTitle(configuration.title, for: .normal)
        backgroundColor = configuration.backgroundColor
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = UIScreenType.isiPhoneSE ? 13 : 15
        layer.cornerCurve = .continuous
        titleLabel?.numberOfLines = 0
        
        setTitleColor(.white, for: .normal)
        accessibilityTraits = .button
        
        titleLabel?.adjustsFontForContentSizeCategory = true
        translatesAutoresizingMaskIntoConstraints = false
        isAccessibilityElement = true
        
        if #available(iOS 15.0, *) {
            titleLabel?.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular ? 19 : 17, weight: .bold))
//            titleLabel?.maximumContentSizeCategory = UIScreenType.isiPhone6s || UIScreenType.isiPhoneSE ? .extraLarge : .accessibilityExtraLarge
        } else {
            titleLabel?.font = UIFontMetrics.default.scaledFont(for: .preferredFont(forTextStyle: .headline), maximumPointSize: 21)
        }
        addTarget(self, action: #selector(handleCallToActionButton), for: .touchUpInside)
    }
        
    @objc private func handleCallToActionButton() {
        delegate?.didPressContinueButton()
    }
}

protocol UIOnboardingButtonDelegate: AnyObject {
    func didPressContinueButton()
}
