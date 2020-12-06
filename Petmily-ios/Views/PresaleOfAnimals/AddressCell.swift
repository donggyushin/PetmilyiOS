//
//  AddressCell.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/06.
//

import UIKit

protocol AddressCellDelegate:class {
    func addressCellTapped(sender:AddressCell)
}

class AddressCell: UICollectionViewCell {
    
    // MARK: Properties
    weak var delegate:AddressCellDelegate?
    var address:NaverAddressModel? {
        didSet {
            guard let address = self.address else { return }
            self.title.text = address.title
            self.categoryLabel.text = address.category
            self.addressLabel.text = address.address
            self.roadAddressLabel.text = address.roadAddress
            self.xyLabel.text = "(\(address.mapx),\(address.mapy))"
        }
    }
    
    private lazy var title:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var categoryLabel:UILabel = {
        let label = UILabel()
        label.textColor = .placeholderText
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var addressLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var roadAddressLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var xyLabel:UILabel = {
        let label = UILabel()
        label.textColor = .placeholderText
        label.font = UIFont.systemFont(ofSize: 12)
        return label
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
    func configureUI() {
        backgroundColor = .systemBackground
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.bottomAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        categoryLabel.leftAnchor.constraint(equalTo: title.rightAnchor, constant: 10).isActive = true
        
        addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        addressLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15).isActive = true
        
        addSubview(roadAddressLabel)
        roadAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        roadAddressLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 15).isActive = true
        roadAddressLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        addSubview(xyLabel)
        xyLabel.translatesAutoresizingMaskIntoConstraints = false
        xyLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        xyLabel.topAnchor.constraint(equalTo: roadAddressLabel.bottomAnchor, constant: 15).isActive = true
    }
    
    // MARK: Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 0.6
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
        delegate?.addressCellTapped(sender: self)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }
}
