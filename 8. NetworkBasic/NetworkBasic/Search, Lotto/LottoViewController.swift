//
//  LottoViewController.swift
//  NetworkBasic
//
//  Created by 황은지 on 2022/07/28.
//

import UIKit
// 1. 임포트
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
//    @IBOutlet weak var lottoPickerView: UIPickerView!
    @IBOutlet var winningNumberLabelCollection: [UILabel]!
    
    var lottoPickerView = UIPickerView()
    // 코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있음
    
    let numberList: [Int] = Array(1...1025).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.textContentType = .oneTimeCode // 인증번호
        
        numberTextField.inputView = lottoPickerView
        numberTextField.tintColor = .clear

        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        requestLotto(number: 1025)
    }
    
    func requestLotto(number: Int) {
        // AF: 200~299 status code 301
        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let bonus = json["bnusNo"].stringValue
                print(bonus)
                
                let date = json["drwNoDate"].stringValue
                print(date)
                
                self.numberTextField.text = date
                
                self.winningNumberLabelCollection[6].text = bonus
                for i in 1...6 {
                    let num = json["drwtNo\(i)"].stringValue
                    self.winningNumberLabelCollection[i - 1].text = num
                }

            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LottoViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row])
        //numberTextField.text = "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}

