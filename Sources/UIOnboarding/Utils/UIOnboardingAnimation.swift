//
//  UIOnboardingAnimation.swift
//  UIOnboarding
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

struct UIOnboardingAnimation {
    static func slideIn(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> ((UITableViewCell, IndexPath, UITableView) -> Void) {
        return { (cell, indexPath, _) in
            cell.transform = .init(translationX: 0, y: rowHeight / 2)
            cell.alpha = 0
            
            UIView.animate(withDuration: duration, delay: delayFactor * .init(indexPath.row), options: [.curveEaseInOut], animations: {
                cell.transform = .init(translationX: 0, y: 0)
                cell.alpha = 1
            })
        }
    }
    
    static func fadeIn(duration: TimeInterval, delayFactor: Double) -> ((UITableViewCell, IndexPath, UITableView) -> Void) {
        return { (cell, indexPath, _) in
            cell.alpha = 0
            
            UIView.animate(withDuration: duration, delay: delayFactor * .init(indexPath.row), animations: {
                cell.alpha = 1
            })
        }
    }
}
