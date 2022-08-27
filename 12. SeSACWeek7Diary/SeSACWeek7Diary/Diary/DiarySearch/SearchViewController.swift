//
//  SearchViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/26.
//

import UIKit
import RealmSwift
import SeSAC2UIFramework

final class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    let repository = UserDiaryRepository()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
    }
    
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.searchBar.delegate = self
    }
    
    var tasks: Results<UserDiary>! {
        didSet {
            mainView.tableView.reloadData()
            print("Tasks Changed")
        }
    }
    
    func fetchRealm() {
        tasks = repository.fetch()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text != "" {
            tasks = repository.fetchFilter(text: text)
        }
    }
}
