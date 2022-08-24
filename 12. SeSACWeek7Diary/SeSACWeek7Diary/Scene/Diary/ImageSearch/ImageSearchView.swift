//
//  ImageSearchView.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/20.
//

import UIKit
import SnapKit

class ImageSearchView: BaseView {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    
    let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 3 - 15
        layout.itemSize = CGSize(width: width, height: width)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        view.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [searchBar, imageCollectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundColor = .green
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.height.equalTo(44)
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.top.equalTo(searchBar.snp_bottomMargin).offset(7)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
