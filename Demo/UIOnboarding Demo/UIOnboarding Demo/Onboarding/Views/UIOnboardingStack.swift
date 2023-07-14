//
//  UIOnboardingStack.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

// MARK: - UIOnboardingStackDelegate
protocol UIOnboardingStackDelegate: AnyObject {
    func didSelectRow(at indexPaths: Set<IndexPath>)
}

// MARK: - UIOnboardingStack
final class UIOnboardingStack: UIStackView {
    private var spacerView: UIView!
    private var onboardingIcon: OnboardingIcon!
    private(set) var onboardingTitleLabelStack: UIOnboardingTitleLabelStack!
    private let screen: UIScreen

    private var selectedCells: Set<IndexPath> = .init() {
        didSet {
            delegate?.didSelectRow(at: selectedCells)
            featuresList.reloadData()
        }
    }
    private var isCellsAnimated = true

    private(set) lazy var featuresList: UIIntrinsicTableView = {
        let featuresTableView: UIIntrinsicTableView = .init(frame: .zero, style: .plain)
        
        featuresTableView.register(
            UIOnboardingPlainCell.self,
            forCellReuseIdentifier: UIOnboardingPlainCell.reuseIdentifier
        )
        featuresTableView.register(
            UIOnboardingCheckBoxCell.self,
            forCellReuseIdentifier: UIOnboardingCheckBoxCell.reuseIdentifier
        )

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

    // MARK: - Dependencies
    weak var delegate: UIOnboardingStackDelegate?

    // MARK: - Inits
    init(withConfiguration configuration: UIOnboardingViewConfiguration, screen: UIScreen = .main) {
        self.configuration = configuration
        self.screen = screen
        
        onboardingTitleLabelStack = .init(withConfiguration: configuration)
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
        
        addArrangedSubview(onboardingTitleLabelStack)
        setCustomSpacing(traitCollection.horizontalSizeClass == .regular ? 40 : UIScreenType.setUpTitleSpacing(), after: onboardingTitleLabelStack)
        
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

    func withoutAnimation() {
        self.onboardingIcon.isHidden = true
        self.spacerView.isHidden = true
        self.featuresList.alpha = 1
        self.featuresList.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension UIOnboardingStack: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configuration.features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let featureItem = configuration.features[indexPath.row]
        switch featureItem {
            case .plain(let item):
                return buildPlainCell(tableView, item: item, indexPath: indexPath)
            case .checkBox(let item):
                return buildCheckBoxCell(tableView, item: item, indexPath: indexPath)
        }
    }

    func buildPlainCell(_ tableView: UITableView, item: UIOnboardingFeature, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: UIOnboardingPlainCell.reuseIdentifier,
                for: indexPath
            ) as? UIOnboardingPlainCell
        else {
            preconditionFailure()
        }

        cell.set(item)

        return cell
    }

    func buildCheckBoxCell(_ tableView: UITableView, item: UIOnboardingFeatureCheckBox, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: UIOnboardingCheckBoxCell.reuseIdentifier,
                for: indexPath
            ) as? UIOnboardingCheckBoxCell
        else {
            preconditionFailure()
        }

        cell.set(item)
        if selectedCells.contains(indexPath) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension UIOnboardingStack: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !isCellsAnimated {
            return
        }

        let animation = UIAccessibility.isReduceMotionEnabled ?
        UIOnboardingAnimation.fadeIn(duration: 0.466, delayFactor: 0.13) :
        UIOnboardingAnimation.slideIn(rowHeight: cell.frame.height, duration: 0.466, delayFactor: 0.13)
        let animator: UIOnboardingAnimator = .init(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case .plain = configuration.features[indexPath.row] {
            return
        }

        isCellsAnimated = false
        if selectedCells.contains(indexPath) {
            selectedCells.remove(indexPath)
            return
        }

        selectedCells.insert(indexPath)
    }
}
