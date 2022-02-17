//
//  ViewController.swift
//  UIOnboarding Demo SPM
//
//  Created by Lukman Aščić on 17.02.22.
//

import UIKit
import SwiftUI
import UIOnboarding

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presentOnboarding()
    }
            
    @objc private func presentOnboarding() {
        let onboardingController: UIOnboardingViewController = .init(withConfiguration: .setUp())
        onboardingController.delegate = self
        navigationController?.present(onboardingController, animated: false)
    }
}

extension ViewController {
    private func setUp() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.tintColor = .init(named: "camou")
        navigationItem.rightBarButtonItem = .init(image: .init(systemName: "repeat"), style: .plain, target: self, action: #selector(presentOnboarding))
    }
}

extension ViewController: UIOnboardingViewControllerDelegate {
    func didFinishOnboarding(onboardingViewController: UIOnboardingViewController) {
        onboardingViewController.modalTransitionStyle = .crossDissolve
        onboardingViewController.dismiss(animated: true, completion: nil)
    }
}

#if DEBUG
struct ViewControllerContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        return .init(rootViewController: ViewController.init())
    }
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerContainer()
                .preferredColorScheme(.dark)
        }
    }
}
#endif
