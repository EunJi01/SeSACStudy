//
//  RandomPhotosViewController.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/29.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class RandomPhotosViewController: UIViewController {
    
    lazy var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: createLayout())
    let reloadButton = UIBarButtonItem(title: "reload", style: .plain, target: RandomPhotosViewController.self, action: nil)
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, RandomPhotos>!
    
    let viewModel = RandomPhotosViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.topItem?.title = "랜덤 이미지"
        navigationItem.rightBarButtonItem = reloadButton
        
        setConstraints()
        configureDatasource()
        bind()
    }
    
    func bind() {
        viewModel.requestRandomPhotos()

        viewModel.randomPhotos
            .withUnretained(self)
            .subscribe { vc, photo in
                var snapshot = NSDiffableDataSourceSnapshot<Int, RandomPhotos>()
                snapshot.appendSections([0])
                snapshot.appendItems([photo])
                vc.dataSource.apply(snapshot)
            } onError: { error in
                print("====error: \(error)")
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        reloadButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.requestRandomPhotos()
            }
            .disposed(by: disposeBag)
    }
    
    func setConstraints() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension RandomPhotosViewController {
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.backgroundColor = .systemGray5
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDatasource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, RandomPhotos> { cell, indexPath, itemIdentifier in

            var content = cell.defaultContentConfiguration()
            content.text = itemIdentifier.id
            content.secondaryText = "\(itemIdentifier.likes)"
            
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration , for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}
