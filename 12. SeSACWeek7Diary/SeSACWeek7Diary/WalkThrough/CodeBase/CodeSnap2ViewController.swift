//
//  CodeSnap2ViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/17.
//

import UIKit
import SnapKit

class CodeSnap2ViewController: UIViewController {

    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [redView, blackView].forEach {
            view.addSubview($0)
        }
        
        blackView.addSubview(yellowView)
        // contanerView, stackView 는 addSubview가 아닌 다른 메서드 사용
        
        redView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
        }
        
        // RTL (Right To Left)
        blackView.snp.makeConstraints { make in
            make.edges.equalTo(redView).inset(50) //.offset(50)
        }
    }
}
