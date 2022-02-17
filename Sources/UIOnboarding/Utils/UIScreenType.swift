//
//  UIScreenType.swift
//  UIOnboarding Example
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

struct UIScreenType {
    static let isiPhoneSE = UIDevice.current.userInterfaceIdiom == .phone &&
                            UIScreen.main.nativeBounds.height == 1136
    
    static let isiPhone6s = UIDevice.current.userInterfaceIdiom == .phone &&
                            UIScreen.main.nativeBounds.height == 1334
    
    static let isiPhone6sPlus = UIDevice.current.userInterfaceIdiom == .phone &&
                                UIScreen.main.nativeBounds.height == 2208
    
    static let isiPhone12Mini = UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2340
    
    static func setUpTopStackMultiplier() -> CGFloat {
        if UIScreenType.isiPhoneSE || UIScreenType.isiPhone6s || UIScreenType.isiPhone6sPlus || UIScreenType.isiPhone12Mini {
            return 0.15
        } else {
            return 0.12
        }
    }
    
    static func setUpTopSpacing() -> CGFloat {
        if UIScreenType.isiPhoneSE || UIScreenType.isiPhone6s || UIScreenType.isiPhone6sPlus {
            return 70
        } else {
            return 120
        }
    }
    
    static func setUpTitleSpacing() -> CGFloat {
        if UIScreenType.isiPhoneSE || UIScreenType.isiPhone6s || UIScreenType.isiPhone12Mini {
            return 20
        } else {
            return 40
        }
    }
        
    static func setUpPadding() -> CGFloat {
        if UIScreenType.isiPhoneSE {
            return 30
        } else if UIScreenType.isiPhone6s || UIScreenType.isiPhone12Mini {
            return 50
        } else {
            return 60
        }
    }
    
    static func setUpButtonPadding() -> CGFloat {
        if UIScreenType.isiPhoneSE {
            return 20
        } else if UIScreenType.isiPhone6s || UIScreenType.isiPhone12Mini {
            return 40
        } else {
            return 60
        }
    }
}
