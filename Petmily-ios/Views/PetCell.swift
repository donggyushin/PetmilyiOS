//
//  PetCell.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/07.
//

import UIKit

class PetCell:UICollectionViewCell {
    
    // MARK: Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configures
    func configureUI(){
        backgroundColor = .systemPink
    }
}
