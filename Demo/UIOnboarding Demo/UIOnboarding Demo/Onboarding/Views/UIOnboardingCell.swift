//
//  UIOnboardingCell.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

final class UIOnboardingCell: UITableViewCell {
    static let reuseIdentifier = "onboardingFeatureCell"

    lazy var featureGlyph: UIImageView = {
        let featureGlyph: UIImageView = .init()
        featureGlyph.tintColor = .label
        featureGlyph.contentMode = .scaleAspectFit
        
        featureGlyph.heightAnchor.constraint(equalToConstant: traitCollection.horizontalSizeClass == .regular && UIDevice.current.userInterfaceIdiom == .pad ? 78 : 44).isActive = true
        featureGlyph.widthAnchor.constraint(equalTo: featureGlyph.heightAnchor).isActive = true
        
        featureGlyph.translatesAutoresizingMaskIntoConstraints = false
        return featureGlyph
    }()
    
    let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        if #available(iOS 15.0, *) {
            label.maximumContentSizeCategory = .accessibilityLarge
        }
        label.adjustsFontForContentSizeCategory = true

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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

        contentView.addSubview(featureGlyph)
        contentView.addSubview(titleLabel)
        
        featureGlyph.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: traitCollection.horizontalSizeClass == .regular && UIDevice.current.userInterfaceIdiom == .pad ? -74 : -12).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: featureGlyph.trailingAnchor, constant: traitCollection.horizontalSizeClass == .regular && UIDevice.current.userInterfaceIdiom == .pad ? 28 : 18).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        featureGlyph.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 4).isActive = true
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
    }
    
    func set(_ feature: UIOnboardingFeature) {
        featureGlyph.image = feature.icon
        featureGlyph.tintColor = feature.iconTint
        
        let paraph: NSMutableParagraphStyle = .init()
        paraph.lineSpacing = 0.8
        let text: NSMutableAttributedString = .init(string: "\(feature.title)\n",
                                                    attributes: [.font: UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular && UIDevice.current.userInterfaceIdiom == .pad ? 27 : 17, weight: .semibold)), .paragraphStyle: paraph])
        text.append(.init(string: feature.description,
                          attributes: [.font: UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: traitCollection.horizontalSizeClass == .regular && UIDevice.current.userInterfaceIdiom == .pad ? 25 : 15, weight: .light)), .foregroundColor: UIColor.label]))
        
        titleLabel.attributedText = text
        titleLabel.accessibilityLabel = "\(feature.title). \(feature.description)"
    }
}
