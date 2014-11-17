//
//  InfoViewController.swift
//  Cool Beans
//
//  Created by Kyle on 11/15/14.
//  Copyright (c) 2014 Kyle Weiner. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Actions

    @IBAction func openURL(sender: AnyObject) {
        let url = NSURL(string: "http://git.io/Xi6unA")
        UIApplication.sharedApplication().openURL(url!)
    }

    @IBAction func done(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
