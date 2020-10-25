//
//  UserModel.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import Foundation

struct UserModel {
    var profileImage:String?
    var phoneNumber:String
    var updatedAt:String
    var createdAt:String
    var userId:String
    var _id:String
    
    init(dictionary:[String:AnyObject]) {
        let profileImage = dictionary["profileImage"] as? String
        let phoneNumber = dictionary["phoneNumber"] as? String ?? ""
        let updatedAt = dictionary["updatedAt"] as? String ?? ""
        let createdAt = dictionary["createdAt"] as? String ?? ""
        let userId = dictionary["userId"] as? String ?? ""
        let _id = dictionary["_id"] as? String ?? ""
        
        
        self.profileImage = profileImage
        self.phoneNumber = phoneNumber
        self.updatedAt = updatedAt
        self.createdAt = createdAt
        self.userId = userId
        self._id = _id
    }
}
