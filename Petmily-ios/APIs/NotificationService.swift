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
