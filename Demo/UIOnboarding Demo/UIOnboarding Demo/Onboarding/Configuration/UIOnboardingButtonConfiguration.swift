//
//  UIOnboardingButtonConfiguration.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

struct UIOnboardingButtonConfiguration {
    var title: String
    var fontName: String
    var titleColor: UIColor
    var backgroundColor: UIColor

    init(title: String,
         fontName: String = "",
         titleColor: UIColor = .white,
         backgroundColor: UIColor) {
        self.title = title
        self.fontName = fontName
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
    }
}
