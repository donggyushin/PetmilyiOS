//
//  NoticeItem.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/12.
//

import UIKit

protocol NoticeItemDelegate:class {
    func noticeItemTapped(sender:NoticeItem)
    func birthdayValueChanges(sender:NoticeItem, changedValue:Bool)
}

class NoticeItem: UIView {
    
    // MARK: Properties
    weak var delegate:NoticeItemDelegate?
    lazy var label:UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var switchButton:UISwitch = {
        let bt = UISwitch()
        bt.isOn = false
        bt.isUserInteractionEnabled = false
        bt.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        return bt
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
        backgroundColor = .systemBackground
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        addSubview(switchButton)
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
    
    // MARK: Selectors
    @objc func switchChanged(sender:UISwitch){
        
        self.delegate?.birthdayValueChanges(sender: self, changedValue: sender.isOn)
    }
    
    // MARK: Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 0.6
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
        self.delegate?.noticeItemTapped(sender: self)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }

}
