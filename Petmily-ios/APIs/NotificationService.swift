//
//  NotificationService.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/14.
//

import Foundation
import Alamofire

class NotificationService {
    static let shared = NotificationService()
    let url = "\(Properties.PETMILY_API)/v1/notification/list"
    
    func createOrUpdateNotification(petId:String,notificationName:String, isOn:Bool, firstNotifiedYear:String, firstNotifiedMonth:String, firstNotifiedDate:String, completion:@escaping(Error?, String?, Bool) -> Void) {
        
        LocalData.shared.getting(key: "token") { (token) in
            guard let token = token else {
                return completion(nil, "다시 로그인해주세요", false)
            }
            guard let url = URL(string: "\(Properties.PETMILY_API)/v1/notification/createOrUpdate") else { return }
            AF.request(url, method: HTTPMethod.post, parameters: [
                "petId":petId,
                "notificationName":notificationName,
                "isOn":isOn,
                "firstNotifiedYear":firstNotifiedYear,
                "firstNotifiedMonth":firstNotifiedMonth,
                "firstNotifiedDate":firstNotifiedDate
            ], encoding: JSONEncoding.default, headers: [
                "authorization":"Bearer \(token)"
            ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    return completion(error, nil, false)
                    
                case .success(let value):
                    guard let value = value as? [String: Any] else { return }
                    
                    guard let ok = value["ok"] as? Bool else { return }
                    if ok {
                        return completion(nil, nil, ok)
                    }else {
                        guard let message = value["message"] as? String else { return }
                        return completion(nil, message, false)
                    }
                    
                    break
                }
            }
            
        }
        
    }
    
    func fetchNotifications(petId:String, completion:@escaping(Error?, String?, Bool, [NotificationModel]?) -> Void) {
    
        guard let url = URL(string: "\(url)/\(petId)") else {
            return completion(nil, "URL 객체를 만들다 실패하였습니다.", false, nil)
        }
        AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                return completion(error, nil, false, nil)
                
            case .success(let value):
                guard let value = value as? [String:Any] else {return}
                guard let ok = value["ok"] as? Bool else { return }
                if ok {
                    guard let notificationDictionaries = value["notifications"] as? [[String:Any]] else { return }
                    
                    var notifications:[NotificationModel] = []
                    
                    for dict in notificationDictionaries {
                        let notification = NotificationModel(dictionary: dict)
                        notifications.append(notification)
                    }
                    
                    return completion(nil, nil, true, notifications)
                    
                }else {
                    guard let message = value["message"] as? String else { return }
                    return completion(nil, message, false, nil)
                }
            }
        }
    }
}
