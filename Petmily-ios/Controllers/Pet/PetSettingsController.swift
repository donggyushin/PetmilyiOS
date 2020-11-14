//
//  PetSettingsController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/12.
//

import UIKit

class PetSettingsController: UIViewController {
    
    // MARK: Properties
    let pet:PetModel
    
    var notifications:[NotificationModel] = [] {
        didSet {
            
            if let birthNotification = self.filterNotification(filter: "birth") {
                self.birthNoticeView.switchButton.isOn = birthNotification.isOn
            }else {
                self.birthNoticeView.switchButton.isOn = true
            }
            
        }
    }
    
    
    
    private lazy var backButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("나가기", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(backButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    
    private lazy var scrollView:UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var noticeLabel:UILabel = {
        let label = UILabel()
        label.text = "알림"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        return label
    }()
    
    private lazy var noticeInfoButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("알림에 대해서 자세하게 알고 싶으신가요?", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(noticeButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var line1 = GrayLineView()
    
    private lazy var noticeContainer:UIView = {
        let view = UIView()
        view.addSubview(noticeLabel)
        noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        noticeLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        noticeLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        view.addSubview(noticeInfoButton)
        noticeInfoButton.translatesAutoresizingMaskIntoConstraints = false
        noticeInfoButton.centerYAnchor.constraint(equalTo: noticeLabel.centerYAnchor).isActive = true
        noticeInfoButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(line1)
        line1.translatesAutoresizingMaskIntoConstraints = false
        line1.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        line1.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        line1.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        return view
    }()
    
    private lazy var miteNoticeView:NoticeItem = {
        let view = NoticeItem()
        view.label.text = "진드기 예방약"
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.delegate = self 
        return view
    }()
    
    private lazy var birthNoticeView:NoticeItem = {
        let view = NoticeItem()
        view.label.text = "생일 알림"
        view.switchButton.isOn = true
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var helminthicView:NoticeItem = {
        let view = NoticeItem()
        view.label.text = "구충제 알림"
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var loadingView:LoadingViewWithoutBackground = {
        let lv = LoadingViewWithoutBackground()
        return lv
    }()
    

    // MARK: Lifecycles
    
    init(pet:PetModel) {
        self.pet = pet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNav()
        fetchNotifications()
    }
    
    // MARK: APIs
    func fetchNotifications(){
        NotificationService.shared.fetchNotifications(petId: self.pet._id) { (error, errorMessage, success, notifications) in
            self.loadingView.isHidden = true
            if let errorMessage = errorMessage {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
            }
            
            if let error = error {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
            }
            
            if success == false {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러가 발생하였습니다.")
            }
            
            guard let notifications = notifications else { return }
            self.notifications = notifications
        }
    }
    
    // MARK: Configures
    func configureUI(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(noticeContainer)
        noticeContainer.translatesAutoresizingMaskIntoConstraints = false
        noticeContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        noticeContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        noticeContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        noticeContainer.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        
        let noticeStack = UIStackView(arrangedSubviews: [self.birthNoticeView, self.miteNoticeView,  self.helminthicView])
        noticeStack.axis = .vertical
        noticeStack.spacing = 6
        noticeStack.distribution = .fill
        
        scrollView.addSubview(noticeStack)
        noticeStack.translatesAutoresizingMaskIntoConstraints = false
        noticeStack.topAnchor.constraint(equalTo: noticeContainer.bottomAnchor, constant: 50).isActive = true
        noticeStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        noticeStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
         
    }
    
    func configureNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.backButton)
    }
    
    // MARK: Helpers
    func filterNotification(filter:String) -> NotificationModel?{
        let filteredNotifications = notifications.filter { (item) -> Bool in
            if item.name == filter {
                return true
            }else {
                return false
            }
        }
        
        if filteredNotifications.count == 0 {
            return nil
        }else {
            return filteredNotifications[0]
        }
    }
    
    // MARK: Selectors
    @objc func backButtonTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func noticeButtonTapped(){
        print("알림 정보 버튼 클릭")
    }
    

}


extension PetSettingsController:NoticeItemDelegate {
    func noticeItemTapped(sender: NoticeItem) {
        if sender == self.miteNoticeView {
            print("진드기 예방약 버튼 클릭")
        }
        if sender == self.helminthicView {
            print("구충제 예방 버튼 클릭")
        }
    }
    
}
