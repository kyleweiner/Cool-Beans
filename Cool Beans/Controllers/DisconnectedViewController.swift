//
//  DisconnectedViewController.swift
//  Created by Kyle on 11/14/14.
//

import UIKit

class DisconnectedViewController: UIViewController {
    let connectedViewControllerSegueIdentifier = "ViewConnection"

    private var manager: PTDBeanManager!

    private var connectedBean: PTDBean? {
        didSet {
            connectedBean == nil ? beanManagerDidUpdateState(manager) : performSegueWithIdentifier(connectedViewControllerSegueIdentifier, sender: self)
        }
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        manager = PTDBeanManager(delegate: self)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == connectedViewControllerSegueIdentifier {
            let vc = segue.destinationViewController as! ConnectedViewController
            vc.connectedBean = connectedBean
            vc.connectedBean?.delegate = vc
        }
    }
}

// MARK: - PTDBeanManagerDelegate

extension DisconnectedViewController: PTDBeanManagerDelegate {
    func beanManagerDidUpdateState(beanManager: PTDBeanManager!) {
        switch beanManager.state {
        case .Unsupported:
            UIAlertView(title: "Error", message: "This device is unsupported.", delegate: self, cancelButtonTitle: "OK").show()
        case .PoweredOff:
            UIAlertView(title: "Error", message: "Please turn on Bluetooth.", delegate: self, cancelButtonTitle: "OK").show()
        case .PoweredOn:
            beanManager.startScanningForBeans_error(nil)
        case .Unknown, .Resetting, .Unauthorized:
            break
        }
    }

    func beanManager(beanManager: PTDBeanManager!, didDiscoverBean bean: PTDBean!, error: NSError!) {
        if connectedBean == nil {
            if bean.state == .Discovered {
                manager.connectToBean(bean, error: nil)
            }
        }

        #if DEBUG
            print("DISCOVERED BEAN \nName: \(bean.name), UUID: \(bean.identifier) RSSI: \(bean.RSSI)")
        #endif
    }

    func BeanManager(beanManager: PTDBeanManager!, didConnectToBean bean: PTDBean!, error: NSError!) {
        if connectedBean == nil {
            connectedBean = bean
        }

        #if DEBUG
            print("CONNECTED BEAN \nName: \(bean.name), UUID: \(bean.identifier) RSSI: \(bean.RSSI)")
        #endif
    }

    func beanManager(beanManager: PTDBeanManager!, didDisconnectBean bean: PTDBean!, error: NSError!) {
        // Dismiss any modal view controllers.
        presentedViewController?.dismissViewControllerAnimated(true, completion: {
            self.dismissViewControllerAnimated(true, completion: nil)
        })

        connectedBean = nil

        #if DEBUG
            print("DISCONNECTED BEAN \nName: \(bean.name), UUID: \(bean.identifier) RSSI: \(bean.RSSI)")
        #endif
    }
}