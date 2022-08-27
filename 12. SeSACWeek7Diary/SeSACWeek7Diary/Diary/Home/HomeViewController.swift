//
//  HomeViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/22.
//

import UIKit
import SnapKit
import FSCalendar
import SeSAC2UIFramework
import RealmSwift // Realm 1. import

final class HomeViewController: BaseViewController {
    
    let repository = UserDiaryRepository()
    
    lazy var calender: FSCalendar = {
        let view = FSCalendar()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        view.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
        return view
    }() // 즉시 실행 클로저
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        return formatter
    }()
    
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
        //fetchDocumentZipFile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRealm()
    }
    
    func fetchRealm() {
        // Realm 3. Realm 데이터를 정렬해 tasks에 담기 -> didSet 구문 실행됨
        tasks = repository.fetch()
    }
    
    override func configure() {
        view.addSubview(tableView)
        view.addSubview(calender)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonTapped))
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButton))
        navigationItem.leftBarButtonItems = [sortButton, backupButton]
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.topMargin.equalTo(300)
        }
        
        calender.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
    }
    
    @objc func backupButton() {
        let vc = BackupViewController()
        transition(vc, transitionStyle: .present)
    }
    
    @objc func sortButtonTapped() {
        tasks = repository.fetchSort()
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
            
            self.repository.updateFavorite(item: self.tasks[indexPath.row])
            
            // 아래의 방법 중 선택적
            // 1. 스와이프한 셀 하나만 reloadRows 코드를 구현 => 상대적 효율성
            // 2. 데이터가 변경됐으니 다시 realm 에서 데이터를 가져오기 => didSet 일관적 형태로 갱신
            self.fetchRealm() // 데이터 양이 많아졌읊 때를 대비해 명시적으로 호출
        }
        
        // Realm 데이터 기준
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        favorite.image = UIImage(systemName: image)
        favorite.backgroundColor = .systemPink
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in

            self.repository.deleteItem(item: self.tasks[indexPath.row])
            self.fetchRealm()
//            tableView.beginUpdates()
//            tableView.endUpdates()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchDate(date: date).count
    }
    
    // date: yyyyMMdd hh:mm:ss => dateformatter
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return formatter.string(from: date) == "220907" ? "오프라인 모임" : nil
    }

    // 일기 100개 -> 25일 3개 -> 3개 보여주기
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        tasks = repository.fetchDate(date: date)
    }
    
    //    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
    //        return "새싹"
    //    }
    //
    //
    //    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
    //        return UIImage(systemName: "star.fill")
    //    }
    //
    //    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
    //        <#code#>
    //    }
    //
}
