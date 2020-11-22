//
//  Notification.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/14.
//

import Foundation

struct MiteNotificationKindEnum {
    static let shared = MiteNotificationKindEnum()
    let eat = "eat"
    let cover = "cover"
}

struct NotificationNameEnum {
    static let shared = NotificationNameEnum()
    let birth = "birth"
    let miteEating = "mite-eating"
    let helminthic = "helminthic"
    let miteCover = "mite-cover"
    let DirofilariaImmitis = "Dirofilaria-immitis"
}

struct NotificationModel {
    var petIdentifier:String
    var userFcmToken:String?
    var name:String
    var dayPeriod:Int
    var isOn:Bool
    var createdAt:Date
    var updatedAt:Date
    var firstNotified:Date
    var type:String?
    
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
        let type = dictionary["type"] as? String
        
        self.petIdentifier = petIdentifier
        self.userFcmToken = userFcmToken
        self.name = name
        self.dayPeriod = dayPeriod
        self.isOn = isOn
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.firstNotified = firstNotified
        self.type = type
        
    }
}
