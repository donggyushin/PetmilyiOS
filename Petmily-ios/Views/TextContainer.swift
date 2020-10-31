//
//  IdTextContainer.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class TextContainer:UIView {
    
    let textField:UITextField
    
    private lazy var underLineView:UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemFill
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    init(textField:UITextField) {
        self.textField = textField
        super.init(frame: CGRect.zero)
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true 
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(underLineView)
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        underLineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        underLineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
