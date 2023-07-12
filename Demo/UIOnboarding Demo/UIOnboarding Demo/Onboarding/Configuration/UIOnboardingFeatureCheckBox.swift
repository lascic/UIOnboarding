//
//  UIOnboardingFeatureCheckBox.swift
//  UIOnboarding Demo
//
//  Created by Vyacheslav on 13.07.2023.
//

import UIKit

public struct UIOnboardingFeatureCheckBox {
    var icon: UIImage?
    var iconTint: UIColor?
    var title: String
    var description: String?
    var accessoryIcon: UIImage?

    public init(
        icon: UIImage? = nil,
        iconTint: UIColor? = .label,
        title: String,
        description: String? = nil,
        accessoryIcon: UIImage? = nil
    ) {
        self.icon = icon
        self.iconTint = iconTint
        self.title = title
        self.description = description
        self.accessoryIcon = accessoryIcon
    }
}
