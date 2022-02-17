//
//  Bundle+Ext.swift
//  UIOnboarding Example
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

extension Bundle {
    public var appIcon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? Dictionary<String, Any>,
           let primary = icons["CFBundlePrimaryIcon"] as? Dictionary<String, Any>,
           let files = primary["CFBundleIconFiles"] as? Array<String>,
           let icon = files.last {
            return .init(named: icon)
        } else {
            return nil
        }
    }
    
    public var displayName: String? {
        return infoDictionary?["CFBundleDisplayName"] as? String
    }
}
