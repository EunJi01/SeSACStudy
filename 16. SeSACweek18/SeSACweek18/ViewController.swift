//
//  ViewController.swift
//  SeSACweek18
//
//  Created by 황은지 on 2022/11/02.
//

import UIKit
import RxSwift

class ViewController: UIViewController { // 프로필
    
    @IBOutlet weak var label: UILabel!
    
    let viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.profile // <Single>, Syntax Sugar
            .withUnretained(self)
            .subscribe { vc, value in
                vc.label.text = value.user.email
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        // subscribe, bing, drive
        // driver vs signal
        
        viewModel.getProfile()
        checkCOW()
    }
    
    func checkCOW() { // Copy On Write: 성능 최적화를 위해 리소스 공유
        var test = "lia"
        address(&test) // inout 매개변수
        
        var test2 = test
        address(&test2)
        
        test2 = "sesac"
        address(&test)
        address(&test2)
        
        print("=================")
        
        var array = Array(repeating: "A", count: 100) // Array, Dictionary, Set == Collection Type
        address(&array)
        
        var newArray = array // 실제로 복사 안함! 원본을 공유하고 있음 => 메모리주소 동일
        address(&newArray)
        
        newArray[0] = "B" // 이 때, 값이 변경되므로 메모리주소가 변경됨
        address(&array)
        address(&newArray)
        
        print("=================")
        
        print(test[2])
        print(test2[4])
        
        print(array[safe: 99])
        print(array[safe: 300])
        
        let phone = Phone()
        print(phone.numbers[2])
        print(phone[2])
    }
    
    func address(_ value: UnsafeRawPointer) {
        let address = String(format: "%p", Int(bitPattern: value))
        print(address)
    }
}

