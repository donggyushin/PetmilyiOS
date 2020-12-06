//
//  NaverAddressService.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/06.
//

import Foundation
import Alamofire

class NaverAddressService {
    static let shared = NaverAddressService()
    
    func searchAddressWithQuery(query:String, completion:@escaping(Error?, String?, Bool, [NaverAddressModel]) -> Void) {
        let urlString = "https://openapi.naver.com/v1/search/local.json?query=\(query)&display=5"
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let header = [
            "X-Naver-Client-Id": NaverSecretKeys.clientId,
            "X-Naver-Client-Secret": NaverSecretKeys.secretId
        ]
        
        
        guard let url = URL(string: encodedString) else { return completion(nil, "url 객체를 만드는데 실패하였습니다", false, []) }
        AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPHeaders.init(header), interceptor: nil, requestModifier: nil).responseJSON { (response) in
            var addresses:[NaverAddressModel] = []
            switch response.result {
            case .failure(let error):
                return completion(error, nil, false, [])
            case .success(let value):
                
                guard let value = value as? [String:Any] else { return }
                guard let itemsDictionaries = value["items"] as? [[String:Any]] else { return }
                for dict in itemsDictionaries {
                    let address = NaverAddressModel(dict: dict)
                    addresses.append(address)
                }
                return completion(nil, nil, true, addresses)
            }
        }
    }
    
    
}
