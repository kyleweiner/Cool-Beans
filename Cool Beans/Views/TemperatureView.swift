//
//  TemperatureView.swift
//  Created by Kyle on 11/14/14.
//

import UIKit

class TemperatureView: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    // MARK: - Lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let nib = UINib(nibName: "\(self.dynamicType)", bundle: nil)
        if let view = nib.instantiateWithOwner(self, options: nil).first as? UIView {
            addSubview(view)
        }
    }
}