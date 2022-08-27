//
//  SearchView.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/26.
//

import UIKit
import SnapKit
import SeSAC2UIFramework

class SearchView: BaseView {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        view.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [searchBar, tableView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.height.equalTo(44)
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp_bottomMargin).offset(7)
        }
    }
}
