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
    
    func fetchMyPets(completion:@escaping(Error?, String?, Bool, [PetModel]?) -> Void) {
        LocalData.shared.getting(key: "token") { (token) in
            guard let token = token else {
                completion(nil, "로그인 해주세요", false, nil)
                return
            }
            
            let urlString = "\(Properties.PETMILY_API)/v1/pet/mypets"

            guard let url = URL(string: urlString) else {
                
                return completion(nil, "url 객체를 만드는데 실패하였습니다. ", false, nil)
            }
            
            AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization": "Bearer \(token)"], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    return completion(nil, error.localizedDescription, false, nil)
                    
                case .success(let value):
                    
                    guard let value = value as? [String:AnyObject] else { return }
                    guard let ok = value["ok"] as? Bool else { return }
                    if ok {
                        guard let petlistDictionarys = value["petlist"] as? [[String:AnyObject]] else { return }
                        var petlist:[PetModel] = []
                        for petDictionary in petlistDictionarys {
                            let pet = PetModel(dictionary: petDictionary)
                            petlist.append(pet)
                        }
                        return completion(nil, nil, true, petlist)
                    }else {
                        guard let errorMessage = value["message"] as? String else { return }
                        return completion(nil, errorMessage, false, nil)
                    }
                }
            }
            
        }
    }
    
    func postNewPet(petSort:String?, name:String, kind:String, personality:[String]?, photourl:String, gender:String, birth:String, completion:@escaping(Error?, String?, Bool) -> Void)  {
        
        
        
        LocalData.shared.getting(key: "token") { (token) in
            
            guard let token = token else {
                
                return completion(nil, "로그인 해주세요", false)
            }
            let urlString = "\(Properties.PETMILY_API)/v1/pet"

            guard let url = URL(string: urlString) else {
                
                return completion(nil, "url 객체를 만드는데 실패하였습니다. ", false)
            }
            
            
            
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
                    
                    return completion(error, error.localizedDescription, false)
                case .success(let value):
                    
                    guard let value = value as? [String:AnyObject] else {
                        return completion(nil, "알 수 없는 에러가 발생하였습니다.", false)
                        
                    }
                    
                    guard let ok = value["ok"] as? Bool else {
                        return completion(nil, "알 수 없는 에러가 발생하였습니다.", false)
                    }
                    
                    if ok {
                        return completion(nil, nil, ok)
                    }else {
                        guard let message = value["message"] as? String else {
                            return completion(nil, "알 수 없는 에러가 발생하였습니다.", false)
                        }
                        return completion(nil, message, ok)
                    }
                    
                    
                }
            }
        }
        
    }
}