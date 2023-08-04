//
//  UIOnboardingButtonConfiguration.swift
//  UIOnboarding
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

public struct UIOnboardingButtonConfiguration {
    public var title: String
    public var fontName: String
    public var titleColor: UIColor
    public var backgroundColor: UIColor

    public init(title: String,
                fontName: String = "",
                titleColor: UIColor = .white,
                backgroundColor: UIColor) {
        self.title = title
        self.fontName = fontName
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
    }
}
