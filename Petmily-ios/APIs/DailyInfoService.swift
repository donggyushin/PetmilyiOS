//
//  DailyInfoService.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/28.
//

import Foundation
import Alamofire

class DailyInfoService {
    static let shared = DailyInfoService()
    
    func getRandomDailyInfo(completion:@escaping (Error?, String?, Bool, DailyInfoModel?) -> Void) {
        let urlString = "\(Properties.PETMILY_API)/v1/dailyInfo/random"
        print(urlString)
        guard let url = URL(string: urlString) else {
            return completion(nil, "url 객체를 만드는데 실패하였습니다.", false, nil)
        }
        
        AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                return completion(error, "여기?", false, nil)
            case .success(let value):
                guard let value = value as? [String:Any] else { return }
                let ok = value["ok"] as? Bool ?? false
                if ok {
                    guard let dailyInfoDictionary = value["dailyInfo"] as? [String:Any] else { return }
                    let dailyInfo = DailyInfoModel(dictionary: dailyInfoDictionary)
                    return completion(nil, nil, true, dailyInfo)
                }else {
                    return completion(nil, "알 수 없는 에러 발생", false, nil)
                }
                
            }
        }
    }
}
