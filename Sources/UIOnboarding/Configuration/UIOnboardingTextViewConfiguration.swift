//
//  UIOnboardingTextViewConfiguration.swift
//  UIOnboarding
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

public struct UIOnboardingTextViewConfiguration {
    public var icon: UIImage?
    public var text: String
    public var linkTitle: String?
    public var fontName: String
    public var fontWeight: UIFont.Weight?
    public var link: String?
    public var linkColor: UIColor?
    public var iconColor: UIColor?

    @available(*, deprecated, renamed: "linkColor", message: "'tint' has been renamed to 'linkColor'. Use 'linkColor' instead.")
    public var tint: UIColor? {
        get { linkColor }
        set { linkColor = newValue }
    }

    public init(icon: UIImage? = nil,
                text: String,
                linkTitle: String? = nil,
                fontName: String = "",
                fontWeight: UIFont.Weight? = nil,
                link: String? = nil,
                linkColor: UIColor? = nil,
                iconColor: UIColor? = nil)
    {
        self.icon = icon
        self.text = text
        self.linkTitle = linkTitle
        self.fontName = fontName
        self.fontWeight = fontWeight
        self.link = link
        self.linkColor = linkColor
        self.iconColor = iconColor
    }
}
