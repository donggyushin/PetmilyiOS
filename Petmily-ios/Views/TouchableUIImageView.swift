//
//  TouchableUIImageView.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/31.
//

import UIKit

protocol TouchableUIImageViewProtocol:class {
    func touchableUIImageViewTapped()
}

class TouchableUIImageView: UIImageView {

    // MARK: - Properties
    let uiimage:UIImage
    weak var delegate:TouchableUIImageViewProtocol?
    
    // MARK: - Lifecycles
    init(image:UIImage) {
        self.uiimage = image
        super.init(frame: CGRect.zero)
        
        configureUI()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configures
    func configureUI() {
        image = uiimage
    }
    
    func configure() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSelector))
        addGestureRecognizer(tap)
    }
    
    // MARK: - Selectors
    @objc func tapSelector() {
        layer.opacity = 1
        self.delegate?.touchableUIImageViewTapped()
    }
    
    // MARK: - Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 0.7
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }
    
}
