//
//  UIOnboardingButton.swift
//  UIOnboarding
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

final class UIOnboardingButton: UIButton {
    weak var delegate: UIOnboardingButtonDelegate?
    private var fontName: String = ""
    
    convenience init(withConfiguration configuration: UIOnboardingButtonConfiguration) {
        self.init(type: .system)
        fontName = configuration.fontName
        configureFont()
        setTitle(configuration.title, for: .normal)
        
        #if !targetEnvironment(macCatalyst)
            setTitleColor(configuration.titleColor, for: .normal)
            backgroundColor = configuration.backgroundColor
        #endif
        
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
        
        accessibilityTraits = .button
        
        titleLabel?.adjustsFontForContentSizeCategory = true
        translatesAutoresizingMaskIntoConstraints = false
        isAccessibilityElement = true
        
        if #available(iOS 13.4, *) {
            isPointerInteractionEnabled = true
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

extension UIOnboardingButton {
    func configureFont() {
        if let customFont = UIFont(name: fontName, size: traitCollection.horizontalSizeClass == .regular ? 19 : 17) {
            let dynamicCustomFont = UIFontMetrics.default.scaledFont(for: customFont)
            titleLabel?.font = dynamicCustomFont
        } else {
            titleLabel?.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular ? 19 : 17, weight: .bold))
        }
    }
}
