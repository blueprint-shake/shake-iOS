//
//  ViewController.swift
//  Shake
//
//  Created by Michael Silver on 2/22/15.
//  Copyright (c) 2015 Michael Silver. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLSessionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func testButtonPressed(sender: AnyObject) {
        var data:NSMutableDictionary = NSMutableDictionary()
        data["key"] = "value"
        NetworkController.sharedInstance.networkRequest(data)
    }

    @IBAction func selectContactPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("show-contacts", sender: self)
    }
}

