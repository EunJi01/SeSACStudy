//
//  ValidationViewController.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/27.
//

import UIKit
import RxSwift
import RxCocoa

class ValidationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var stepButton: UIButton!
    
    let disposeBag = DisposeBag()
    let viewModel = ValidationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }
    
    func bind() {
        // Stream == Sequence
        
        // After
        let input = ValidationViewModel.Input(text: nameTextField.rx.text, tap: stepButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.text
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.validation
            .bind(to: stepButton.rx.isEnabled, validationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.validation
            .withUnretained(self)
            .bind { vc, value in
                let color: UIColor = value ? .systemPink : .lightGray
                vc.stepButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        output.tap // Input
            .bind {
                print("SHOW ALERT")
            }
            .disposed(by: disposeBag)
        
        // Before
        viewModel.validText// Output
            .asDriver()
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        let validation = nameTextField.rx.text // Input
            .orEmpty
            .map { $0.count >= 8 }
            .share()

        validation
            .bind(to: stepButton.rx.isEnabled, validationLabel.rx.isHidden)
            .disposed(by: disposeBag)

        validation
            .withUnretained(self)
            .bind { vc, value in
                let color: UIColor = value ? .systemPink : .lightGray
                vc.stepButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        stepButton.rx.tap // Input
            .bind {
                print("SHOW ALERT")
            }
            .disposed(by: disposeBag)
    }
    
    func observableVSSubject() {
        // 여러 곳에서 subscribe 하고 있을 때, 만약 API 통신이라면? 여러번 호출되기 때문에 share 이 필요
        
        let testA = stepButton.rx.tap
            .map { "안녕하세요" }
            .asDriver(onErrorJustReturn: "")
            //.share() -> drive에서는 share가 내부적으로 구현되어 있음
            
        testA
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        testA
            .drive(nameTextField.rx.text)
            .disposed(by: disposeBag)
        
        testA
            .drive(stepButton.rx.title())
            .disposed(by: disposeBag)
        
        // sampleInt = just of from 와 같은 객체를 직접 만든 것
        let sampleInt = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
        
        sampleInt.subscribe { value in
            print("sampleInt : \(value)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt : \(value)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt : \(value)")
        }
        .disposed(by: disposeBag)
        
        // Subject는 Stream을 공유
        let subjectInt = BehaviorSubject(value: 0)
        subjectInt.onNext(Int.random(in: 1...100))
        
        subjectInt.subscribe { value in
            print("subjectInt : \(value)")
        }
        .disposed(by: disposeBag)
        
        subjectInt.subscribe { value in
            print("subjectInt : \(value)")
        }
        .disposed(by: disposeBag)
        
        subjectInt.subscribe { value in
            print("subjectInt : \(value)")
        }
        .disposed(by: disposeBag)
    }
}
