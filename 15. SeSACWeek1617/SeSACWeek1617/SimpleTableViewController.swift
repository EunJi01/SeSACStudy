//
//  ViewController.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/18.
//

import UIKit

class SimpleTableViewController: UITableViewController {
    
    let list = ["슈비버거", "프랭크", "자갈치", "고래밥"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration() // 구조체이기 떄문에 var 로 선언
        content.text = list[indexPath.row] // textLabel
        content.secondaryText = "detail" // detailTextLabel
        
        cell.contentConfiguration = content
        
        return cell
    }
}
