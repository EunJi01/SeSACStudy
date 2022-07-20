//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/19.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 140
        tableView.backgroundColor = .black
        
    }

    // 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movie.allCases.count
    }
    
    // 셀의 디자인/데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        
        cell.movieTitleLabel.text = Movie.allCases[indexPath.row].title
        cell.movieTitleLabel.textColor = .white
        
        cell.dateLabel.text = Movie.allCases[indexPath.row].date
        cell.dateLabel.textColor = .lightGray
        
        cell.plotTextView.text = Movie.allCases[indexPath.row].plot
        cell.plotTextView.textColor = .gray
        cell.plotTextView.backgroundColor = .black
        
        cell.backgroundColor = .black
        
        return cell
    }
}
