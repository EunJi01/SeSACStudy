//
//  MainView.swift
//  Movie
//
//  Created by 황은지 on 2022/08/19.
//

import UIKit
import SnapKit

class MainView: BaseView {
    
    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        return view
    }()
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "명량")
        return view
    }()

    let nButton: UIButton = {
        let view = WhiteButton()
        view.setTitle("N", for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 40)
        return view
    }()
    
    let tvButton: UIButton = {
        let view = WhiteButton()
        view.setTitle("TV프로그램", for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return view
    }()
    
    let movieButton: UIButton = {
        let view = WhiteButton()
        view.setTitle("영화", for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return view
    }()
    
    let likeButton: UIButton = {
        let view = WhiteButton()
        view.setTitle("내가 찜한 콘텐츠", for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return view
    }()
    
    let likeImageButton: UIButton = {
        let view = WhiteButton()
        view.setImage(UIImage(systemName: "checkmark.rectangle"), for: .normal)
        return view
    }()
    
    let playButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "play.fill"), for: .normal)
        view.setTitle("  재생", for: .normal)
        view.backgroundColor = .white
        view.setTitleColor(UIColor.black, for: .normal)
        view.tintColor = .black
        view.layer.cornerRadius = 5
        return view
    }()
    
    let infoButton: UIButton = {
        let view = WhiteButton()
        view.setImage(UIImage(systemName: "info.circle"), for: .normal)
        return view
    }()
    
    let thumbnail1: UIImageView = {
        let view = CircleImageView(image: UIImage(named: "겨울왕국2"))
        return view
    }()
    
    let thumbnail2: UIImageView = {
        let view = CircleImageView(image: UIImage(named: "알라딘"))
        return view
    }()
    
    let thumbnail3: UIImageView = {
        let view = CircleImageView(image: UIImage(named: "아바타"))
        return view
    }()
    
    let likeLabel: UILabel = {
        let view = UILabel()
        view.text = "내가 찜한 컨텐츠"
        view.font = .systemFont(ofSize: 12)
        view.textColor = .white
        return view
    }()
    
    let infoLabel: UILabel = {
        let view = UILabel()
        view.text = "정보"
        view.font = .systemFont(ofSize: 12)
        view.textColor = .white
        return view
    }()
    
    let thumbnailLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "미리보기"
        view.font = .boldSystemFont(ofSize: 17)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "customGray")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [posterImageView, backgroundImageView, nButton, tvButton, movieButton, likeButton, likeImageButton, playButton, infoButton, thumbnail1, thumbnail2, thumbnail3, thumbnailLabel, likeLabel, infoLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
    
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self).inset(270)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self).inset(200)
        }
        
        nButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(44)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.leadingMargin.equalTo(self)
        }
        
        tvButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(100)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.leadingMargin.equalTo(nButton.snp_trailingMargin).offset(40)
        }
        
        movieButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(40)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.leadingMargin.equalTo(tvButton.snp_trailingMargin).offset(40)
        }
        
        likeButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(120)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.leadingMargin.equalTo(movieButton.snp_trailingMargin).offset(40)
        }
        
        playButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(100)
            make.bottomMargin.equalTo(thumbnail2.snp.topMargin).inset(-80)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        likeImageButton.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.bottomMargin.equalTo(likeLabel.snp_topMargin).offset(-12)
            make.trailingMargin.equalTo(playButton.snp_leadingMargin).offset(-80)
        }
        
        infoButton.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.leadingMargin.equalTo(playButton.snp_trailingMargin).offset(80)
            make.bottomMargin.equalTo(infoLabel.snp_topMargin).offset(-12)
        }
        
        thumbnail2.snp.makeConstraints { make in
            make.height.width.equalTo(120)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(self.snp.centerX)
        }

        thumbnail1.snp.makeConstraints { make in
            make.height.width.equalTo(120)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(self).inset(12)
        }
        
        thumbnail3.snp.makeConstraints { make in
            make.height.width.equalTo(120)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(self).inset(12)
        }
        
        thumbnailLabel.snp.makeConstraints { make in
            make.bottomMargin.equalTo(thumbnail1.snp.topMargin).offset(-28)
            make.leading.equalTo(self).inset(12)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(playButton)
            make.centerX.equalTo(likeImageButton.snp.centerX)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(playButton)
            make.centerX.equalTo(infoButton.snp.centerX)
        }
    }
}
