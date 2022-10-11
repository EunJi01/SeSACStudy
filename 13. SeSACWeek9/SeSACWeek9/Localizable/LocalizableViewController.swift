//
//  LocalizableViewController.swift
//  SeSACWeek9
//
//  Created by 황은지 on 2022/09/06.
//

import UIKit
//import CoreLocation

import MessageUI // 메일로 문의 남기기 1

/*
 리뷰 남기기 -> 리뷰 얼럿: 1년에 한 디바이스당 3회 제한 // 1주일 이상 사용, 일기 10개 이상 등록 등 조건을 거는것이 적합한 형태
 SKStoreReviewController
 
 문의 남기기 -> 메일로 문의 보내기 => 디바이스 테스트, 사용자가 아이폰 메일 계정을 등록해야 가능
 */

class LocalizableViewController: UIViewController, MFMailComposeViewControllerDelegate { // 메일로 문의 남기기 2

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sampleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myLabel.text = "introduce".localized(with: "고래밥")
        inputTextField.text = "number_test".localized(number: 11)

        navigationItem.title = "navigation_title".localized
        searchBar.placeholder = "search_placeholder".localized
        inputTextField.placeholder = "main_age_textfield_placeholder".localized
        sampleButton.setTitle("common_cancel".localized, for: .normal)
        
        // SwiftGen / R.swift 등을 사용하면 키도 편하게 사용할 수 있다
        
        //CLLocationManager().requestWhenInUseAuthorization() // 권한 요청 창 띄우기
    }
    
    func sendMail() { // 메일로 문의 남기기 3
        if MFMailComposeViewController.canSendMail() { // 사용자 메일이 있는지 체크
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["lia@lia.com"]) // 문의를 받을 메일 주소
            mail.setSubject("고래밥 다이어리 문의사항 -") // 메일의 기본 제목 설정
            mail.mailComposeDelegate = self
            
            self.present(mail, animated: true)
        } else {
            // alert. 메일 등록을 해주시거나, lia@lia.com 으로 문의 부탁드립니다
            print("ALERT")
        }
    }
    
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) { // 메일로 문의 남기기 3.5 (UX 측면의 옵션)
//
//        switch result {
//        case .cancelled: // 취소
//
//        case .saved: // 임시저장
//
//        case .sent: // 발송
//
//        case .failed: // 실패
//
//        }
//        controller.dismiss(animated: true)
//    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with: String) -> String {
        return String(format: self.localized, with)
    }
    
    // 오버로드, 제네릭 사용 가능
    func localized(number: Int) -> String {
        return String(format: self.localized, number)
    }
}
