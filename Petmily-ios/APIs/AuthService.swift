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
    
    func loginUser(userId:String, password:String, completion:@escaping(Error?, String?, Bool, String?) -> Void) {
        let urlString = "\(Properties.PETMILY_API)/v1/user/login"
        guard let url = URL(string: urlString) else {
            completion(nil, "URL 객체를 생성하던 도중에 에러 발생", false, nil)
            return
        }
        AF.request(url, method: HTTPMethod.post, parameters: ["userId":userId, "password":password], encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, "서버내부 에러 발생", false, nil)
                break
            case .success(let value):
                guard let value = value as? [String:AnyObject] else { return }
                guard let ok = value["ok"] as? Bool else { return }
                if !ok {
                    guard let errorMessage = value["message"] as? String else { return }
                    completion(nil, errorMessage, false, nil)
                }else {
                    guard let token = value["token"] as? String else { return }
                    completion(nil, nil, true, token)
                }
                break
            }
        }
    }
    
    func makeNewAccount(userId:String, password:String, nickname:String, phoneNumber:String, birth:String?, gender:String?, profileImage:UIImage?, completion:@escaping(Error?, String?, Bool) -> Void) {
        let urlString = "\(Properties.PETMILY_API)/v1/user"
        guard let url = URL(string: urlString) else {
            completion(nil, "URL 생성 실패", false)
            return
        }
        
        // ProfileImage가 있을 경우
        if profileImage != nil {
            
            FileService.shared.uploadImageFile(image: profileImage!) { (error, errorMessage, profileImageUrl) in
                if let errorMessage = errorMessage {
                    completion(nil, errorMessage, false)
                    return
                }
                
                guard let proflieImageUrl = profileImageUrl else { return }
                AF.request(url, method: HTTPMethod.post, parameters: ["userId":userId, "password":password, "nickname":nickname, "phoneNumber":phoneNumber, "birth":birth ?? "", "gender": gender ?? "", "profileImage":proflieImageUrl], encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        completion(error, "서버 내부 에러 발생", false)
                        break
                    case .success(let value):
                        guard let value = value as? [String:Any] else { return }
                        guard let ok = value["ok"] as? Bool else { return }
                        if !ok {
                            guard let errorMessage = value["message"] as? String else { return }
                            completion(nil, errorMessage, false)
                            break
                        }else {
                            completion(nil, nil, true)
                            break
                        }
                    }
                }
                
            }
            
            
            return
        }
        
        
        // ProfileImage가 없을 경우
        AF.request(url, method: HTTPMethod.post, parameters: ["userId":userId, "password":password, "nickname":nickname, "phoneNumber":phoneNumber, "birth":birth ?? "", "gender": gender ?? ""], encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, "서버 내부 에러 발생", false)
                break
            case .success(let value):
                guard let value = value as? [String:Any] else { return }
                guard let ok = value["ok"] as? Bool else { return }
                if !ok {
                    guard let errorMessage = value["message"] as? String else { return }
                    completion(nil, errorMessage, false)
                    break
                }else {
                    completion(nil, nil, true)
                    break
                }
            }
        }
        
    }
    
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
