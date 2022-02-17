//
//  UIOnboardingButtonConfiguration.swift
//  UIOnboarding Example
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

public struct UIOnboardingButtonConfiguration {
    public var title: String
    public var backgroundColor: UIColor

    public init(title: String,
                backgroundColor: UIColor) {
        self.title = title
        self.backgroundColor = backgroundColor
    }
}
