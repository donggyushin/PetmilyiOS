//
//  TouchableUIView.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/08.
//

import UIKit

protocol TouchableViewDelegate:class {
    func touchableUIViewTapped(sender:TouchableUIView)
}

class TouchableUIView: UIView {
    
    weak var delegate:TouchableViewDelegate?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 0.6
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
        delegate?.touchableUIViewTapped(sender: self)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }

}
