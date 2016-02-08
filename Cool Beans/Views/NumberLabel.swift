//
//  NumberLabel.swift
//  Created by Kyle on 11/14/14.
//

import UIKit

class NumberLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()

        font = UIFont(descriptor: font.fontDescriptor().numberDescriptor(), size: 0)
    }
}

extension UIFontDescriptor {
    func numberDescriptor() -> UIFontDescriptor {
        return fontDescriptorByAddingAttributes([
            UIFontDescriptorFeatureSettingsAttribute: [
                [
                    UIFontFeatureTypeIdentifierKey: kNumberSpacingType,
                    UIFontFeatureSelectorIdentifierKey: kProportionalNumbersSelector
                ],
                [
                    UIFontFeatureTypeIdentifierKey: kCharacterAlternativesType,
                    UIFontFeatureSelectorIdentifierKey: 1
                ]
            ]
        ])
    }
}