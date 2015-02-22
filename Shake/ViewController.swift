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
        networkRequest(data)
    }
    
    func networkRequest(inputData:NSDictionary){
        var request = NSMutableURLRequest(URL: NSURL(string: "http://10.189.5.152:8083/")!)
        var session = NSURLSession(configuration: nil, delegate: self, delegateQueue: nil)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        var error: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(inputData, options: nil, error: &error)
        var task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            println("response received")
            if(error != nil){
                println(error)
            }
            else{
                var responseVar:NSHTTPURLResponse = response as NSHTTPURLResponse
                println(responseVar.statusCode)
                /*
                var outputJson: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil)
                
                println(outputJson)
                */
            }
        })
        
        task.resume()
    }

    @IBAction func selectContactPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("show-contacts", sender: self)
    }
}

