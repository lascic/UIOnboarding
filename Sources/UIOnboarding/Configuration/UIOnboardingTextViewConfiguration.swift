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
    public var tint: UIColor?

    public init(icon: UIImage? = nil,
                text: String,
                linkTitle: String? = nil,
                fontName: String = "",
                fontWeight: UIFont.Weight? = nil,
                link: String? = nil,
                tint: UIColor? = nil) {
        self.icon = icon
        self.text = text
        self.linkTitle = linkTitle
        self.fontName = fontName
        self.fontWeight = fontWeight
        self.link = link
        self.tint = tint
    }
}
