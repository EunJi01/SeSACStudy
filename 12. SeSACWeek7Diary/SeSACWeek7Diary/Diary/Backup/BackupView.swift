//
//  BackupView.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/24.
//

import UIKit
import SnapKit
import SeSAC2UIFramework

class BackupView: BaseView {
    
    let backupButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .darkGray
        view.setTitle("백업", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        return view
    }()
    
    let restoreButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .darkGray
        view.setTitle("복원", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        return view
    }()
    
    let backupTableView: UITableView = {
        let view = UITableView()
        view.register(BackupTableViewCell.self, forCellReuseIdentifier: BackupTableViewCell.reuseIdentifier)
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [backupButton, restoreButton, backupTableView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        backupButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.leading.equalTo(backupButton.snp.leading)
            make.trailing.equalTo(backupButton.snp.trailing)
            make.height.equalTo(backupButton.snp.height)
            make.topMargin.equalTo(backupButton.snp.bottom).offset(20)
        }
        
        backupTableView.snp.makeConstraints { make in
            make.topMargin.equalTo(restoreButton.snp.bottom).offset(60)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}
