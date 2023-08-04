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

struct UIOnboardingFeatureStyle {
    var titleFontName: String
    var titleFontSize: CGFloat
    var descriptionFontName: String
    var descriptionFontSize: CGFloat
    var spacing: CGFloat
    
    init(titleFontName: String = "", titleFontSize: CGFloat = 17, descriptionFontName: String = "", descriptionFontSize: CGFloat = 17, spacing: CGFloat = 0.8) {
        self.titleFontName = titleFontName
        self.titleFontSize = titleFontSize
        self.descriptionFontName = descriptionFontName
        self.descriptionFontSize = descriptionFontSize
        self.spacing = spacing
    }
}
