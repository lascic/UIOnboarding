//
//  UIOnboardingAnimator.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

final class UIOnboardingAnimator {
    private var hasAnimatedAllCells = false
    private let animation: (UITableViewCell, IndexPath, UITableView) -> Void

    init(animation: @escaping (UITableViewCell, IndexPath, UITableView) -> Void) {
        self.animation = animation
    }

    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedAllCells else {
            return
        }

        animation(cell, indexPath, tableView)

        hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }
}
