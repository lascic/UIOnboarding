//
//  UIOnboardingCollectionCell.swift
//  UIOnboarding
//
//  Created by Vyacheslav on 12.07.2023.
//

import UIKit

private typealias Cell = UIOnboardingCheckBoxCell

final class UIOnboardingCheckBoxCell: UITableViewCell {
    static let reuseIdentifier = "onboardingFeatureCheckBoxCell"

    private var featureGlyphWidth: NSLayoutConstraint!
    private lazy var featureGlyph: UIImageView = {
        let featureGlyph: UIImageView = .init()
        featureGlyph.tintColor = .label
        featureGlyph.contentMode = .scaleAspectFit

        featureGlyphWidth = featureGlyph.heightAnchor.constraint(equalToConstant: traitCollection.horizontalSizeClass == .regular ? 60 : 44)
        featureGlyphWidth.isActive = true
        featureGlyph.widthAnchor.constraint(equalTo: featureGlyph.heightAnchor).isActive = true

        featureGlyph.translatesAutoresizingMaskIntoConstraints = false
        return featureGlyph
    }()

    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        if #available(iOS 15.0, *) {
            label.maximumContentSizeCategory = .accessibilityLarge
        }
        label.adjustsFontForContentSizeCategory = true

        return label
    }()
    private var stackLeading: NSLayoutConstraint!
    private var stackBottom: NSLayoutConstraint!

    private let descriptionLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        if #available(iOS 15.0, *) {
            label.maximumContentSizeCategory = .accessibilityLarge
        }
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private var labelStack: UIStackView!

    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()

        accessoryType = .none
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        titleLabel.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular ? 20 : 17, weight: .semibold))
        descriptionLabel.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular ? 20 : 17, weight: .light))

        stackBottom.constant = traitCollection.horizontalSizeClass == .regular ? -48 : -12
        featureGlyphWidth.constant = traitCollection.horizontalSizeClass == .regular ? 60 : 44
        stackLeading.constant = traitCollection.horizontalSizeClass == .regular ? 32 : 18
        contentView.layoutIfNeeded()
    }
}

// MARK: - Public Methods
extension Cell {
    func set(_ feature: UIOnboardingFeatureCheckBox) {
        featureGlyph.image = feature.icon
        if let iconTint = feature.iconTint {
            featureGlyph.tintColor = iconTint
            tintColor = iconTint
        }

        titleLabel.text = feature.title
        titleLabel.accessibilityLabel = feature.title

        descriptionLabel.text = feature.description
        descriptionLabel.accessibilityLabel = feature.description
    }
}

// MARK: - Private Methods
private extension Cell {
    func configure() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        selectionStyle = .none

        isAccessibilityElement = false
        titleLabel.isAccessibilityElement = true
        titleLabel.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular ? 20 : 17, weight: .semibold))

        descriptionLabel.isAccessibilityElement = true
        descriptionLabel.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular ? 20 : 17, weight: .light))

        labelStack = .init(frame: .zero)
        labelStack.axis = .vertical
        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(descriptionLabel)
        labelStack.setCustomSpacing(0.8, after: titleLabel)
        labelStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(featureGlyph)
        contentView.addSubview(labelStack)

        labelStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        stackLeading = labelStack.leadingAnchor.constraint(equalTo: featureGlyph.trailingAnchor, constant: traitCollection.horizontalSizeClass == .regular ? 32 : 18)
        stackLeading.isActive = true

        stackBottom = labelStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: traitCollection.horizontalSizeClass == .regular ? -48 : -12)
        stackBottom.isActive = true

        featureGlyph.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 4).isActive = true
        featureGlyph.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        featureGlyph.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4).isActive = true

        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
    }
}
