//
//  UIOnboardingButtonConfiguration.swift
//  UIOnboarding
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

public struct UIOnboardingButtonConfiguration {
    public var title: String
    public var titleColor: UIColor
    public var backgroundColor: UIColor

    public init(title: String,
                titleColor: UIColor = .white,
                backgroundColor: UIColor) {
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
    }
}
