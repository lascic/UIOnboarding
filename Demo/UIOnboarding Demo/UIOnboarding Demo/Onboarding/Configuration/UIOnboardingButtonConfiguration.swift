//
//  UIOnboardingButtonConfiguration.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

public struct UIOnboardingButtonConfiguration {
    var title: String
    var titleColor: UIColor
    var backgroundColor: UIColor

    public init(
        title: String,
        titleColor: UIColor = .white,
        backgroundColor: UIColor
    ) {
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
    }
}
