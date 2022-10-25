//
//  SubjectViewController.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/25.
//

import UIKit
import RxSwift
import RxCocoa

class SubjectViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var newButton: UIBarButtonItem!
    
    let publish = PublishSubject<Int>() // 초기값이 없는 빈 상태
    let behavior = BehaviorSubject(value: 100) // 초기값 필수
    // bufferSize에 작성된 이벤트 갯수만큼 메모리에서 이벤트를 가지고 있다가, subscribe 직후 한번에 이벤트를 전달
    let replay = ReplaySubject<Int>.create(bufferSize: 3)
    let async = AsyncSubject<Int>() // 거의 사용 X
    
    let disposeBag = DisposeBag()
    let viewModel = SubjectViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ContactCell")
        
        viewModel.list
            .bind(to: tableView.rx.items(cellIdentifier: "ContactCell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = "\(element.name): \(element.age)세 (\(element.number))"
            }
            .disposed(by: disposeBag)
            
        addButton.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.viewModel.fetchData()
            }
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.viewModel.resetData()
            }
            .disposed(by: disposeBag)
        
        newButton.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.viewModel.newData()
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance) // wait
            //.distinctUntilChanged() // 같은 값을 받지 않음
            .withUnretained(self) // self => [weak self] = vc
            .subscribe { vc, value in
                print("====\(value)")
                vc.viewModel.filterData(query: value)
            }
            .disposed(by: disposeBag)
    }
}

extension SubjectViewController {
    
    func asyncSubject() {
        // completed 이벤트를 만나면 마지막 값을 emit

        async.onNext(1)
        async.onNext(2) // subscribe 전이므로 값 변경이 되지 않는다.
        
        async
            .subscribe { value in
                print("async - \(value)")
            } onError: { error in
                print("async - \(error)")
            } onCompleted: {
                print("async - completed")
            } onDisposed: {
                print("async - disposed")
            }
            .disposed(by: disposeBag)
        
        async.onNext(3) // 값 변경
        async.onNext(4)
        async.on(.next(5)) // onNext와 동일
        
        async.onCompleted()
        
        async.onNext(6) // completed 되었기 때문에 값 변경이 되지 않는다.
    }
    
    func replaySubject() {
        // behavior와 비슷하지만, 초기값을 여러개 가질 수 있음 (가장 최근 값부터 n개)
        // 만약 BufferSize가 1000개라면? 메모리에 부담! (특히 array, image 라면...)
        
        replay.onNext(100)
        replay.onNext(200)
        replay.onNext(300)
        replay.onNext(400)
        replay.onNext(500)
        
        replay
            .subscribe { value in
                print("replay - \(value)")
            } onError: { error in
                print("replay - \(error)")
            } onCompleted: {
                print("replay - completed")
            } onDisposed: {
                print("replay - disposed")
            }
            .disposed(by: disposeBag)
        
        replay.onNext(3) // 값 변경
        replay.onNext(4)
        replay.on(.next(5)) // onNext와 동일
        
        replay.onCompleted()
        
        replay.onNext(6) // completed 되었기 때문에 값 변경이 되지 않는다.
    }
    
    func behaviorSubject() {
        // 구독 전에 가장 최근 값을 같이 emit
        
        behavior.onNext(1)
        behavior.onNext(2)
        
        behavior
            .subscribe { value in
                print("behavior - \(value)")
            } onError: { error in
                print("behavior - \(error)")
            } onCompleted: {
                print("behavior - completed")
            } onDisposed: {
                print("behavior - disposed")
            }
            .disposed(by: disposeBag)
        
        behavior.onNext(3) // 값 변경
        behavior.onNext(4)
        behavior.on(.next(5)) // onNext와 동일
        
        behavior.onCompleted()
        
        behavior.onNext(6) // completed 되었기 때문에 값 변경이 되지 않는다.
    }
    
    func publishSubject() {
        // 초기값이 없는 빈 상태, subscribe 전/error/completed notification 이후 이벤트 무시
        // subscribe 후에 대한 이벤트는 전부 처리
        
        publish.onNext(1)
        publish.onNext(2) // subscribe 전이므로 값 변경이 되지 않는다.
        
        publish
            .subscribe { value in
                print("publish - \(value)")
            } onError: { error in
                print("publish - \(error)")
            } onCompleted: {
                print("publish - completed")
            } onDisposed: {
                print("publish - disposed")
            }
            .disposed(by: disposeBag)
        
        publish.onNext(3) // 값 변경
        publish.onNext(4)
        publish.on(.next(5)) // onNext와 동일
        
        publish.onCompleted()
        
        publish.onNext(6) // completed 되었기 때문에 값 변경이 되지 않는다.
    }
}
