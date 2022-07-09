//
//  SearchViewController.swift
//  newlyCoinedWord
//
//  Created by 황은지 on 2022/07/09.
//

import UIKit

class SearchViewController: UIViewController {
    
    let newlyCoinedWordDic: [String: String] = [
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

    }
    
    func designSearchView() {
        
        let searchViewList: [UIView] = [searchTextField, searchButton]
        
        for item in searchViewList {
            item.layer.borderWidth = 3
            item.layer.borderColor = UIColor.black.cgColor
        }
        
        searchButton.backgroundColor = .black
        searchButton.tintColor = .white
    }
    
    func designNewlyCoinedWordButton() {
        for item in newlyCoinedWordButtonCollection {
            item.layer.borderWidth = 1
            item.layer.borderColor = UIColor.gray.cgColor
            item.tintColor = .gray
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        if !(searchTextField.text?.isEmpty)! {
            resultLabel.text = newlyCoinedWordDic[searchTextField.text!]
        }
    }
}
