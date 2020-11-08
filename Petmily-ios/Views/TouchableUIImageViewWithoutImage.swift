//
//  TouchableUIImageViewWithoutImage.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/08.
//

import UIKit

protocol TouchableUIImageViewWithoutImageDelegate:class {
    func touchableUIImageViewWithoutImageTapped()
}

class TouchableUIImageViewWithoutImage: UIImageView {
    
    weak var delegate:TouchableUIImageViewWithoutImageDelegate?
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 0.6
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
        delegate?.touchableUIImageViewWithoutImageTapped()
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }

}
