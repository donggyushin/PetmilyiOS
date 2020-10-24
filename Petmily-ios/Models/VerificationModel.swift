//
//  VerificationModel.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import Foundation

struct VerificationModel:Codable {
    var updatedAt:String
    var verificationCode:String
    var createdAt:String
    var phoneNumber:String
    var _id:String
    
    init(dictionary:[String:AnyObject]) {
        let updatedAt = dictionary["updatedAt"] as? String ?? ""
        let verificationCode = dictionary["verificationCode"] as? String ?? ""
        let createdAt = dictionary["createdAt"] as? String ?? ""
        let phoneNumber = dictionary["phoneNumber"] as? String ?? ""
        let _id = dictionary["_id"] as? String ?? ""
        
        self.updatedAt = updatedAt
        self.createdAt = createdAt
        self.verificationCode = verificationCode
        self._id = _id
        self.phoneNumber = phoneNumber
    }
}
