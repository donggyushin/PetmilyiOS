//
//  PetService.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/07.
//

import Foundation
import Alamofire

class PetService {
    static let shared = PetService()
    
    func postNewPet(petSort:String?, name:String, kind:String, personality:[String]?, photourl:String, gender:String, birth:String, completion:@escaping(Error?, String?, Bool) -> Void)  {
        
        
        
        LocalData.shared.getting(key: "token") { (token) in
            
            guard let token = token else {
                
                return completion(nil, "로그인 해주세요", false)
            }
            let urlString = "\(Properties.PETMILY_API)/v1/pet"

            guard let url = URL(string: urlString) else {
                
                return completion(nil, "url 객체를 만드는데 실패하였습니다. ", false)
            }
            
            print(1)
            
            AF.request(url, method: HTTPMethod.post, parameters: [
                "petSort":petSort ?? "",
                "name":name,
                "kind":kind,
                "personality":personality ?? [],
                "photourl":photourl,
                "gender":gender,
                "birth":birth
            ], encoding: JSONEncoding.default, headers: [
                "authorization": "Bearer \(token)"
            ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    print(error.localizedDescription)
                    return completion(error, error.localizedDescription, false)
                case .success(let value):
                    print(3)
                    guard let value = value as? [String:AnyObject] else {
                        return completion(nil, "알수 없는 에러가 발생하였습니다.", false)
                        
                    }
                    
                    guard let ok = value["ok"] as? Bool else {
                        return completion(nil, "알수 없는 에러가 발생하였습니다.", false)
                    }
                    
                    if ok {
                        return completion(nil, nil, ok)
                    }else {
                        guard let message = value["message"] as? String else {
                            return completion(nil, "알수 없는 에러가 발생하였습니다.", false)
                        }
                        return completion(nil, message, ok)
                    }
                    
                    
                }
            }
        }
        
    }
}
