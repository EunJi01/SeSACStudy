//
//  SubscribeViewController.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/26.
//

import UIKit
import RxCocoa
import RxSwift
import RxAlamofire
import RxDataSources

class SubscribeViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>> { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "\(item)"
        return cell
    }
    
    func testRxDataSource() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].model
        }
    
        Observable.just([
            SectionModel(model: "title", items: [1, 2, 3]),
            SectionModel(model: "title", items: [4, 5, 6]),
            SectionModel(model: "title", items: [7, 8, 9])
        ])
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func testRxAlamofire() {
        // Success Error => <Single>
        let url = APIKey.searchURL + "apple"
        request(.get, url, headers: ["Authorization": APIKey.authorization])
            .data()
            .decode(type: SearchPhoto.self, decoder: JSONDecoder())
            .subscribe(onNext: { value in
                print(value.results[0].likes)
            })
            .disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testRxAlamofire()
        testRxDataSource()
        
        Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
            .skip(3) // 3개를 무시
            .filter { $0 % 2 == 0 } // 짝수만
            .map { $0 * 2 } // 곱하기 2
            .subscribe { value in
                //print("===\(value)")
            }
            .disposed(by: disposeBag)
        
        bindData()
    }
    
    func bindData() {
        
        // 1. subscribe [weak self]
        button.rx.tap
            .subscribe { [weak self] _ in
                self?.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        // 2. subscribe withUnretained
        button.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        // 3. subscribe -> observe : 네트워크 통신이나 파일 다운로드 등 백그라운드 작업
        button.rx.tap
            .observe(on: MainScheduler.instance) // 다른 쓰레드로 동작하게 변경
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        // 4. bind : subscribe, mainSchedular, error X
        button.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        // 5. bind -> operator로 데이터의 stream 조작
        button.rx.tap
            .map { "안녕 반가워" }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        // 6. driver traits : bind + stream 공유 (리소스 낭비 방지, share())
        button.rx.tap
            .map { "안녕 반가워" }
            .asDriver(onErrorJustReturn: "")
            .drive(label.rx.text)
            .disposed(by: disposeBag)
    }
}
