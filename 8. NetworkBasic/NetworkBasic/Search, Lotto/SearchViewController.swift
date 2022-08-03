//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by 황은지 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON

/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 왼팔 / 오른팔
 2. 테이블뷰 아웃렛 연결
 3. 1번과 2번을 연결
 */

/*
 각 json value -> list -> 테이블뷰 갱신
 응답이 몇개인지 모를 경우에는?
 
 let movieNm1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
 let movieNm2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
 let movieNm3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
 
 // list 배열에 데이터 추가
 self.list.append(movieNm1)
 self.list.append(movieNm2)
 self.list.append(movieNm3)
 */

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // BoxOffice 배열
    var list: [BoxOfficeModel] = []
    
    // 타입 어노테이션 vs 타입 추론 => 누가 더 속도가 빠를까?
    // What's new in Swift
    var nickname: String = ""
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 연결고리 작업 : 테이블뷰가 해야 할 역할을 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        // XIB : xml interface builder <= Nib
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        searchBar.delegate = self
        //requestBoxOffice(text: yesterday())
        
        // Date DateFormatter Calendar
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd" // TMI -> "yyyyMMdd" "YYYYMMdd"
        //let dateResult = Date(timeIntervalSinceNow: -86400)
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateResult = format.string(from: yesterday!)
        
        // 네트워크 통신 : 서버 점검 등에 대한 예외 처리
        // 네트워크가 느린 환경 테스트
        // 실기기 테스트 시 Condition 조절 가능!
        
        requestBoxOffice(text: dateResult)
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func configureLabel() {
        
    }
    
    func requestBoxOffice(text: String) {
        
        list.removeAll()
        
        // 인증키 제한
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let rank = movie["rank"].stringValue
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNm, rank: rank, releaseDate: openDt, totalCount: audiAcc)
                    
                    self.list.append(data)
                }
                
                //print(self.list)
                
                // 테이블뷰 갱신
                self.searchTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = .clear
        
        cell.titleLabel.text = "\(list[indexPath.row].movieTitle)"
        cell.releaseLabel.text = "개봉일 : \(list[indexPath.row].releaseDate)"
        cell.rankLabel.text = "\(list[indexPath.row].rank)"
        
        if let totalAudience = Int(list[indexPath.row].totalCount) {
            cell.audienceLabel.text = "관객수 : \(totalAudience.formatted())명"
        }
        
        return cell
    }
    
//    func yesterday() -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyyMMdd"
//
//        let currentDate = Int(formatter.string(from: Date()))!
//        let yesterday = currentDate - 1
//        print(yesterday)
//
//        return String(yesterday)
//    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice(text: searchBar.text!) // 옵셔널 바인딩, 8글자, 숫자, 날짜로 변경 시 유효한 형태의 값인지 등
    }
}
