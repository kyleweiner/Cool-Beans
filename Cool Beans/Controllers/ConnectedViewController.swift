//
//  ConnectedViewController.swift
//  Created by Kyle on 11/14/14.
//

import UIKit

struct Temperature {
    enum State {
        case Unknown, Cold, Cool, Warm, Hot
    }

    var degreesCelcius: Float

    var degressFahrenheit: Float {
        return (degreesCelcius * 1.8) + 32.0
    }

    func state() -> State {
        switch Int(degressFahrenheit) {
        case let x where x <= 39: return .Cold
        case 40...65: return .Cool
        case 66...80: return .Warm
        case let x where x >= 81: return .Hot
        default: return .Unknown
        }
    }
}

class ConnectedViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var temperatureView: TemperatureView!

    var connectedBean: PTDBean?

    private var currentTemperature: Temperature = Temperature(degreesCelcius: 0) {
        didSet {
            updateTemperatureView()
            updateBean()
        }
    }

    private let refreshControl = UIRefreshControl()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Update the name label.
        temperatureView.nameLabel.text = connectedBean?.name ?? "Unknown"

        // Add pull-to-refresh control.
        refreshControl.addTarget(self, action: "didPullToRefresh:", forControlEvents: .ValueChanged)
        refreshControl.tintColor = .whiteColor()
        scrollView.addSubview(refreshControl)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        connectedBean?.readTemperature()
    }

    // MARK: - Actions

    func didPullToRefresh(sender: AnyObject) {
        refreshControl.endRefreshing()
        connectedBean?.readTemperature()
    }

    // MARK: - Helper

    func updateTemperatureView() {
        // Update the temperature label.
        temperatureView.temperatureLabel.text = String(format: "%.f℉", currentTemperature.degressFahrenheit)

        // Update the background color.
        var backgroundColor: UIColor

        switch currentTemperature.state() {
        case .Unknown: backgroundColor = .blackColor()
        case .Cold: backgroundColor = .CBColdColor()
        case .Cool: backgroundColor = .CBCoolColor()
        case .Warm: backgroundColor = .CBWarmColor()
        case .Hot: backgroundColor = .CBHotColor()
        }

        UIView.animateWithDuration(0.4, animations: { [unowned self] in
            self.scrollView.backgroundColor = backgroundColor
            self.temperatureView.containerView.backgroundColor = backgroundColor
            })
    }

    func updateBean() {
        connectedBean?.setLedColor(temperatureView.containerView.backgroundColor)
    }
}

// MARK: - PTDBeanDelegate

extension ConnectedViewController: PTDBeanDelegate {
    func bean(bean: PTDBean!, didUpdateTemperature degrees_celsius: NSNumber!) {
        let newTemperature = Temperature(degreesCelcius: degrees_celsius.floatValue)

        if newTemperature.degreesCelcius != currentTemperature.degreesCelcius {
            print("TEMPERATURE UPDATED \nOld: \(currentTemperature.degressFahrenheit)℉ \nNew: \(newTemperature.degressFahrenheit)℉")
            
            currentTemperature = newTemperature
        }
    }
}