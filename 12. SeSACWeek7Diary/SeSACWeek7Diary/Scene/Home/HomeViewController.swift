//
//  HomeViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/22.
//

import UIKit
import SnapKit
import RealmSwift
import SeSAC2UIFramework

import RealmSwift // Realm 1. import

class HomeViewController: BaseViewController {
    
    let localRealm = try! Realm() // Realm 2.
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        view.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
        return view
    }() // 즉시 실행 클로저
    
    var tasks: Results<UserDiary>! {
        didSet {
            // 화면 갱신은 화면 전환 코드랑 생명 주기 실행 점검 필요!
            // present, overCurrentContext, overFullScreen > viewWillAppear X
            tableView.reloadData() // 정렬, 필터, 즐겨찾기 등
            print("Tasks Changed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRealm()
    }
    
    func fetchRealm() {
        // Realm 3. Realm 데이터를 정렬해 tasks에 담기 -> didSet 구문 실행됨
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
    }
    
    override func configure() {
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonTapped))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.leftBarButtonItems = [sortButton, filterButton]
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func sortButtonTapped() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "regdate", ascending: true)
    }
    
    // realm filter query, NSPredicate
    @objc func filterButtonTapped() {
        tasks = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] '일기'")
    }
    
    @objc func plusButtonTapped() {
        let vc = WriteViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier) as? HomeTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = tasks[indexPath.row].diaryTitle
        cell.photoImageView.image = loadImageFormDocument(fileName: "\(tasks[indexPath.row].objectID).jpg")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yy/MM/dd\nhh:mm"
        let date = formatter.string(from: tasks[indexPath.row].diaryDate)
        
        cell.dateLabel.text = date
        
        return cell
    }
    
    // 커스텀 스와이프 (참고)한꺼번에 편집 : TaleView Edeting Mode
    // 테이블뷰 셀 높이가 작을 경우, 이미지가 없을 때, 시스템 이미지가 아닌 경우
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            print("favorite Button Tapped")
            
            // Realm Data Update 3가지 예시
            try! self.localRealm.write {
                // 1. 하나의 레코드에서 특정 컬럼 하나만 변경
                self.tasks[indexPath.row].favorite = !self.tasks[indexPath.row].favorite
                
//                // 2. 하나의 테이블에서 특정 컬럼 전체 값을 변경
//                self.tasks.setValue(true, forKey: "favorite")
//
//                // 3. 하나의 레코드에서 여러 컬럼들이 변경
//                self.localRealm.create(UserDiary.self, value: ["objectID": self.tasks[indexPath.row].objectID, "diaryContent": "변경 테스트", "diaryTitle": "제목임"], update: .modified)
                
                print("Realm Update Succeed, reloadRows 필요")
            }
            // 아래의 방법 중 선택적
            // 1. 스와이프한 셀 하나만 reloadRows 코드를 구현 => 상대적 효율성
            // 2. 데이터가 변경됐으니 다시 realm 에서 데이터를 가져오기 => didSet 일관적 형태로 갱신
            self.fetchRealm()
        }
        
        // Realm 데이터 기준
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        favorite.image = UIImage(systemName: image)
        favorite.backgroundColor = .systemPink
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
