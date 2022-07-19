//
//  Setting2TableViewController.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/18.
//

import UIKit

// CaseIterable: 프로토콜, 배열처럼 열거형을 활용할 수 있는 특성
enum  SettingOptions: Int, CaseIterable {
    case total, personal, others // 섹션
    
    var settingTitle: String {
        switch self {
        case .total:
            return "전체 설정"
        case .personal:
            return "개인 설정"
        case .others:
            return "기타"
        }
    }
    
    var rowTitle: [String] {
        switch self {
        case .total:
            return ["공지사항", "실험실" ,"버전 정보"]
        case .personal:
            return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .others:
            return ["고객센터/도움말"]
        }
    }
}

class Setting2TableViewController: UITableViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designTitleLabel()
        
        // tableView.rowHeight = 80 // default 44
        tableView.backgroundColor = .black
        tableView.separatorColor = .darkGray
        
    }

    // 섹션의 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }

    // 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingOptions.allCases[section].rowTitle.count
    }
    
    // 셀의 디자인과 데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.textLabel?.font = .systemFont(ofSize: 13)
        
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].rowTitle[indexPath.row]
        
        return cell
    }
    
    // 헤더
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].settingTitle
    }
    
    // 타이틀 레이블 디자인
    func designTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.text = "설정"
    }
}
