//
//  InfoViewController.swift
//  Created by Kyle on 11/15/14.
//

import UIKit

class InfoViewController: UIViewController {
    @IBAction func openURL(sender: AnyObject) {
        let url = NSURL(string: "http://git.io/Xi6unA")
        UIApplication.sharedApplication().openURL(url!)
    }

    @IBAction func done(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}