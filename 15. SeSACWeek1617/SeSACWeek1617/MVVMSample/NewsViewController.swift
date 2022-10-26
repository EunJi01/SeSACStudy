//
//  NewsViewController.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/20.
//

import UIKit
import RxCocoa
import RxSwift

class NewsViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var loadButton: UIButton!
    
    var viewModel = NewsViewModel()
    var dataSource: UICollectionViewDiffableDataSource<Int, News.NewsItem>!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureDataSource()
        bindData() // bind는 configureDataSource 이후에 호출해야 한다!
    }
    
    func bindData() {
        numberTextField.rx.text.orEmpty
            .withUnretained(self)
            .bind { vc, value in
                vc.viewModel.changePageNumberFormat(text: value)
            }
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .withUnretained(self)
            .bind { vc, value in
                vc.viewModel.resetSample()
            }
            .disposed(by: disposeBag)
            
        loadButton.rx.tap
            .withUnretained(self)
            .bind { vc, value in
                vc.viewModel.loadSample()
            }
            .disposed(by: disposeBag)
        
        viewModel.pageNumber
            .withUnretained(self)
            .bind { vc, value in
                vc.numberTextField.text = value
            }
            .disposed(by: disposeBag)
        
        viewModel.sample
            .withUnretained(self)
            .bind { vc, value in
                var snapshot = NSDiffableDataSourceSnapshot<Int, News.NewsItem>()
                snapshot.appendSections([0])
                snapshot.appendItems(value)
                vc.dataSource.apply(snapshot, animatingDifferences: false)
            }
            .disposed(by: disposeBag)
    }
}

extension NewsViewController {
    func configureHierachy() { // addSubView, init, snapkit
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .lightGray
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, News.NewsItem> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.body
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
