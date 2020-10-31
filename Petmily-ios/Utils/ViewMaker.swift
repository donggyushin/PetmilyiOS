//
//  ViewMaker.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/01.
//

import UIKit

class ViewMaker {
    static let shared = ViewMaker()
    
    private lazy var underline:UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private lazy var imageView:UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return iv
    }()
    
    private lazy var label:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9)
        label.textAlignment = .center
        return label
    }()
    
    func makeUIViewContainerWithImageIconAndUnderline(viewToAdd:UIView, image:UIImage, width:CGFloat, height:CGFloat, darkMode:Bool, text:String) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        
        view.addSubview(imageView)
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        self.label.text = text
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true 
        
        
        if darkMode {
            imageView.tintColor = .white
        }else {
            imageView.tintColor = .black
        }
        
        
        view.addSubview(viewToAdd)
        viewToAdd.translatesAutoresizingMaskIntoConstraints = false
        viewToAdd.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        viewToAdd.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 12).isActive = true
        viewToAdd.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        view.addSubview(underline)
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 12).isActive = true
        underline.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        underline.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true 
        
        return view
    }
}
