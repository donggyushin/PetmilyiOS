//
//  PetListService.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/05.
//

import Foundation
import Alamofire

class PetListService {
    static let shared = PetListService()
    
    func fetchPetList(completion:@escaping(Error?, String?, Bool, [PetListModel]?) -> Void) {
        let urlString = "\(Properties.PETMILY_API)/v1/pet/list"
        guard let url = URL(string: urlString) else {
            return completion(nil, "url 객체를 만드는데 실패하였습니다.", false, nil)
        }
        
        AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                return completion(error, "서버 내부에 알수없는 오류가 발생하였습니다.", false, nil)
                
            case .success(let value):
                
                var petlist:[PetListModel] = []
                
                guard let value = value as? [String:AnyObject] else {
                    return completion(nil, "데이터 변환에 실패하였습니다.", false, nil)
                }
                guard let petlistDictionaryList = value["petlist"] as? [[String:AnyObject]] else {
                    return completion(nil, "데이터 변환에 실패하였습니다.", false, nil)
                }
                
                for dictionary in petlistDictionaryList {
                    let petlistItem = PetListModel(dictionary: dictionary)
                    petlist.append(petlistItem)
                }
                
                return completion(nil, nil, true, petlist)
            }
        }
        
    }
}
