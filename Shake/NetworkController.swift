//
//  NetworkController.swift
//  Shake
//
//  Created by Michael Silver on 2/22/15.
//  Copyright (c) 2015 Michael Silver. All rights reserved.
//

import Foundation

class NetworkController {
    class var sharedInstance: NetworkController {
        struct Static {
            static var instance: NetworkController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = NetworkController()
        }
        
        return Static.instance!
    }
    
    func networkRequest(inputData:NSDictionary){
        var request = NSMutableURLRequest(URL: NSURL(string: "http://10.189.5.152:8083/api")!)
        var session = NSURLSession(configuration: nil, delegate: nil, delegateQueue: nil)
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
}
