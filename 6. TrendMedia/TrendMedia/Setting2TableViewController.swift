//
//  Setting2TableViewController.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/18.
//

import UIKit

class Setting2TableViewController: UITableViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var allSetting: [String] = ["공지사항", "실험실" ,"버전 정보"]
    var personalSetting: [String] = ["개인/보안", "알림", "채팅", "멀티프로필"]
    var otherSetting: [String] = ["고객센터/도움말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designTitleLabel()
        
        tableView.backgroundColor = .black
        tableView.separatorColor = .darkGray
        
    }

    // 섹션의 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    // 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return allSetting.count
        case 1: return personalSetting.count
        case 2: return otherSetting.count
        default: return 0
        }
        
    }
    
    // 셀의 디자인과 데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        switch indexPath.section {
        case 0: cell.textLabel?.text = allSetting[indexPath.row]
        case 1: cell.textLabel?.text = personalSetting[indexPath.row]
        case 2: cell.textLabel?.text = otherSetting[indexPath.row]
        default: cell.textLabel?.text = "오류"
        }
        
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.textLabel?.font = .systemFont(ofSize: 13)
        
        return cell
    }
    
    // 헤더
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "전체 설정"
        case 1: return "개인 설정"
        case 2: return "기타"
        default: return "오류"
        }
    }
    
    // 헤더 디자인
    
    
    // 타이틀 레이블 디자인
    func designTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.text = "설정"
    }
    
    
}
