//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    var birthdayFriends = ["뽀로로", "신데렐라", "모구리", "스노기", "고래밥"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 섹션의 갯수(옵션)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "생일인 친구"
        } else if section == 1 {
            return "즐겨찾기"
        } else if section == 2 {
            return "친구 10명"
        } else {
            return "섹션"
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "푸터"
    }
    
    // 1. 셀의 갯수(필수) : numberOfRowsInSection
    // ex. 카톡 100명 > 셀 100개, 3000명 > 셀 3000개
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return birthdayFriends.count
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 10
        } else {
            return 0
        }
    }
    
    // 2. 셀의 디자인과 데이터(필수) : cellForRowAt
    // ex. 카톡 이점팔, 프로필 사진, 상태 메세지 등
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // *100 (여기서 복붙과 같은 효과)
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        if indexPath.section == 0 {
            
//            if indexPath.row == 0 {
//                cell.textLabel?.text = birthdayFriends[0]
//            } else if indexPath.row == 1 {
//                cell.textLabel?.text = birthdayFriends[indexPath.row]
//            } else if indexPath.row == 2 {
//                cell.textLabel?.text = birthdayFriends[2]
//            }
            
            cell.textLabel?.text = birthdayFriends[indexPath.row]
            cell.textLabel?.textColor = .systemMint
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
            
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "1번 인덱스 텍스트"
            cell.textLabel?.textColor = .systemPink
            cell.textLabel?.font = .italicSystemFont(ofSize: 25)
        } else if indexPath.section == 2 {
            cell.textLabel?.text = "2번 인덱스 섹션의 텍스트"
            cell.textLabel?.textColor = .brown
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        }
        
        return cell
        
    }
    
}
