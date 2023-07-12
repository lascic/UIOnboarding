//
//  UIOnboardingHelper.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 17.02.22.
//

import UIKit

struct UIOnboardingHelper {
    static func setUpIcon() -> UIImage {
        Bundle.main.appIcon ?? .init(named: "onboarding-icon")!
    }
    
    // First Title Line
    // Welcome Text
    static func setUpFirstTitleLine() -> NSMutableAttributedString {
        .init(string: "Welcome to", attributes: [.foregroundColor: UIColor.label])
    }
    
    // Second Title Line
    // App Name
    static func setUpSecondTitleLine() -> NSMutableAttributedString {
        .init(string: Bundle.main.displayName ?? "Insignia", attributes: [
            .foregroundColor: UIColor.init(named: "camou") ?? UIColor.init(red: 0.654, green: 0.618, blue: 0.494, alpha: 1.0)
        ])
    }
    
//    static func setUpFeatures() -> Array<UIOnboardingViewConfiguration.Feature> {
//        [
//            .plain(.init(
//                icon: .init(named: "feature-1"),
//                title: "Search until found",
//                description: "Over a hundred insignia of the Swiss Armed Forces – each redesigned from the ground up.")
//            ),
//            .plain(.init(
//                icon: .init(named: "feature-2"),
//                title: "Enlist prepared",
//                description: "Practice with the app and pass the rank test on the first run.")
//            ),
//            .plain(.init(
//                icon: .init(named: "feature-3"),
//                title: "#teamarmee",
//                description: "Add name tags of your comrades or cadre. Insignia automatically keeps every name tag you create in iCloud.")
//            )
//        ]
//    }

    static func setUpFeatures() -> Array<UIOnboardingViewConfiguration.Feature> {
        [
            .checkBox(
                .init(
                    icon: .init(systemName: "bus"),
                    title: "Tourism",
                    description: "Over a hundred insignia of the Swiss Armed Forces – each redesigned from the ground up.")
            ),
            .checkBox(
                .init(
                    icon: .init(systemName: "cup.and.saucer.fill"),
                    title: "Catering"
                )
            )
        ]
    }
    
    static func setUpNotice() -> UIOnboardingTextViewConfiguration {
        .init(icon: .init(named: "onboarding-notice-icon"),
              text: "Developed and designed for members of the Swiss Armed Forces.",
              linkTitle: "Learn more...",
              link: "https://www.lukmanascic.ch/portfolio/insignia",
              tint: .init(named: "camou") ?? UIColor.init(red: 0.654, green: 0.618, blue: 0.494, alpha: 1.0))
    }
    
    static func setUpButton() -> UIOnboardingButtonConfiguration {
        .init(title: "Continue",
              backgroundColor: .init(named: "camou") ?? UIColor.init(red: 0.654, green: 0.618, blue: 0.494, alpha: 1.0))
    }
}

extension UIOnboardingViewConfiguration {
    static func setUp() -> UIOnboardingViewConfiguration {
        .init(appIcon: UIOnboardingHelper.setUpIcon(),
              firstTitleLine: UIOnboardingHelper.setUpFirstTitleLine(),
              secondTitleLine: UIOnboardingHelper.setUpSecondTitleLine(),
              features: UIOnboardingHelper.setUpFeatures(),
              textViewConfiguration: UIOnboardingHelper.setUpNotice(),
              buttonConfiguration: UIOnboardingHelper.setUpButton())
    }
}
