//
//  SelectKindController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/01.
//

import UIKit

let reuseIdentifierForKindView = "reuseIdentifierForKindView"

class SelectKindController: UIViewController {

    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var kindDatas = ["1", "2", "3"]
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configure()
    }
    
    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true

    }
    
    func configure() {

        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(KindView.self, forCellWithReuseIdentifier: reuseIdentifierForKindView)
        
        
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "품종을 검색해주세요"
        // 4
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
    }
    

}

extension SelectKindController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        print(searchText)
    }
    
    
}

extension SelectKindController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.kindDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierForKindView, for: indexPath) as! KindView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    
}
