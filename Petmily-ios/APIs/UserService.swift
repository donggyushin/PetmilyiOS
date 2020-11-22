//
//  UserService.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/20.
//

import Foundation
import Alamofire

class UserService {
    static let shared = UserService()
    let urlString = "\(Properties.PETMILY_API)/v1/user"
    
    func setUserFcmToken(fcm:String, completion:@escaping(Error?, String?, Bool) -> Void) {
        LocalData.shared.getting(key: "token") { (token) in
            guard let token = token else {
                return completion(nil, "로그인을 다시 해주세요", false)
            }
            
            guard let url = URL(string: "\(self.urlString)/fcm") else {
                return completion(nil, "url 객체를 만드는데 실패하였습니다.", false)
            }
            
            AF.request(url, method: HTTPMethod.put, parameters: ["fcmToken": fcm], encoding: JSONEncoding.default, headers: ["authorization": "Bearer \(token)"], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    return completion(error, nil, false)
                    
                case .success(let value):
                    guard let value = value as? [String:Any] else { return }
                    guard let ok = value["ok"] as? Bool else { return }
                    if ok {
                        return completion(nil, nil, true)
                    }else {
                        guard let errorMessage = value["message"] as? String else { return }
                        return completion(nil, errorMessage, false)
                    }
                    
                }
            }
            
            
        }
    }
}

