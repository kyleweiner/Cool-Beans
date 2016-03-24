//
//  UIFontDescriptor+NumberDescriptor.swift
//  Created by Kyle on 11/14/14.
//

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