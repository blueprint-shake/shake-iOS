//
//  ShowContactsTableViewController.swift
//  Shake
//
//  Created by Michael Silver on 2/22/15.
//  Copyright (c) 2015 Michael Silver. All rights reserved.
//

import UIKit
import AddressBook

class ShowContactsTableViewController: UITableViewController {
    
    var allContacts : NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addressBook : ABAddressBookRef? = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
        
        ABAddressBookRequestAccessWithCompletion(addressBook, { (granted : Bool, error: CFError!) -> Void in
            if granted == true
            {
            //do stuff here
            }
        })

        allContacts = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
        
        for contactRef:ABRecordRef in allContacts
        {
            // first name
            if let firstName = ABRecordCopyValue(contactRef, kABPersonFirstNameProperty).takeUnretainedValue() as? NSString { //Use firstName 
            
            }
        }
            // Similarly all properties with same kind of ABPropertyID can be fetched. i.e kABPersonLastNameProperty, kABPersonMiddleNameProperty etc }
        
        ///////////////////
            
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    // MARK: - Table view data source

     override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return allContacts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath) as UITableViewCell

        let contactRef: ABRecordRef = allContacts[indexPath.row]
        
        let name = ABRecordCopyValue(contactRef, kABPersonFirstNameProperty).takeUnretainedValue() as? NSString
        cell.textLabel!.text = name
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var data:NSMutableDictionary = NSMutableDictionary()
        data["__method__"] = "send.contact"
        
        let contactRef: ABRecordRef = allContacts[indexPath.row]
        
        let name = ABRecordCopyValue(contactRef, kABPersonFirstNameProperty).takeUnretainedValue() as? NSString
        println(name!)
        data["name"] = name
        
        let emailProperties:ABMultiValueRef = ABRecordCopyValue(contactRef, kABPersonEmailProperty).takeRetainedValue()

//        for(var i = 0; i < ABMultiValueGetCount(emailProperties) ; i++){
//            let label:String = ABMultiValueCopyLabelAtIndex(emailProperties, i).takeRetainedValue()
//            let email:String = ABMultiValueCopyValueAtIndex(emailProperties, i).takeRetainedValue() as String
//            
//            println(label + " : " + email)
//            data["email"] = email
//        }
        
        let phoneProperties:ABMultiValueRef = ABRecordCopyValue(contactRef, kABPersonPhoneProperty).takeRetainedValue()

//        for(var i = 0; i < ABMultiValueGetCount(phoneProperties) ; i++){
//            let label:String = ABMultiValueCopyLabelAtIndex(phoneProperties, i).takeRetainedValue()
//            let phone:String = ABMultiValueCopyValueAtIndex(phoneProperties, i).takeRetainedValue() as String
//            
//            println(label + " : " + phone)
//            data["phone"] = phone
//        }
        
        let email:String = ABMultiValueCopyValueAtIndex(emailProperties, 0).takeRetainedValue() as String
        let phone:String = ABMultiValueCopyValueAtIndex(phoneProperties, 0).takeRetainedValue() as String
        
        println("Email: " + email)
        println("Phone: " + phone)
        
        data["email"] = email
        data["phone"] = phone
        
        NetworkController.sharedInstance.networkRequest(data)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
