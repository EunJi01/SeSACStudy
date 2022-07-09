//
//  SearchViewController.swift
//  newlyCoinedWord
//
//  Created by 황은지 on 2022/07/09.
//

import UIKit

class SearchViewController: UIViewController {
    
    var newlyCoinedWordDic: [String: String] = [
        "진순": "진라면 순한맛",
        "다꾸": "다이어리 꾸미기",
        "스불재": "스스로 불러온 재앙",
        "점메추": "점심 메뉴 추천",
        "주불": "주소 불러",
        "택노": "택시 노예",
        "모청": "모바일 청첩장",
        "갈비": "갈수록 비호감"
    ]
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet var newlyCoinedWordButtonCollection: [UIButton]!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designSearchView()
        designNewlyCoinedWordButton()
        searchButtonTapped(searchButton)
        
        resultLabel.font = .boldSystemFont(ofSize: 20)

    }
    
    // 검색창, 검색버튼 레이아웃
    func designSearchView() {
        
        let searchViewList: [UIView] = [searchTextField, searchButton]
        
        for item in searchViewList {
            item.layer.borderWidth = 3
            item.layer.borderColor = UIColor.black.cgColor
        }
        
        searchTextField.placeholder = "어떤 신조어가 궁금하신가요?"
        searchButton.backgroundColor = .black
        searchButton.tintColor = .white
    }
    
    // 신조어 해쉬태그 버튼 레이아웃
    func designNewlyCoinedWordButton() {
        for item in newlyCoinedWordButtonCollection {
            item.layer.borderWidth = 2
            item.layer.borderColor = UIColor.darkGray.cgColor
            item.tintColor = .darkGray
            item.layer.cornerRadius = 12
        }
    }
    
    // 검색버튼 액션
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        if !(searchTextField.text?.isEmpty)! {
            resultLabel.text = newlyCoinedWordDic[searchTextField.text!]
            }
        
        let newlyCoinedWord = newlyCoinedWordDic.keys.shuffled()
        for (button, word) in zip(newlyCoinedWordButtonCollection, newlyCoinedWord) {
            button.setTitle(word, for: .normal)
        }
    }
    
    // 탭제스쳐 액션
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 리턴키 액션
    @IBAction func searchTextFieldReturn(_ sender: UITextField) {
        searchButtonTapped(searchButton)
    }
}
