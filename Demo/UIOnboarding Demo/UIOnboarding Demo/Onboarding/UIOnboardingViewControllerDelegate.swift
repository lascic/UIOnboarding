//
//  UIOnboardingViewControllerDelegate.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

public protocol UIOnboardingViewControllerDelegate: AnyObject {
    func didFinishOnboarding(onboardingViewController: UIOnboardingViewController)
    func didSelectRow(at indexPaths: Set<IndexPath>)
}

public extension UIOnboardingViewControllerDelegate {
    func didSelectRow(at indexPaths: Set<IndexPath>) { }
}
