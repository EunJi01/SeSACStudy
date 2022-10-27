//
//  DetailsViewController.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController {
    
    var id = ""
    let idLbabel = UILabel()
    let descriptionLabel = UILabel()
    let likesLabel = UILabel()
    
    let viewModel = DetailsViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfigure()
        bindData()
        
        viewModel.requestPhotoDetails(id: id)
    }
    
    func setConfigure() {
        view.backgroundColor = .white
        descriptionLabel.numberOfLines = 0
        
        [idLbabel, descriptionLabel, likesLabel].forEach {
            view.addSubview($0)
        }
        
        idLbabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(idLbabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(idLbabel)
        }
        
        likesLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(idLbabel)
        }
    }
    
    func bindData() {
        viewModel.details
            .withUnretained(self)
            .subscribe { vc, details in
                vc.idLbabel.text = details.id
                vc.descriptionLabel.text = details.description
                vc.likesLabel.text = "\(details.likes ?? 0)"
            }
            .disposed(by: disposeBag)
    }
}
