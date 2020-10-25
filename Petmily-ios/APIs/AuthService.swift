//
//  AuthService.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import Foundation
import Alamofire

class AuthService {
    
    static let shared = AuthService()
    
    func checkThisIdAvailable(id:String, completion:@escaping(Bool, Error?, String?, UserModel?) -> Void) {
        let urlString = "\(Properties.PETMILY_API)/v1/user/userId?userId=\(id)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        guard let url = URL(string: urlString) else { return }
        AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let value = value as? [String:AnyObject] else { return }
                guard let ok = value["ok"] as? Bool else { return }
                if ok {
                    if let dictionary = value["user"] as? [String:AnyObject] {
                        let user = UserModel(dictionary: dictionary)
                        completion(true, nil, nil, user)
                        return
                    }else {
                        completion(true, nil, nil, nil)
                        return
                    }
                    
                }else {
                    guard let message = value["message"] as? String else { return }
                    completion(false, nil, message, nil)
                }
                break
            case .failure(let error):
                completion(false, error, "서버내부적으로 에러가 발생하였습니다", nil)
                break
            }
        }
    }
}
