//
//  PetCell.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/07.
//

import UIKit
import SDWebImage

protocol PetCellDelegate:class {
    func cellTapped(petCell:PetCell)
}

class PetCell:UICollectionViewCell {
    
    // MARK: - Properties
    weak var delegate:PetCellDelegate?
    
    var pet:PetModel? {
        didSet {
            self.configurePet()
        }
    }
    
    private lazy var photo:UIImageView = {
        let iv = UIImageView()
        let size = frame.width - 40
        iv.widthAnchor.constraint(equalToConstant: size).isActive = true
        iv.heightAnchor.constraint(equalToConstant: size).isActive = true
        iv.layer.cornerRadius = size / 2
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .secondarySystemBackground
        return iv
    }()
    
    private lazy var name:UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var kind:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        return label
    }()
    
    private lazy var grayLine:GrayLineView = {
        let view = GrayLineView()
        
        return view
    }()
    
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
//        let stack = UIStackView(arrangedSubviews: [photo, name, kind])
//        stack.axis = .vertical
//        stack.spacing = 10
//        stack.alignment = .center
//        addSubview(stack)
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        stack.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        stack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        
        addSubview(photo)
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.topAnchor.constraint(equalTo: topAnchor).isActive = true
        photo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 35).isActive = true
        name.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(kind)
        kind.translatesAutoresizingMaskIntoConstraints = false
        kind.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 3).isActive = true
        kind.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(grayLine)
        grayLine.translatesAutoresizingMaskIntoConstraints = false
        grayLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        grayLine.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        grayLine.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        grayLine.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        
        
    }
    
    // MARK: - Helpers
    func configurePet() {
        guard let pet = self.pet else { return }
        if let url = URL(string: pet.photourl) {
            self.photo.sd_setImage(with: url, completed: nil)
        }
        self.name.text = pet.name
        self.kind.text = pet.kind
    }
    
    // MARK: - Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 0.6
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
        self.delegate?.cellTapped(petCell: self)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }
}
