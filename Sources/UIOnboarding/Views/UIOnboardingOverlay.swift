//
//  UIOnboardingOverlay.swift
//  UIOnboarding Example
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

final class UIOnboardingOverlay: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForOnboarding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareForOnboarding() {
        translatesAutoresizingMaskIntoConstraints = false

        let blurEffect: UIBlurEffect = .init(style: .regular)
        let blurEffectView: UIVisualEffectView = .init(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.backgroundColor = .clear
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        alpha = 0
    }
}
