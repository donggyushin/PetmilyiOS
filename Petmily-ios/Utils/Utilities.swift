//
//  Utilities.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class Utilities {
    static let shared = Utilities()
    
    private lazy var underLineView:UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemFill
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    func makeInputContainerView(textField:UITextField) -> UIView {
        let view = UIView()
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(underLineView)
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        underLineView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        underLineView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        
        
        return view
    }
}
