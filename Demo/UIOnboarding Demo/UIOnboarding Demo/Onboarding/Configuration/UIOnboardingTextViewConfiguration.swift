//
//  UIOnboardingTextViewConfiguration.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

struct UIOnboardingTextViewConfiguration {
    var icon: UIImage?
    var text: String
    var linkTitle: String?
    var link: String?
    var tint: UIColor?

    init(icon: UIImage? = nil,
         text: String,
         linkTitle: String? = nil,
         link: String? = nil,
         tint: UIColor? = nil) {
        self.icon = icon
        self.text = text
        self.linkTitle = linkTitle
        self.link = link
        self.tint = tint
    }
}
