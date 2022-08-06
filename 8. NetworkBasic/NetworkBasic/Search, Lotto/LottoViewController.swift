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
    
    lazy var drwNumberList: [Int] = Array(1...currentDrwNo()).reversed()
    var winningList: [Int: [Int]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.textContentType = .oneTimeCode // 인증번호
        
        numberTextField.inputView = lottoPickerView
        numberTextField.tintColor = .clear

        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        requestLotto(number: currentDrwNo())
    }
    
    func currentDrwNo() -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let firstDate = formatter.date(from: "2002-12-07 21:00")!
        
        let dateInterval = Calendar.current.dateComponents([.day], from: firstDate, to: Date()).day!
        print(dateInterval)
        let currentDrwNo = 1 + dateInterval / 7
        
        print(currentDrwNo)
        return currentDrwNo
    }
    
    func requestLotto(number: Int) {
        // AF: 200~299 status code 301
        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseData { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                var winningNo: [String] = []
                
                let bonus = json["bnusNo"].stringValue
                let date = json["drwNoDate"].stringValue

                self.numberTextField.text = date
                self.winningNumberLabelCollection[6].text = bonus
                
                winningNo.append(date)
                for i in 1...6 {
                    let num = json["drwtNo\(i)"].stringValue
                    winningNo.append(num)
                    self.winningNumberLabelCollection[i - 1].text = num
                }
                winningNo.append(bonus)

                UserDefaults.standard.set(winningNo, forKey: "\(number)")

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
        return drwNumberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let winningNumbers = UserDefaults.standard.array(forKey: "\(drwNumberList[row])")
        
        if winningNumbers == nil {
            requestLotto(number: drwNumberList[row])
            print("서버 요청됨")
        } else {
            print("서버 요청 안함")
            guard let winningNo = winningNumbers as? [String] else { return }
            for i in 1...7 {
                winningNumberLabelCollection[i - 1].text = winningNo[i]
            }
            numberTextField.text = winningNo[0]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(drwNumberList[row])회차"
    }
}
