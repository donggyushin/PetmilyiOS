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
    
    func uploadImageFiles(images:[UIImage], completion:@escaping(Error?, String?, [String]?) -> Void){
        var imageDatas:[Data] = []
        var urls:[String] = []
        let group = DispatchGroup()
        
        
        images.forEach { (image) in
            guard let data = image.pngData() else { return completion(nil, "데이터로 변환하던 도중에 손실된 이미지가 있습니다.", nil)}
            imageDatas.append(data)
        }
        
        if imageDatas.count != images.count {
            return completion(nil, "데이터로 변환하던 도중에 손실된 이미지가 있습니다.", nil)
        }
        
        
        imageDatas.forEach { (data) in
            
            let uuid = NSUUID().uuidString
            let imageRef = self.imageRef.child("\(uuid).jpg")
            group.enter()
            let uploadTask = imageRef.putData(data, metadata: nil) { (metadata, error) in
                if let error = error {
                    return completion(error, nil, nil)
                }
                imageRef.downloadURL { (url, error) in
                    if let error = error {
                        return completion(error, nil, nil)
                    }
                    guard let url = url else { return }
                    urls.append(url.absoluteString)
                    group.leave()
                    
                }
            }
            uploadTask.resume()
        }
        
        group.notify(queue: DispatchQueue.main) {
            return completion(nil, nil, urls)
        }
    }
    
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
