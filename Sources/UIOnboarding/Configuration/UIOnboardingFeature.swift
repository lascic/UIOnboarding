//
//  UIOnboardingFeature.swift
//  UIOnboarding Example
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
