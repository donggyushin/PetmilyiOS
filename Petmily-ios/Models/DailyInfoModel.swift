//
//  DailyInfoModel.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/28.
//

import Foundation


struct DailyInfoModel {
    let title:String
    let text:String
    let icon:Bool
    let url:String?
    let width:Int?
    let height:Int?
    
    init(dictionary:[String:Any]) {
        let title = dictionary["title"] as? String ?? ""
        let text = dictionary["text"] as? String ?? ""
        let icon = dictionary["icon"] as? Bool ?? false
        let url = dictionary["url"] as? String
        let width = dictionary["width"] as? Int
        let height = dictionary["height"] as? Int
        
        self.title = title
        self.text = text
        self.icon = icon
        self.url = url
        self.width = width
        self.height = height
    }
}
