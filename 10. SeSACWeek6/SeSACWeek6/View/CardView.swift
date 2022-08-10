//
//  CardView.swift
//  SeSACWeek6
//
//  Created by 황은지 on 2022/08/09.
//

import UIKit

/*
 xml Interface Builder
 1. UIView Custom Class
 2. File's owner => 자유도가 높다
 */

/*
 View:
 - 인터페이스 빌더 UI 초기화 구문 : required init?
    - 프로토콜 초기화 구문 : required > 초기화 구문이 프로토콜로 명세되어 있음
 - 코드 UI 초기화 구문 : override init
 */

protocol A {
    func example()
    init()
}

class CardView: UIView {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        //view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        self.addSubview(view)
        
        // 카드뷰를 인퍼테이스 빌더 기반으로 만들고, 레이아웃도 설정했는데 false가 아닌 true로 나온다
        // self.addSubview 를 통해 코드 기반으로 뷰를 추가했기 때문
        print(view.translatesAutoresizingMaskIntoConstraints)
    }
}
