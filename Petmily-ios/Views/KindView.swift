//
//  KindView.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/04.
//

import UIKit

class KindView: UICollectionViewCell {

    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configures
    func configureUI() {
        
        backgroundColor = .systemPink
    }
    
    // MARK: - Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 0.6
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }
    
}
