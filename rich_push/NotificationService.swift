//
//  NotificationService.swift
//  rich_push
//
//  Created by Deven Nazare on 13/12/22.
//
import CTNotificationService
import CleverTapSDK
class NotificationService: CTNotificationServiceExtension {
  var contentHandler: ((UNNotificationContent) -> Void)?
  var bestAttemptContent: UNMutableNotificationContent?
  override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
    super.didReceive(request, withContentHandler: contentHandler)
  }
}
