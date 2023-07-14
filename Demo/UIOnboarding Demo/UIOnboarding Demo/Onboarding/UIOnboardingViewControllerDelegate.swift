//
//  UIOnboardingViewControllerDelegate.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

protocol UIOnboardingViewControllerDelegate: AnyObject {
    func didFinishOnboarding(onboardingViewController: UIOnboardingViewController)
    func didSelectRow(at indexPaths: Set<IndexPath>)
}

extension UIOnboardingViewControllerDelegate {
    func didSelectRow(at indexPaths: Set<IndexPath>) { }
}
