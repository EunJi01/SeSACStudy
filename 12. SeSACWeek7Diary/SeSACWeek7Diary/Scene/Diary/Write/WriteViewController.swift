//
//  WriteViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/19.
//

import UIKit
import RealmSwift

protocol SelectImageDelegate {
    func sendImageData(Image: UIImage)
}

class WriteViewController: BaseViewController {
    
    var mainView = WriteView()
    let localRealm = try! Realm() // Realm 테이블에 데이터를 CRUD할 때, Realm 테이블 경로에 접근
    var imageURL: String?
    
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
        mainView.imageSearchButton.menu = menu()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    // Realm + 이미지 도큐먼트 저장
    @objc func saveButtonTapped() {
        guard let title = mainView.titleTextField.text, title != "" else { // else 실행안됨
            showAlertMessage(title: "제목을 입력해주세요", button: "확인")
            return
        }

        let task = UserDiary(diaryTitle: title, diaryContent: mainView.contentTextView.text!, diaryDate: Date(), regdate: Date(), photo: nil) // => Record
        
        do {
            try localRealm.write {
                localRealm.add(task)
            }
        } catch let error {
            print(error)
        }
        
        if let image = mainView.photoImageView.image {
            saveImageToDocument(fileName: "\(task.objectID).jpg", image: image)
        }
        
        dismiss(animated: true)
    }
    
    @objc func menu() -> UIMenu {
        let menuItems = [
                UIAction(title: "사진 촬영하기", image: nil, handler: { _ in self.cameraButtonTapped() }),
                UIAction(title: "갤러리에서 선택하기", image: nil, handler: { _ in self.galleryButtonTapped() }),
                UIAction(title: "사진 검색하기", image: nil, handler: { _ in self.imageSearchButtonTapped() })
            ]

        let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        return menu
    }
    
    @objc func cameraButtonTapped() {
        print(#function)
    }
    
    @objc func galleryButtonTapped() {
        print(#function)
    }
    
    @objc func imageSearchButtonTapped() {
        let vc = ImageSearchViewController()
        vc.delegate = self
        transition(ImageSearchViewController(), transitionStyle: .presentNavigation)
    }
    
    @objc func titleTextFieldTapped(_ textField: UITextField) {
        guard let text = textField.text, text.count > 0 else {
            showAlertMessage(title: "제목을 입력해주세요", button: "확인")
            return
        }
    }
}

extension WriteViewController:SelectImageDelegate {
    // 선택 버튼을 눌렀을 때 실행되도록
    func sendImageData(Image: UIImage) {
        mainView.photoImageView.image = Image
        print(#function)
    }
}
