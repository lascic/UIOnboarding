//
//  UIOnboardingFeature.swift
//  UIOnboarding
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

public struct UIOnboardingFeature {
    public var icon: UIImage
    public var iconTint: UIColor
    public var title: String
    public var description: String
    
    public init(icon: UIImage, iconTint: UIColor = .label, title: String, description: String) {
        self.icon = icon
        self.iconTint = iconTint
        self.title = title
        self.description = description
    }
}

public struct UIOnboardingFeatureStyle {
    public var titleFontName: String
    public var titleFontSize: CGFloat
    public var descriptionFontName: String
    public var descriptionFontSize: CGFloat
    public var spacing: CGFloat
    
    public init(titleFontName: String = "", titleFontSize: CGFloat = 17, descriptionFontName: String = "", descriptionFontSize: CGFloat = 17, spacing: CGFloat = 0.8) {
        self.titleFontName = titleFontName
        self.titleFontSize = titleFontSize
        self.descriptionFontName = descriptionFontName
        self.descriptionFontSize = descriptionFontSize
        self.spacing = spacing
    }
}
