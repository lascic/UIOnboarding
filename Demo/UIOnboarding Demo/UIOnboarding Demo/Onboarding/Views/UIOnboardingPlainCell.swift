//
//  UIOnboardingPlainCell.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

final class UIOnboardingPlainCell: UITableViewCell {
    static let reuseIdentifier = "onboardingFeatureCell"

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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
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
        
        featureGlyph.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        labelStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        
        stackLeading = labelStack.leadingAnchor.constraint(equalTo: featureGlyph.trailingAnchor, constant: traitCollection.horizontalSizeClass == .regular ? 32 : 18)
        stackLeading.isActive = true
        labelStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        stackBottom = labelStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: traitCollection.horizontalSizeClass == .regular ? -48 : -12)
        stackBottom.isActive = true

        featureGlyph.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 4).isActive = true
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
    }
    
    func set(_ feature: UIOnboardingFeature) {
        featureGlyph.image = feature.icon
        featureGlyph.tintColor = feature.iconTint
                
        titleLabel.text = feature.title
        titleLabel.accessibilityLabel = feature.title
        
        descriptionLabel.text = feature.description
        descriptionLabel.accessibilityLabel = feature.description
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
