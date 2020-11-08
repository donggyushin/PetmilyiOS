//
//  KindView.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/04.
//

import UIKit
import SDWebImage

protocol KindViewDelegate:class {
    func cellSelected(petKind:PetListModel)
}

class KindView: UICollectionViewCell {
    
    // MARK: - Properties
    weak var delegate:KindViewDelegate?
    
    
    var petKind:PetListModel? {
        didSet {
            setProperties()
        }
    }
    
    
    private lazy var photo:UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 44).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 44).isActive = true
        iv.layer.cornerRadius = 22
        iv.backgroundColor = .secondarySystemBackground
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var name:UILabel = {
        let label = UILabel()
        label.text = "test"
        return label
    }()
    
    private lazy var stack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [photo, name])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .leading
        return stack
    }()
    
    
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
        
        backgroundColor = .systemBackground
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
    }
    
    // MARK: - Helpers
    func setProperties() {
        guard let petKind = petKind else { return }
        if let urlString = petKind.photourl {
            if let url = URL(string: urlString) {
                self.photo.sd_setImage(with: url, completed: nil)
            }
            
        }
        
        let name = petKind.name
        self.name.text = name
    }
    
    // MARK: - Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        layer.opacity = 0.6
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        layer.opacity = 1
        guard let petKind = self.petKind else { return }
        self.delegate?.cellSelected(petKind: petKind)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        layer.opacity = 1
    }
    
}
