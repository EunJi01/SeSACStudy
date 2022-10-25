//
//  RxCocoaExampleViewController.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/24.
//

import UIKit
import RxCocoa
import RxSwift

class RxCocoaExampleViewController: UIViewController {
    
    @IBOutlet weak var simpleTableView: UITableView!
    @IBOutlet weak var simplePickerView: UIPickerView!
    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak var simpleSwitch: UISwitch!
    
    @IBOutlet weak var signName: UITextField!
    @IBOutlet weak var signEmail: UITextField!
    @IBOutlet weak var signButton: UIButton!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    var nickname = Observable.just("lia") // observable이기 때문에 값을 바꾸지 못함
    // 따라서 observable이자 observer인 subject로 대체!!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickname
            .bind(to: nicknameLabel.rx.text)
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // self.nickname = "HELLO"
        }
        
        setTableView()
        setPickerView()
        setSwitch()
        setSign()
        setOperator()
    }
    
    // viewController deinit 되면, 알아서 dispose도 동작한다.
    // 또는 DisposeBag() 객체를 새롭게 넣어주거나, nil 할당 => 예외 케이스! (rootVC에 interval이 있을 경우 등)
    deinit {
        print(#function)
    }
    
    func setOperator() {
        
        // repeatElement : 반복 -> Infinite Observable Sequence
        Observable.repeatElement("lia")
            .take(5) // 최대 5번까지 시도 -> Finite Observable Sequence
            .subscribe { value in
                print("repeat - \(value)")
            } onError: { error in
                print("repeat - \(error)")
            } onCompleted: {
                print("repeat completed")
            } onDisposed: {
                print("repeat disposed")
            }
            .disposed(by: disposeBag)
        
        // interval : 설정한 시간마다 반복 -> Infinite Observable Sequence
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("interval - \(value)")
            } onError: { error in
                print("interval - \(error)")
            } onCompleted: {
                print("interval completed")
            } onDisposed: {
                print("interval disposed")
            }
            .disposed(by: disposeBag)
        
        // DisposeBag : 리소스 해제 관리 - 1. 시퀀스가 끝날 때 but bind
        //                             2. class deinit 자동 해제 (bind)
        //                             3. dispose 직접 호출 (dispose())
        //                             4. DisposeBag을 새롭게 할당하거나, nil 전달
        // dispose() : 구독하는 것 마다 별도로 관리해야 하기 때문에 번거롭다.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // 5초 후에 dispose -> Finite Observable Sequence
            self.disposeBag = DisposeBag() // -> 한번에 리소스 정리
            // ARC로 deinit만 잘 되도록 코드를 작성하면, Infinite Observable Sequence에 대해 dispose를 별도로 설정하지 않아도 된다.
            // 하지만 루트뷰라면...?! deinit이 되지 않기 때문에, self.disposeBag = DisposeBag() 처럼 특정 시점에서 dispose를 해줘야 한다.
        }
        
        let itemsA = [3.3, 4.0, 5.0, 2.0, 3.6, 4.8]
        let itemsB = [2.3, 2.0, 1.3]

        // just : element를 하나만 받을 수 있음
        Observable.just(itemsA)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just completed")
            } onDisposed: {
                print("just disposed")
            }
            .disposed(by: disposeBag)
        
        // of : 가변 매개변수로, 여러개의 element를 받을 수 있음
        Observable.of(itemsA, itemsB)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of completed")
            } onDisposed: {
                print("of disposed")
            }
            .disposed(by: disposeBag)
        
        // from : 배열의 각 element를 리턴
        Observable.from(itemsA)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from completed")
            } onDisposed: {
                print("from disposed")
            }
            .disposed(by: disposeBag)
    }
    
    func setSign() {
        // combineLatest : 변화가 생길 때마다 감지
        // 텍스트필드1(Observable), 텍스트필드2(Observable) -> 레이블(Observer, bind)
        Observable.combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty) { value1, value2 in
            "이름은 \(value1)이고, 이메일은 \(value2)입니다"
        }
        .bind(to: simpleLabel.rx.text)
        .disposed(by: disposeBag)
        
        // 데이터의 흐름 Stream
        signName.rx.text.orEmpty
            .map { $0.count < 4 }
            .bind(to: signEmail.rx.isHidden, signButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty
            .map { $0.count > 4 }
            .bind(to: signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signButton.rx.tap
            .withUnretained(self) // ARC
            .subscribe { vc, _ in // vc = [weak self]
                vc.showAlert()
            }
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "가입완료", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func setSwitch() {
        Observable.just(false)
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }
    
    func setTableView() {
        simpleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
        
        items
            .bind(to: simpleTableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                return cell
            }
            .disposed(by: disposeBag)
        
        simpleTableView.rx.modelSelected(String.self)
            .map { data in
                "\(data)를 클릭했습니다"
            }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setPickerView() {
        let items = Observable.just([
            "영화",
            "드라마",
            "애니메이션",
            "기타"
        ])
        
        items
            .bind(to: simplePickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        simplePickerView.rx.modelSelected(String.self)
            .map { $0.description }
            .bind(to: simpleLabel.rx.text)
        // subscribe 대신 bind 를 사용하려면 map으로 형변환을 해야 한다.
        
        //            .subscribe(onNext: { value in
        //                print(value)
        //            })
            .disposed(by: disposeBag)
    }
}
