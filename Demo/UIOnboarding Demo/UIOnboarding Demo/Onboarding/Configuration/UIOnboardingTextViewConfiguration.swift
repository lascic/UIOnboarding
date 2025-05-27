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
    var fontName: String
    var link: String?
    var linkColor: UIColor?
    var iconColor: UIColor?

    @available(*, deprecated, renamed: "linkColor", message: "'tint' has been renamed to 'linkColor'. Use 'linkColor' instead.")
    var tint: UIColor? {
        get { linkColor }
        set { linkColor = newValue }
    }

    init(icon: UIImage? = nil,
                text: String,
                linkTitle: String? = nil,
                fontName: String = "",
                link: String? = nil,
                linkColor: UIColor? = nil,
                iconColor: UIColor? = nil)
    {
        self.icon = icon
        self.text = text
        self.linkTitle = linkTitle
        self.fontName = fontName
        self.link = link
        self.linkColor = linkColor
        self.iconColor = iconColor
    }
}
