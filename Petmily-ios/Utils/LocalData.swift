//
//  LocalData.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import Foundation

class LocalData {
    static let shared = LocalData()
    private let defaults = UserDefaults.standard
    
    func setting(key:String, value:String) {
        defaults.setValue(value, forKey: key)
    }
    
    func getting(key:String, completion:@escaping (String?) -> Void) {
        if let value = defaults.string(forKey: key) {
            completion(value)
        }else {
            completion(nil)
        }
    }
    
    func remove(key:String) {
        defaults.removeObject(forKey: key)
    }
}
