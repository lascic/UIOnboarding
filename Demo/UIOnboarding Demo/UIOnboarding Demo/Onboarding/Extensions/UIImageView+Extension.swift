//
//  UIImageView+Extension.swift
//  UIOnboarding Demo
//
//  Created by Vyacheslav on 13.07.2023.
//

import UIKit

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
