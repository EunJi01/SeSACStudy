//
//  ViewController.swift
//  AnniversaryCalculator
//
//  Created by 황은지 on 2022/07/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var resultDaysLabelCollection: [UILabel]!
    @IBOutlet var anniversaryLabelCollection: [UILabel]!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var imageViewCollection: [UIImageView]!
    @IBOutlet var shadowViewCollection: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designLabel()
        designImageView()
        designDatePicker()
        designShadow()
        
        for number in 0...resultDaysLabelCollection.count - 1 {
            resultDaysLabelCollection[number].text = UserDefaults.standard.string(forKey: "\(number)")
        }
    }
    
    // 레이블 디자인
    func designLabel() {
        for days in resultDaysLabelCollection {
            days.font = .boldSystemFont(ofSize: 25)
            days.textColor = .white
        }
        
        for anniversary in anniversaryLabelCollection {
            anniversary.font = .systemFont(ofSize: 17)
            anniversary.textColor = .white
            anniversary.textAlignment = .center
            anniversary.numberOfLines = 2
        }
    }
    
    // 이미지뷰 디자인
    func designImageView() {
        for i in 0...imageViewCollection.count - 1 {
            imageViewCollection[i].layer.cornerRadius = 15
            imageViewCollection[i].contentMode = .scaleAspectFill
            imageViewCollection[i].image = UIImage(named: "\(i)")
        }
    }
    
    // 섀도우 디자인
    func designShadow() {
        for item in shadowViewCollection {
            item.layer.masksToBounds = false
            item.layer.shadowRadius = 6
            item.layer.shadowColor = UIColor.black.cgColor
            item.layer.shadowOpacity = 0.5
            item.layer.shadowOffset = CGSize(width: 13, height: 13)
            item.backgroundColor = .white
        }
    }
    
    // 데이트피커 디자인
    func designDatePicker() {
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.preferredDatePickerStyle = .wheels
        }
    }
    
    // DateFormatter: 알아보기 쉬운 날짜 + 시간대(yyyy MM dd hh:mm:ss)
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        // formatter 형식
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년MM월dd일"
        formatter.locale = Locale(identifier: "ko-KR")
        
        // 현재 한국시간
        let now = Date()
        let koreanTime = formatter.string(from: now)
        
        // 결과 확인
        let formattedDate = formatter.string(from: datePicker.date)
        print(formattedDate, koreanTime)
        
        // String을 Date로 바꾸는 코드
        let resultDate = formatter.date(from: koreanTime)
        print(resultDate!)
        // "33월 -2일, 0년" 처럼 Date Type으로 타입 변환이 불가능한 이상한 숫자가 들어올 수도 있기 때문에 옵셔널 타입이다.
        
        // 날짜 계산
        let resultDays = datePicker.calendar.dateComponents([.day], from: sender.date, to: now).day!

        let resultDaysStr = resultDays >= 0 ? "D+\(resultDays + 1)" : "D\(resultDays - 1)"

        
        // 실제 동작 - Alert 호출
        askAlert(date: formattedDate)
        
        // 저장 담당 함수
        func saveDate(number: Int) {
            anniversaryLabelCollection[number].text = formattedDate
            
            UserDefaults.standard.set(resultDaysStr, forKey: "\(number)")
            UserDefaults.standard.string(forKey: "\(number)")
            resultDaysLabelCollection[number].text = resultDaysStr

        }
        
        // 저장할건지 물어보는 Alert - 저장 함수로 넘김
        func askAlert (date: String) {
            let alert = UIAlertController(title: "\(date)", message: "몇 번째 보관함에 저장하시겠습니까?", preferredStyle: .actionSheet)
            
            let num1 = UIAlertAction(title: "1번", style: .default, handler: { _ in saveDate(number: 0) })
            let num2 = UIAlertAction(title: "2번", style: .default, handler: { _ in saveDate(number: 1) })
            let num3 = UIAlertAction(title: "3번", style: .default, handler: { _ in saveDate(number: 2) })
            let num4 = UIAlertAction(title: "4번", style: .default, handler: { _ in saveDate(number: 3) })
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            let alertActionList = [num1, num2, num3, num4, cancel]
            for i in alertActionList {
                alert.addAction(i)
            }
            
            present(alert, animated: true, completion: nil)
        }
    }
}

