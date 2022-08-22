//
//  WriteViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/19.
//

import UIKit
import RealmSwift

class WriteViewController: BaseViewController {
    
    var mainView = WriteView()
    let localRealm = try! Realm() // Realm 테이블에 데이터를 CRUD할 때, Realm 테이블 경로에 접근
    
    // viewDidLoad보다 먼저 호출
    override func loadView() { // super.loadView 호출 금지
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
    }
    
    override func configure() {
        mainView.titleTextField.addTarget(self, action: #selector(titleTextFieldTapped(_:)), for: .editingDidEndOnExit)
        mainView.imageSearchButton.addTarget(self, action: #selector(imageSearchButtonTapped), for: .touchUpInside)
        mainView.sampleButton.addTarget(self, action: #selector(sampleButtonTapped), for: .touchUpInside)
    }
    
    // Realm Create Sample
    @objc func sampleButtonTapped() {
        let task = UserDiary(diaryTitle: mainView.titleTextField.text!, diaryContent: mainView.contentTextView.text!, diaryDate: Date(), regdate: Date(), photo: nil) // => Record
        
        try! localRealm.write {
            localRealm.add(task) // Create
            print("Realm Succeed")
            dismiss(animated: true)
        }
    }
    
    @objc func imageSearchButtonTapped() {
        let vc = ImageSearchViewController()
        vc.selectButtonActionHandler = { value in
            if let image = value {
                let url = URL(string: image)
                self.mainView.photoImageView.kf.setImage(with: url)
            } else {
                self.showAlertMessage(title: "이미지를 선택해주세요!", button: "확인")
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleTextFieldTapped(_ textField: UITextField) {
        guard let text = textField.text, text.count > 0 else {
            showAlertMessage(title: "제목을 입력해주세요", button: "확인")
            return
        }
    }
}
