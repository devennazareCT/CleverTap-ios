//
//  ViewController.swift
//  Clevertap-ios
//
//  Created by Deven Nazare on 23/07/22.
//

import UIKit
import CleverTapSDK
class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var identity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("On View Controller");
        CleverTap.sharedInstance()?.recordEvent("ReactnativepushImage");
        // Do any additional setup after loading the view.
    }


    @IBAction func loginbtn(_ sender: Any) {
        let profile: Dictionary<String, AnyObject> = [
            "Name": "Kunal Jadhav" as AnyObject,
            "Email": email.text as AnyObject,
            "Plan type": "Gold" as AnyObject,
            "Favorite Food": "Pizza" as AnyObject,
            "Identity": identity.text as AnyObject,                   // String or number
        ]

        CleverTap.sharedInstance()?.onUserLogin(profile)
        CleverTap.sharedInstance()?.profileRemoveValue(forKey:"Email")
        
        print("Phone removed")
    }
}

