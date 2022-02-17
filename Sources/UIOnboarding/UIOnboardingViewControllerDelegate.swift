//
//  UIOnboardingViewControllerDelegate.swift
//  UIOnboarding Example
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

public protocol UIOnboardingViewControllerDelegate: AnyObject {
    func didFinishOnboarding(onboardingViewController: UIOnboardingViewController)
}
