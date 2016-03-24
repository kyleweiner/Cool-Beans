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