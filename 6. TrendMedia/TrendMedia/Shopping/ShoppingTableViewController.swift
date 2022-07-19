//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/19.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addBackgroundView: UIView!
    
    
    var shoppingList: [String] = ["테스트1", "테스트2", "테스트3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designUIView()
        
        tableView.rowHeight = 50
        
    }
    
    // 텍스트필드 리턴
    @IBAction func addTextFieldReturn(_ sender: UITextField) {
        
        shoppingList.append(addTextField.text!)
        tableView.reloadData()
        
    }
    
    // 추가버튼 눌렸을 때
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        shoppingList.append(addTextField.text!)
        tableView.reloadData()
        
    }
    
    //셀의 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    
    // 셀 디자인/데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell") as! ShoppingTableViewCell
        
        cell.shoppingListLabel.text = shoppingList[indexPath.row]
        
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            tableView.reloadData()
        }
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
