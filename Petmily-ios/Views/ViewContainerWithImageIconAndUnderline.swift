//
//  ViewContainerWithImageIconAndUnderline.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/01.
//

import UIKit

class ViewContainerWithImageIconAndUnderline: UIView {
    
    // MARK: Properties
    
    
    private lazy var underline:UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private lazy var imageView:UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return iv
    }()
    
    private lazy var label:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycles
    
    init(viewToAdd:UIView, image:UIImage, width:CGFloat, height:CGFloat, darkMode:Bool, text:String) {
        super.init(frame: CGRect.zero)
        
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
        addSubview(imageView)
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        self.label.text = text
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        
        
        if darkMode {
            imageView.tintColor = .white
        }else {
            imageView.tintColor = .black
        }
        
        
        
        
        
        addSubview(underline)
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 12).isActive = true
        underline.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        underline.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(viewToAdd)
        viewToAdd.translatesAutoresizingMaskIntoConstraints = false
        viewToAdd.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        viewToAdd.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 12).isActive = true
        viewToAdd.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        self.label.text = text
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    // MARK: - Overrides
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.userInterfaceStyle == UIUserInterfaceStyle.dark {
            self.imageView.tintColor = .black
        }else {
            self.imageView.tintColor = .white
        }
    }

}
