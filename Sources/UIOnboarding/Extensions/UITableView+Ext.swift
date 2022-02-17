//
//  UITableView+Ext.swift
//  UIOnboarding Example
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        return lastIndexPath == indexPath
    }
}
