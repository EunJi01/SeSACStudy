//
//  BucketlistTableViewController.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/19.
//

import UIKit

struct Todo {
    var title: String
    var done: Bool
}

class BucketlistTableViewController: UITableViewController {

    static let identifire = "BucketlistTableViewController"
    
    var textFieldPlaceholder = "검색어를 입력해주세요"
    
    // 클래스는 ReferenceType -> 인스턴스 자체를 변경하지 않는 이상 한 번만 호출된다.
    // IBOutlet ViewDidLoad 호출 되기 직전에 nil이 아닌지 nil인지 알 수 있음.
    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            userTextField.textAlignment = .center
            userTextField.font = .boldSystemFont(ofSize: 22)
            userTextField.textColor = .systemRed
            userTextField.placeholder = "ㅁㅁ"
            print("텍스트필드 DidSet")
        }
    }
    
    // List 프로퍼티가 추가, 삭제 등 변경 되고 나서 테이블뷰 항상 갱신!
    var list = [Todo(title: "범죄도시2", done: false), Todo(title: "탑건", done: false)] {
        didSet {
            tableView.reloadData()
            print("리스트가 변경됨! \(list), \(oldValue)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField.placeholder = textFieldPlaceholder
        
        navigationItem.title = "버킷리스트"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))

        tableView.rowHeight = 80
        
//        list.append("마녀")
//        list.append("겨울왕국")
        
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
//        // case 2. if let
//        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), (2...6).contains(value.count) {
//            list.append(value)
//            tableView.reloadData()
//        } else {
//            // 토스트 메세지 띄우기
//        }
//
//        // case 3. guard 구문으로 활용
//        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), (2...6).contains(value.count) else {
//            // 얼럿 / 토스트 메세지 띄우기
//            return
//        }
        //list.append(sender.text!)
        list.append(Todo(title: sender.text!, done: false))
        //tableView.reloadData()
        
        // case 1. 강제 해제
//        list.append(sender.text!)
//        tableView.reloadData() // 중요! 데이터가 달라지는 시점에서 호출. 잘못하면 코드가 꼬이니 조심
        
        // 전체 코드를 전부 리로드할 필요가 없을 때 사용
        // tableView.reloadSections(<#T##sections: IndexSet##IndexSet#>, with: <#T##UITableView.RowAnimation#>)
        // tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0], with: .fade)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // as? 타입 캐스팅
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketlistTableViewCell.identifire, for: indexPath) as! BucketlistTableViewCell
        // for: indexPath 부분은, 애플이 제공하는 indexPath를 그대로 사용할 예정이라면 제외해도 문제가 없다. (오류 없이 돌아감)
        
        cell.bucketlistLabel.text = list[indexPath.row].title
        cell.bucketlistLabel.font = .boldSystemFont(ofSize: 18)
        
        cell.checkboxButton.tag = indexPath.row
        cell.checkboxButton.addTarget(self, action: #selector(checkBoxButtonTapped), for: .touchUpInside)
        
        let value = list[indexPath.row].done ? "checkmark.square.fill" : "checkmark.square"
        cell.checkboxButton.setImage(UIImage(systemName: value), for: .normal)
        
        return cell
    }
    
    @objc func checkBoxButtonTapped(sender: UIButton) {
        print("\(sender.tag)번째 버튼 클릭!")
        
        //배열 인덱스를 찾아서 done을 바꿔야 된다! 그리고 테이블뷰 갱신 해야 한다!
        list[sender.tag].done = !list[sender.tag].done
        
        //tableView.reloadData()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        
        // 재사용 셀 오류 확인용 코드
        //sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // 우측 스와이프 디폴트 기능: commit editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // 배열 후 테이블뷰 갱신
            list.remove(at: indexPath.row)
            //tableView.reloadData()
            // tableView.reloadSections(<#T##sections: IndexSet##IndexSet#>, with: <#T##UITableView.RowAnimation#>)
        }
        
    }
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        // 오른쪽
//    }
    
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        // 왼쪽 // 카카오톡 즐겨찾기 핀고정
//    }
}
