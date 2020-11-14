//
//  LoadingViewWithoutBackground.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/14.
//

import UIKit

class LoadingViewWithoutBackground: UIView {
    
    
    // MARK: Properties
    
    private lazy var activityIndicator:UIActivityIndicatorView = {
        let av = UIActivityIndicatorView()
        return av
    }()
    
    // MARK: Lifecycles

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    

}
