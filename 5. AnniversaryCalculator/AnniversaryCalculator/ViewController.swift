//
//  ViewController.swift
//  AnniversaryCalculator
//
//  Created by 황은지 on 2022/07/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var resultDaysCollection: [UILabel]!
    @IBOutlet var anniversaryCollection: [UILabel]!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var imageViewCollection: [UIImageView]!
    @IBOutlet var shadowViewCollection: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designLabel()
        designImageView()
        designDatePicker()
        designShadow()
        
        // 테스트용
        anniversaryCollection[0].text = "2020년 7월 16일"
    }
    
    // 레이블 디자인
    func designLabel() {
        for days in resultDaysCollection {
            days.font = .boldSystemFont(ofSize: 25)
            days.textColor = .white
        }
        
        for anniversary in anniversaryCollection {
            anniversary.font = .systemFont(ofSize: 17)
            anniversary.textColor = .white
            anniversary.textAlignment = .center
            anniversary.numberOfLines = 2
        }
    }
    
    // 이미지뷰 디자인
    func designImageView() {
        for i in 0...3 {
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
}
