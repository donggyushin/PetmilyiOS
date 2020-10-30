//
//  FileService.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/31.
//

import UIKit
import Firebase

class FileService {
    static var shared = FileService()
    
    let storage = Storage.storage()
    let imageRef = Storage.storage().reference().child("images")
    
    func uploadImageFile(image:UIImage, completion:@escaping(Error?, String?, String?) -> Void) {
        guard let data = image.pngData() else {
            completion(nil, "이미지를 데이터로 변환하던 도중에 에러가 발생하였습니다", nil)
            return
        }
        
        
        let uuid = NSUUID().uuidString
        
        let imageRef = self.imageRef.child("\(uuid).jpg")
        let uploadTask = imageRef.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                completion(error, "이미지를 업로드 하던 도중에 에러가 발생하였습니다.", nil)
                print(error.localizedDescription)
                return
            }
            
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    completion(error, "이미지 url 을 받아오는데에 실패하였습니다.", nil)
                    return
                }
                
                guard let url = url else { return }
                completion(nil, nil, url.absoluteString)
                return
            }
        }
        uploadTask.resume()
        
    }
}
