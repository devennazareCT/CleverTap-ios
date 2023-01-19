//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by Deven Nazare on 18/01/23.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import CTNotificationContent

class NotificationViewController:CTNotificationViewController{

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        let action1 = UNNotificationAction(identifier: "action_1", title: "Back", options: [])
          let action2 = UNNotificationAction(identifier: "action_2", title: "Next", options: [])
          let action3 = UNNotificationAction(identifier: "action_3", title: "View In App", options: [])
          let category = UNNotificationCategory(identifier: "CTNotification", actions: [action1, action2, action3], intentIdentifiers: [], options: [])
          UNUserNotificationCenter.current().setNotificationCategories([category])
    }

}
