//
//  ViewController.swift
//  SeSACWeek9
//
//  Created by 황은지 on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lottoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet { // 단방향 바인딩
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var viewModel = PersonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let example = User("고래밥")
        example.bind { name in
            print("이름이 \(name)으로 바뀌었습니다.")
        }
        example.value = "칙촉"
        
        let sample = User([1, 2, 3])
        sample.bind { value in
            print("list changed", value)
        }
        sample.value = [9, 8, 7]
        
//        LottoAPIManager.requestLotto(drwNo: 1011) { lotto, error in
//            guard let lotto = lotto else { return }
//            self.lottoLabel.text = lotto.drwNoDate
//        }
        
        viewModel.fetchPerson(query: "Kim")
        viewModel.list.bind { person in
            print("viewController bind")
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.knownForDepartment
        return cell
    }
}
