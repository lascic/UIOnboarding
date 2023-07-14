//
//  UIOnboardingViewController.swift
//  UIOnboarding
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

public class UIOnboardingViewController: UIViewController {
    private var onboardingScrollView: UIScrollView!
    private var onboardingStackView: UIOnboardingStack!
    private var onboardingStackViewWidth: NSLayoutConstraint!

    private var topOverlayView: UIOnboardingOverlay!
    private var bottomOverlayView: UIOnboardingOverlay!

    private var continueButton: UIOnboardingButton!
    private var continueButtonWidth: NSLayoutConstraint!
    private var continueButtonHeight: NSLayoutConstraint!
    private var continueButtonBottom: NSLayoutConstraint!

    private var onboardingTextView: UIOnboardingTextView?
    private var onboardingNoticeIcon: UIImageView!

    private lazy var statusBarHeight: CGFloat = getStatusBarHeight()

    private var enoughSpaceToShowFullList: Bool {
        let onboardingStackHeight: CGFloat = onboardingStackView.frame.height
        let availableSpace: CGFloat = (
            view.frame.height -
            bottomOverlayView.frame.height -
            view.safeAreaInsets.bottom -
            onboardingScrollView.contentInset.top +
            (traitCollection.horizontalSizeClass == .regular ? 48 : 12)
        )
        return onboardingStackHeight > availableSpace
    }
    private var overlayIsHidden: Bool = false
    private var hasScrolledToBottom: Bool = false
    private var needsUIRefresh: Bool = true

    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return device.userInterfaceIdiom == .pad ? .all : .portrait
    }
    private let configuration: UIOnboardingViewConfiguration
    private let device: UIDevice
    private let screen: UIScreen
    public weak var delegate: UIOnboardingViewControllerDelegate?

    public init(
        withConfiguration configuration: UIOnboardingViewConfiguration,
        device: UIDevice = .current,
        screen: UIScreen = .main
    ) {
        self.configuration = configuration
        self.device = device
        self.screen = screen
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("UIOnboardingViewController: deinit {}")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = false
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureScrollView()
        setUpTopOverlay()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startOnboardingAnimation(completion: {
            self.needsUIRefresh = true
        })
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if needsUIRefresh {
            updateUI()
            needsUIRefresh = false
        }
    }

    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        needsUIRefresh = true
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        onboardingStackView.onboardingTitleLabelStack.setFont(font: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular ? 80 : (UIScreenType.isiPhoneSE || UIScreenType.isiPhone6s ? 41 : 44), weight: .heavy))

        continueButtonHeight.constant = UIFontMetrics.default.scaledValue(for: traitCollection.horizontalSizeClass == .regular ? 50 : (UIScreenType.isiPhoneSE ? 48 : 52))
        continueButton.titleLabel?.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular ? 19 : 17, weight: .bold))

        if #available(iOS 15.0, *) {
            onboardingTextView?.font =  UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular ? 15 : 13))
            onboardingTextView?.maximumContentSizeCategory = .accessibilityMedium
        } else {
            onboardingTextView?.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular ? 15 : 13), maximumPointSize: traitCollection.horizontalSizeClass == .regular ? 21 : 19)
        }
        needsUIRefresh = true
        onboardingTextView?.layoutIfNeeded()
        continueButton.layoutIfNeeded()
    }
}

extension UIOnboardingViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y

        var viewOverlapsWithOverlay: Bool {
            return scrollOffset >= -(self.statusBarHeight / 1.5)
        }
        UIView.animate(withDuration: 0.21) {
            self.topOverlayView.alpha = viewOverlapsWithOverlay ? 1 : 0
        }

        hasScrolledToBottom = scrollOffset + scrollViewHeight >= scrollContentSizeHeight + bottomOverlayView.frame.height + view.safeAreaInsets.bottom

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.21, animations: {
                self.bottomOverlayView.blurEffectView.effect = self.hasScrolledToBottom ? nil : UIBlurEffect.init(style: .regular)
                if self.enoughSpaceToShowFullList {
                    self.overlayIsHidden = true
                }
            })
        }
    }
}

private extension UIOnboardingViewController {
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
        onboardingStackView.delegate = self
        onboardingScrollView.addSubview(onboardingStackView)

        onboardingStackView.topAnchor.constraint(equalTo: onboardingScrollView.topAnchor).isActive = true
        onboardingStackView.bottomAnchor.constraint(equalTo: onboardingScrollView.bottomAnchor).isActive = true

        onboardingStackViewWidth = onboardingStackView.widthAnchor.constraint(equalToConstant: traitCollection.horizontalSizeClass == .regular ? 480 : view.frame.width - (UIScreenType.setUpPadding() * 2))
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

        continueButtonBottom = continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: traitCollection.horizontalSizeClass == .regular ? -60 : -40)
        continueButtonBottom.isActive = true

        continueButtonWidth = continueButton.widthAnchor.constraint(equalToConstant: traitCollection.horizontalSizeClass == .regular ? 340 : view.frame.width - (UIScreenType.setUpPadding() * 2))
        continueButtonWidth.isActive = true

        continueButton.centerXAnchor.constraint(equalTo: onboardingStackView.centerXAnchor).isActive = true

        continueButtonHeight = continueButton.heightAnchor.constraint(equalToConstant: UIFontMetrics.default.scaledValue(for: traitCollection.horizontalSizeClass == .regular ? 50 : UIScreenType.isiPhoneSE ? 48 : 52))
        continueButtonHeight.isActive = true
    }

    func setUpOnboardingTextView() {
        guard let textViewConfiguration: UIOnboardingTextViewConfiguration = configuration.textViewConfiguration else {
            continueButton.topAnchor.constraint(equalTo: bottomOverlayView.topAnchor, constant: 32).isActive = true
            return
        }

        if let icon = textViewConfiguration.icon {
            onboardingNoticeIcon = .init(image: icon.withRenderingMode(.alwaysTemplate))
            onboardingNoticeIcon.tintColor = .secondaryLabel
            onboardingNoticeIcon.contentMode = .scaleAspectFit
            onboardingNoticeIcon.translatesAutoresizingMaskIntoConstraints = false

            bottomOverlayView.addSubview(onboardingNoticeIcon)
            onboardingNoticeIcon.topAnchor.constraint(equalTo: bottomOverlayView.topAnchor, constant: 16).isActive = true
            onboardingNoticeIcon.centerXAnchor.constraint(equalTo: bottomOverlayView.centerXAnchor).isActive = true
            onboardingNoticeIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
            onboardingNoticeIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        }

        onboardingTextView = .init(withConfiguration: textViewConfiguration)
        bottomOverlayView.addSubview(onboardingTextView!)

        onboardingTextView!.bottomAnchor.constraint(equalTo: continueButton.topAnchor).isActive = true
        onboardingTextView!.leadingAnchor.constraint(equalTo: continueButton.leadingAnchor).isActive = true
        onboardingTextView!.trailingAnchor.constraint(equalTo: continueButton.trailingAnchor).isActive = true
        onboardingTextView!.topAnchor.constraint(equalTo: onboardingNoticeIcon != nil ? onboardingNoticeIcon.bottomAnchor : bottomOverlayView.topAnchor, constant: onboardingNoticeIcon != nil ? 16 : 32).isActive = true
    }

    func startOnboardingAnimation(completion: (() -> Void)?) {
        UIView.animate(withDuration: UIAccessibility.isReduceMotionEnabled ? 0.8 : 1.533, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.6, options: .curveEaseInOut) {
            self.onboardingStackView.transform = .identity
            self.onboardingStackView.alpha = 1
        } completion: { (_) in
            self.onboardingStackView.animate {
                self.bottomOverlayView.alpha = 1
                self.onboardingScrollView.isScrollEnabled = true
                self.view.isUserInteractionEnabled = true
                if let completion = completion {
                    completion()
                }
            }
        }
    }

    func updateUI() {
        hasScrolledToBottom = false
        onboardingScrollView.contentInset = .init(top: traitCollection.horizontalSizeClass == .regular ? 140 - getStatusBarHeight() : UIScreenType.setUpTopSpacing(),
                                                  left: 0,
                                                  bottom: bottomOverlayView.frame.height + view.safeAreaInsets.bottom,
                                                  right: 0)
        onboardingScrollView.scrollIndicatorInsets = .init(top: 0,
                                                           left: 0,
                                                           bottom: bottomOverlayView.frame.height - view.safeAreaInsets.bottom,
                                                           right: 0)

        let isiPadPro: Bool = max(screen.bounds.size.width, screen.bounds.size.height) > 1024

        onboardingStackViewWidth.constant = traitCollection.horizontalSizeClass == .regular ? 480 : (traitCollection.horizontalSizeClass == .compact && view.frame.width == 320 ? view.frame.width - 60 : (isiPadPro && traitCollection.horizontalSizeClass == .compact && view.frame.width == 639 ? 340 : view.frame.width - (UIScreenType.setUpPadding() * 2)))

        continueButtonBottom.constant = traitCollection.horizontalSizeClass == .regular || (isiPadPro && traitCollection.horizontalSizeClass == .compact && view.frame.width == 639) ? -60 : -40

        continueButtonWidth.constant = traitCollection.horizontalSizeClass == .regular ? 340 : (traitCollection.horizontalSizeClass == .compact && view.frame.width == 320 ? view.frame.width - 60 : (isiPadPro && traitCollection.horizontalSizeClass == .compact && view.frame.width == 639 ? 300 : view.frame.width - (UIScreenType.setUpPadding() * 2)))

        view.layoutIfNeeded()
        bottomOverlayView.subviews.first?.alpha = enoughSpaceToShowFullList ? 1 : 0
        onboardingScrollView.isScrollEnabled = enoughSpaceToShowFullList
        onboardingScrollView.showsVerticalScrollIndicator = enoughSpaceToShowFullList

        continueButton.layoutIfNeeded()
        continueButton.sizeToFit()

        UIView.performWithoutAnimation {
            onboardingStackView.featuresList.beginUpdates()
            onboardingStackView.featuresList.endUpdates()
        }
        onboardingStackView.layoutIfNeeded()
        onboardingStackView.onboardingTitleLabelStack.setLineHeight(lineHeight: 0.9)

        if !overlayIsHidden {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.21) {
                    self.bottomOverlayView.blurEffectView.effect = self.enoughSpaceToShowFullList ? UIBlurEffect.init(style: .regular) : nil
                }
            }
        }
    }
}

// MARK: - UIOnboardingButtonDelegate
extension UIOnboardingViewController: UIOnboardingButtonDelegate {
    func didPressContinueButton() {
        delegate?.didFinishOnboarding(onboardingViewController: self)
    }
}

// MARK: - UIOnboardingStackDelegate
extension UIOnboardingViewController: UIOnboardingStackDelegate {
    func didSelectRow(at indexPaths: Set<IndexPath>) {
        debugPrint("didSelectRowAt: \(indexPaths)")
        delegate?.didSelectRow(at: indexPaths)
    }
}
