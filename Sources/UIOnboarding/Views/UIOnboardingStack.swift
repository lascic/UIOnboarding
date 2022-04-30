//
//  UIOnboardingStack.swift
//  UIOnboarding Example
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

final class UIOnboardingStack: UIStackView {
    private var spacerView: UIView!
    private var onboardingIcon: OnboardingIcon!
    private(set) var onboardingTitleLabel: UIOnboardingTitle!
    private let screen: UIScreen

    private(set) lazy var featuresList: UIIntrinsicTableView = {
        let featuresTableView: UIIntrinsicTableView = .init(frame: .zero, style: .plain)
        
        featuresTableView.register(UIOnboardingCell.self, forCellReuseIdentifier: UIOnboardingCell.reuseIdentifier)
                
        featuresTableView.rowHeight = UITableView.automaticDimension
        featuresTableView.estimatedRowHeight = 44
        
        featuresTableView.delegate = self
        featuresTableView.dataSource = self
        
        featuresTableView.widthAnchor.constraint(equalToConstant: screen.bounds.width - (UIScreenType.setUpPadding() * 2)).isActive = true

        featuresTableView.isScrollEnabled = false
        featuresTableView.separatorStyle = .none
        featuresTableView.backgroundColor = .clear
        featuresTableView.alpha = 0
        
        return featuresTableView
    }()
    
    private let configuration: UIOnboardingViewConfiguration

    init(withConfiguration configuration: UIOnboardingViewConfiguration, screen: UIScreen = .main) {
        self.configuration = configuration
        self.screen = screen
        
        onboardingTitleLabel = .init(withConfiguration: configuration)
        onboardingIcon = .init(withConfiguration: configuration)
        
        super.init(frame: .zero)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .vertical
        distribution = .fill
        alignment = .leading
        
        alpha = 0
        transform = UIAccessibility.isReduceMotionEnabled ? .identity : .init(scaleX: 0.75, y: 0.75)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        spacerView = .init(frame: .zero)
        addArrangedSubview(spacerView)
        setCustomSpacing(screen.bounds.height * (UIScreenType.setUpTopStackMultiplier()), after: spacerView)
                
        addArrangedSubview(onboardingIcon)
        setCustomSpacing(26, after: onboardingIcon)
        
        addArrangedSubview(onboardingTitleLabel)
        setCustomSpacing(traitCollection.horizontalSizeClass == .regular ? 40 : UIScreenType.setUpTitleSpacing(), after: onboardingTitleLabel)
        
        addArrangedSubview(featuresList)
    }
    
    func animate(completion: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.834) {
            UIView.animate(withDuration: 0.666, delay: 0.0, options: .curveEaseInOut, animations: {
                self.onboardingIcon.isHidden = true
                self.onboardingIcon.alpha = 0
                self.spacerView.isHidden = true
                self.spacerView.alpha = 0
                self.layoutIfNeeded()
            }, completion: { (_) in
                self.onboardingIcon.isHidden = true
                self.spacerView.isHidden = true
                self.featuresList.alpha = 1
                self.featuresList.reloadData()
                UIView.animate(withDuration: 0.666) {
                    if let completion = completion {
                        completion()
                    }
                }
            })
        }
    }
}

extension UIOnboardingStack: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configuration.features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = featuresList.dequeueReusableCell(withIdentifier: UIOnboardingCell.reuseIdentifier, for: indexPath) as! UIOnboardingCell
        cell.set(configuration.features[indexPath.row])
        return cell
    }
}

extension UIOnboardingStack: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = UIAccessibility.isReduceMotionEnabled ?
        UIOnboardingAnimation.fadeIn(duration: 0.466, delayFactor: 0.13) :
        UIOnboardingAnimation.slideIn(rowHeight: cell.frame.height, duration: 0.466, delayFactor: 0.13)
        let animator: UIOnboardingAnimator = .init(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
}
