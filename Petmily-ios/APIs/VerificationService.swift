//
//  VerificationService.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import Foundation
import Alamofire

class VerificationService {
    public static let shared = VerificationService()
    
    
    
    func requestVerificationCode(phoneNumber:String, completion:@escaping (VerificationModel?, Error?, String?) -> Void) {
        
        struct SuccessResponse:Codable {
            var ok:Bool
            var verification:VerificationModel
        }
        
        let urlString = "\(Properties.PETMILY_API)/v1/verification"
        guard let url = URL(string: urlString) else {
            completion(nil, nil, "url 생성 실패")
            return
        }
        
        AF.request(url, method: HTTPMethod.post, parameters: ["phoneNumber": phoneNumber], encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let value = value as? [String:AnyObject] else { return }
                guard let ok = value["ok"] as? Bool else { return }
                if ok {
                    guard let dictionary = value["verification"] as? [String:AnyObject] else { return }
                    let verification = VerificationModel(dictionary: dictionary)
                    completion(verification, nil, nil)
                    return
                }else {
                    let errorMessage = value["message"] as? String ?? ""
                    let error = value["error"] as? String ?? ""
                    print("DEBUG: \(error)")
                    completion(nil, nil, errorMessage)
                    return
                }
                
            case .failure(let error):
                print("DEBUG: \(error)")
                break
            }
        }
    }
}
