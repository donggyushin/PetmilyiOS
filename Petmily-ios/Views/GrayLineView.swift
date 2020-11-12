//
//  GrayLineView.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/12.
//

import UIKit

class GrayLineView: UIView {

    // MARK: Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        heightAnchor.constraint(equalToConstant: 1).isActive = true
        backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
