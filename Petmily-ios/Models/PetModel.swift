//
//  PetModel.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/07.
//

import Foundation

struct PetPhoto {
    var url:String
    var favorite:Bool
    var _id:String
    
    init(dictionary:[String:Any]) {
        let url = dictionary["url"] as? String ?? ""
        let favorite = dictionary["favorite"] as? Bool ?? false
        let _id = dictionary["_id"] as? String ?? ""
        
        self.url = url
        self.favorite = favorite
        self._id = _id
    }
}

struct PetModel {
    let userIdentifier:String
    var petSort:String?
    let kind:String
    let name:String
    var personality:[String]?
    let photourl:String
    let gender:String
    let birth:String
    var photos:[PetPhoto]
    let _id:String
    
    init(dictionary:[String:AnyObject]) {
        let userIdentifier = dictionary["userIdentifier"] as? String ?? ""
        let petSort = dictionary["petSort"] as? String
        let kind = dictionary["kind"] as? String ?? ""
        let name = dictionary["name"] as? String ?? ""
        let personality = dictionary["personality"] as? [String]
        let photourl = dictionary["photourl"] as? String ?? ""
        let gender = dictionary["gender"] as? String ?? ""
        let birth = dictionary["birth"] as? String ?? ""
        let _id = dictionary["_id"] as? String ?? ""
        
        var photos:[PetPhoto] = []
        let photosDictionary = dictionary["photos"] as? [[String:AnyObject]] ?? []
        for photoDic in photosDictionary {
            let photo = PetPhoto(dictionary: photoDic)
            photos.append(photo)
        }
        
        
        
        
        self.photos = photos
        self._id = _id
        self.userIdentifier = userIdentifier
        self.petSort = petSort
        self.kind = kind
        self.name = name
        self.personality = personality
        self.photourl = photourl
        self.gender = gender
        self.birth = birth
        
    }
}
