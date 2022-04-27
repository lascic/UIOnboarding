//
//  UIOnboardingViewController.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

final class UIOnboardingViewController: UIViewController {
    private var onboardingScrollView: UIScrollView!
    private var onboardingStackView: UIOnboardingStack!
    private var onboardingStackViewWidth: NSLayoutConstraint!
    
    private var topOverlayView: UIOnboardingOverlay!
    private var bottomOverlayView: UIOnboardingOverlay!
    private var continueButton: UIOnboardingButton!
    private var continueButtonWidth: NSLayoutConstraint!
    private var onboardingTextView: UIOnboardingTextView!

    private lazy var statusBarHeight: CGFloat = getStatusBarHeight()

    private var enoughSpaceToShowFullList: Bool {
        let onboardingStackHeight: CGFloat = onboardingStackView.frame.height
        let availableSpace: CGFloat = (view.frame.height -
                                       bottomOverlayView.frame.height -
//                                       (device.userInterfaceIdiom == .pad ? (device.hasNotch ? 120 : 70) : getStatusBarHeight()) -
                                       onboardingScrollView.contentInset.top)
        return onboardingStackHeight > availableSpace
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    private let configuration: UIOnboardingViewConfiguration
    private let device: UIDevice
    weak var delegate: UIOnboardingViewControllerDelegate?
    
    init(withConfiguration configuration: UIOnboardingViewConfiguration, device: UIDevice = .current) {
        self.configuration = configuration
        self.device = device
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("UIOnboardingViewController: deinit {}")
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureScrollView()
        setUpTopOverlay()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startOnboardingAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateUI()
    }
    
    /// Because the regular mode on plus sized iPhones only happens in landscape – and landscape is not supported – we don't have to check that. Only regular size classes of iPad are affected.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        print("TRAITCOLLECTION UPDATED: ")
        dump(traitCollection)
        //mer müend au vertical size class luege
    }
}

extension UIOnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var viewOverlapsWithOverlay: Bool {
            return scrollView.contentOffset.y >= -(self.statusBarHeight / 1.5)
        }
        UIView.animate(withDuration: 0.21) {
            self.topOverlayView.alpha = viewOverlapsWithOverlay ? 1 : 0
        }
    }
}

extension UIOnboardingViewController {
    func configureScrollView() {
        onboardingScrollView = .init(frame: .zero)
        onboardingScrollView.delegate = self
        
        onboardingScrollView.isScrollEnabled = false
        onboardingScrollView.showsHorizontalScrollIndicator = false
        onboardingScrollView.backgroundColor = .systemGroupedBackground
        onboardingScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(onboardingScrollView)
        pin(onboardingScrollView, toEdgesOf: view)
        
        setUpOnboardingStackView()
        setUpBottomOverlay()
    }
    
    func setUpOnboardingStackView() {
        onboardingStackView = .init(withConfiguration: configuration)
        onboardingScrollView.addSubview(onboardingStackView)
        
        onboardingStackView.topAnchor.constraint(equalTo: onboardingScrollView.topAnchor).isActive = true
        onboardingStackView.bottomAnchor.constraint(equalTo: onboardingScrollView.bottomAnchor).isActive = true
//        onboardingStackView.leadingAnchor.constraint(equalTo: onboardingScrollView.leadingAnchor, constant: UIScreenType.setUpPadding()).isActive = true
//        onboardingStackView.trailingAnchor.constraint(equalTo: onboardingScrollView.trailingAnchor, constant: UIScreenType.setUpPadding()).isActive = true
        onboardingStackViewWidth = onboardingStackView.widthAnchor.constraint(equalToConstant: view.frame.width - UIScreenType.setUpPadding() * 2)
        onboardingStackViewWidth.isActive = true
        onboardingStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func setUpTopOverlay() {
        topOverlayView = .init(frame: .zero)
        view.addSubview(topOverlayView)
        
        topOverlayView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topOverlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topOverlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topOverlayView.heightAnchor.constraint(equalToConstant: getStatusBarHeight()).isActive = true
    }

    func setUpBottomOverlay() {
        bottomOverlayView = .init(frame: .zero)
        view.addSubview(bottomOverlayView)
        
        bottomOverlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomOverlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomOverlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        setUpOnboardingButton()
        setUpOnboardingTextView()
    }

    func setUpOnboardingButton() {
        continueButton = .init(withConfiguration: configuration.buttonConfiguration)
        continueButton.delegate = self
        bottomOverlayView.addSubview(continueButton)
        
        continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
//        continueButton.leadingAnchor.constraint(equalTo: bottomOverlayView.leadingAnchor, constant: UIScreenType.setUpButtonPadding()).isActive = true
//        continueButton.trailingAnchor.constraint(equalTo: bottomOverlayView.trailingAnchor, constant: -UIScreenType.setUpButtonPadding()).isActive = true
        continueButtonWidth = continueButton.widthAnchor.constraint(equalToConstant: (view.frame.width - UIScreenType.setUpPadding() * 2) * 0.5)
        continueButtonWidth.isActive = true
        continueButton.centerXAnchor.constraint(equalTo: onboardingStackView.centerXAnchor).isActive = true
        continueButton.heightAnchor.constraint(greaterThanOrEqualToConstant: UIScreenType.isiPhoneSE ? 46 : 52).isActive = true
    }
    
    func setUpOnboardingTextView() {
        onboardingTextView = .init(withConfiguration: configuration.textViewConfiguration)
        bottomOverlayView.addSubview(onboardingTextView)
        
        onboardingTextView.bottomAnchor.constraint(equalTo: continueButton.topAnchor).isActive = true
        onboardingTextView.leadingAnchor.constraint(equalTo: continueButton.leadingAnchor).isActive = true
        onboardingTextView.trailingAnchor.constraint(equalTo: continueButton.trailingAnchor).isActive = true
        onboardingTextView.topAnchor.constraint(equalTo: bottomOverlayView.topAnchor, constant: 16).isActive = true
    }
    
    func startOnboardingAnimation() {
        UIView.animate(withDuration: UIAccessibility.isReduceMotionEnabled ? 0.8 : 1.533, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.6, options: .curveEaseInOut) {
            self.onboardingStackView.transform = .identity
            self.onboardingStackView.alpha = 1
        } completion: { (_) in
            self.onboardingStackView.animate {
                self.bottomOverlayView.alpha = 1
                self.onboardingScrollView.isScrollEnabled = true
            }
        }
    }
    
    func updateUI() {
        onboardingScrollView.contentInset = .init(top: UIScreenType.setUpTopSpacing(),
                                                  left: 0,
                                                  bottom: bottomOverlayView.frame.height + 16,
                                                  right: 0)
        onboardingScrollView.scrollIndicatorInsets = .init(top: 0,
                                                           left: 0,
                                                           bottom: bottomOverlayView.frame.height,
                                                           right: 0)
        bottomOverlayView.subviews.first?.alpha = enoughSpaceToShowFullList ? 1 : 0
        
        onboardingScrollView.isScrollEnabled = enoughSpaceToShowFullList
        onboardingScrollView.showsVerticalScrollIndicator = enoughSpaceToShowFullList
        
        if traitCollection.horizontalSizeClass == .regular && device.userInterfaceIdiom == .pad {
            onboardingStackViewWidth.constant = view.frame.width * 0.6
            continueButtonWidth.constant = (view.frame.width - UIScreenType.setUpPadding() * 2) * 0.5
            print("iPad version regular on both landscape portrait")
        } else {
            print("iPhone version compact")
        }

        continueButton.layoutIfNeeded()
        view.layoutIfNeeded()

        continueButton.sizeToFit()
    }
}

extension UIOnboardingViewController: UIOnboardingButtonDelegate {
    func didPressContinueButton() {
        delegate?.didFinishOnboarding(onboardingViewController: self)
    }
}
