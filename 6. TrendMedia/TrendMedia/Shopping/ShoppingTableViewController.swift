//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/19.
//

import UIKit
import RealmSwift

class ShoppingTableViewController: UITableViewController {

    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addBackgroundView: UIView!
    
    let localRealm = try! Realm()
    var tasks: Results<UserShopList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designUIView()
        tableView.rowHeight = 50
        
        tasks = localRealm.objects(UserShopList.self).sorted(byKeyPath: "shopTitle", ascending: true)
        tableView.reloadData()
        
        // UIMenu 1. 버튼 등록
       self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "list.bullet"), primaryAction: nil, menu: menu())
    }
    
    // UIMenu 2. UIAction 생성 후 배열에 담아 UIMenu에 넣기
    @objc func menu() -> UIMenu {
        let menuItems = [
                UIAction(title: "제목 기준 정렬", image: UIImage(systemName: "pencil"), handler: { _ in self.sortShoppingList(Key: "shopTitle")}),
                UIAction(title: "즐겨찾기 기준 정렬", image: UIImage(systemName: "star"), handler: { _ in self.sortShoppingList(Key: "star")}),
                UIAction(title: "할 일 기준 정렬", image: UIImage(systemName: "checkmark.square"), handler: { _ in self.sortShoppingList(Key: "complete")}),
                UIAction(title: "전체 삭제", image: UIImage(systemName: "trash"), attributes: .destructive,  handler: { _ in self.resetData()})
            ]

        let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        return menu
    }
    
    func sortShoppingList(Key: String) {
        if Key == "shopTitle" || Key == "complete" {
            tasks = localRealm.objects(UserShopList.self).sorted(byKeyPath: Key, ascending: true)
        } else {
            tasks = localRealm.objects(UserShopList.self).sorted(byKeyPath: Key, ascending: false)
        }
        tableView.reloadData()
    }
    
    func resetData() {
        try! localRealm.write {
            localRealm.delete(tasks)
        }
        tableView.reloadData()
    }
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        try! localRealm.write {
            tasks[sender.tag].complete = !tasks[sender.tag].complete
        }
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        try! localRealm.write {
            tasks[sender.tag].star = !tasks[sender.tag].star
        }
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }
    
    // 텍스트필드 리턴
    @IBAction func addTextFieldReturn(_ sender: UITextField) {
        addButtonTapped(addButton)
    }
    
    // 추가버튼 눌렸을 때
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let task = UserShopList(shopTitle: addTextField.text!)
        
        try! localRealm.write {
            localRealm.add(task)
            tableView.reloadData()
        }
    }
    
    //셀의 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    // 셀 디자인/데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell") as! ShoppingTableViewCell
        cell.shoppingListLabel.text = tasks[indexPath.row].shopTitle
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 10
        
        cell.completeButton.tag = indexPath.row
        let complete = tasks[indexPath.row].complete ? "checkmark.square.fill" : "checkmark.square"
        cell.completeButton.setImage(UIImage(systemName: complete), for: .normal)
        
        cell.starButton.tag = indexPath.row
        let star = tasks[indexPath.row].star ? "star.fill" : "star"
        cell.starButton.setImage(UIImage(systemName: star), for: .normal)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! localRealm.write {
                localRealm.delete(tasks[indexPath.row])
            }
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ShoppingDetailViewController()
        vc.task = tasks[indexPath.row]
        present(vc, animated: true)
    }
    
    // 셀 밖 객체 디자인
    func designUIView() {
        
        addTextField.placeholder = "무엇을 구매하실 건가요?"
        addTextField.backgroundColor = .systemGray6
        addTextField.layer.borderColor = UIColor.systemGray6.cgColor
        
        addButton.layer.cornerRadius = 10
        addButton.backgroundColor = .systemGray4
//        addButton.titleLabel?.text = "추가"
//        addButton.titleLabel?.textColor = .black
        
        addBackgroundView.backgroundColor = .systemGray6
        addBackgroundView.layer.cornerRadius = 10
        
    }
}
