//
//  HomeView.swift
//  Clevertap-ios
//
//  Created by Deven Nazare on 25/07/22.
//

import UIKit
import CleverTapSDK
class HomeView: UIViewController, CleverTapInboxViewControllerDelegate {

    @IBOutlet weak var customtxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "Login");
        CleverTap.sharedInstance()?.profileRemoveValue(forKey:"Email");
        CleverTap.sharedInstance()?.profileRemoveValue(forKey:"Name");
        CleverTap.sharedInstance()?.recordEvent("ReactnativepushImage");
        CleverTap.sharedInstance()?.recordEvent("AppInbox");

      CleverTap.sharedInstance()?.initializeInbox(callback: ({ (success) in
              let messageCount = CleverTap.sharedInstance()?.getInboxMessageCount()
              let unreadCount = CleverTap.sharedInstance()?.getInboxMessageUnreadCount()
              print("Inbox Message:\(String(describing: messageCount))/\(String(describing: unreadCount)) unread")
       }))
        
        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func pushevent(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("hola")
        CleverTap.sharedInstance()?.recordEvent("PushNotification")

    }
    
    
    @IBAction func eventprops(_ sender: Any) {
        let props = [
            "Deal Slug": "CleverTap Orange Hoodie",
            "Category": "Household",
            "Price": 5900.99,
            "Date": NSDate(),
            "sku":137,
            "Identity":137
        ] as [String : Any]

        CleverTap.sharedInstance()?.recordEvent("Deal Started", withProps: props)

    }
    
    @IBAction func chargedevent(_ sender: Any) {
        let chargeDetails = [
                   "Amount": 300,
                   "Payment mode": "Credit Card",
                   "Charged ID": 24052013
                   ] as [String : Any]
               
               let item1 = [
                   "Category": "books",
                   "Book name": "The Millionaire next door",
                   "Quantity": 1
                   ] as [String : Any]
               
               let item2 = [
                   "Category": "books",
                   "Book name": "Achieving inner zen",
                   "Quantity": 1
                   ] as [String : Any]
               
               let item3 = [
                   "Category": "books",
                   "Book name": "Chuck it, let's do it",
                   "Quantity": 5
                   ] as [String : Any]
               
               CleverTap.sharedInstance()?.recordChargedEvent(withDetails: chargeDetails, andItems: [item1, item2, item3])
    }
    
    @IBAction func appinbox(_ sender: Any) {
        let style = CleverTapInboxStyleConfig.init()
               style.title = "App Inbox"
               style.navigationTintColor = .black
               
               if let inboxController = CleverTap.sharedInstance()?.newInboxViewController(with: style, andDelegate: self) {
                   let navigationController = UINavigationController.init(rootViewController: inboxController)
                   self.present(navigationController, animated: true, completion: nil)
               }
    }
    
    @IBAction func customevent(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent(customtxt.text!)
    }
    
}
