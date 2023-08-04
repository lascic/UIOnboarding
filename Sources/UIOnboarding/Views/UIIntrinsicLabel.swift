//
//  UIIntrinsicLabel.swift
//  UIOnboarding
//
//  Created by Lukman Aščić on 07.08.23.
//

import UIKit

class UIIntrinsicLabel: UILabel {
    private let gutter: CGFloat = 4

    override func draw(_ rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: gutter, dy: 0))
    }
    
    override var alignmentRectInsets: UIEdgeInsets {
        .init(top: 0, left: gutter, bottom: 0, right: gutter)
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += gutter * 2
        return size
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let fixedSize: CGSize = .init(width: size.width - 2 * gutter, height: size.height)
        let sizeWithoutGutter: CGSize = super.sizeThatFits(fixedSize)
        return .init(width: sizeWithoutGutter.width + 2 * gutter, height: sizeWithoutGutter.height)
    }
}
