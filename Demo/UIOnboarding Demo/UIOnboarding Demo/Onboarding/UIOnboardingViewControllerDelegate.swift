//
//  UIOnboardingViewControllerDelegate.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

protocol UIOnboardingViewControllerDelegate: AnyObject {
    func didFinishOnboarding(onboardingViewController: UIOnboardingViewController)
}
