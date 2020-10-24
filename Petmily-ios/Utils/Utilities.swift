//
//  Utilities.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class Utilities {
    static let shared = Utilities()
    
    func jsonToString(json:AnyObject) -> String? {
        do {
                let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
                let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
                print(convertedString ?? "defaultvalue")
                return convertedString
            } catch let myJSONError {
                print(myJSONError)
                return nil
            }
    }
}
