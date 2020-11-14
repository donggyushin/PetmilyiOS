//
//  Notification.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/14.
//

import Foundation

struct NotificationModel {
    var petIdentifier:String
    var userFcmToken:String?
    var name:String
    var dayPeriod:Int
    var isOn:Bool
    var createdAt:Date
    var updatedAt:Date
    var firstNotified:Date
    
    init(dictionary:[String:Any]) {
        let petIdentifier = dictionary["petIdentifier"] as? String ?? ""
        let userFcmToken = dictionary["userFcmToken"] as? String
        let name = dictionary["name"] as? String ?? ""
        let dayPeriod = dictionary["dayPeriod"] as? Int ?? 0
        let isOn = dictionary["isOn"] as? Bool ?? false
        let createdAtString = dictionary["createdAt"] as? String ?? ""
        let createdAt = Utilities.shared.convertStringDateToDate(stringDate: createdAtString)
        let updatedAtString = dictionary["updatedAt"] as? String ?? ""
        let updatedAt = Utilities.shared.convertStringDateToDate(stringDate: updatedAtString)
        let firstNotifiedString = dictionary["firstNotified"] as? String ?? ""
        let firstNotified = Utilities.shared.convertStringDateToDate(stringDate: firstNotifiedString)
        
        self.petIdentifier = petIdentifier
        self.userFcmToken = userFcmToken
        self.name = name
        self.dayPeriod = dayPeriod
        self.isOn = isOn
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.firstNotified = firstNotified
        
    }
}
