//
//  UIOnboardingFeature.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

struct UIOnboardingFeature {
    var icon: UIImage!
    var iconTint: UIColor
    var title: String
    var description: String
    
    init(icon: UIImage!, iconTint: UIColor = .label, title: String, description: String) {
        self.icon = icon
        self.iconTint = iconTint
        self.title = title
        self.description = description
    }
}
