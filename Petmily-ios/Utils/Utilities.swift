//
//  Utilities.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit



class Utilities {
    static let shared = Utilities()
    
    func regularExpressionCheckFunction(text:String, regularExpress:String) -> Bool {
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: regularExpress, options: NSRegularExpression.Options.caseInsensitive)
        return regex.firstMatch(in: text, options: [NSRegularExpression.MatchingOptions.reportCompletion], range: range) != nil
    }
    
    
    func nonuseableNicknameCheck(nickname:String) -> Bool{
        var result = true
        
        for word in nonUseableWords {
            
            if nickname.contains(word) {
                result = false
                break
                
            }
        }
        
        return result
    }
    
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
