//
//  Notification_Name.swift
//  Hopper
//
//  Created by Jaypreet on 08/06/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation

extension Notification.Name{
    
    static let NotificationClickTab =  Notification.Name("NotificationClickTab")

    
    static let NotificationGetPuchNotificationForMyOrder = Notification.Name("NotificationGetPuchNotificationForMyOrder")
    static let NotificationGetPuchNotificationForCheckOut = Notification.Name("NotificationGetPuchNotificationForCheckOut")

    static let NotificationTableVerified = Notification.Name("NotificationTableVerified")
    static let NotificationTableClear = Notification.Name("NotificationTableClear")
    static let NotificationItemDetail = Notification.Name("NotificationItemDetail")
    static let NotifyAfterSavCard = Notification.Name("NotifyAfterSavCard")

    
    static let NotificationRemoveConatiner =  Notification.Name("RemoveConatiner")
    static let NotificationSetDataForScheduleRide =  Notification.Name("SetDataForScheduleRide")
    static let NotificationBringBackInRideQue =  Notification.Name("NotificationBringBackInRideQue")

}
