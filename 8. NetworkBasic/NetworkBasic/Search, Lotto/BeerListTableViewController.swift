//
//  BeerListTableViewController.swift
//  NetworkBasic
//
//  Created by 황은지 on 2022/08/02.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class BeerListTableViewController: UITableViewController {
    
    var beerList: [beerListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestBeerList()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerListTableViewCell.identifier) as? BeerListTableViewCell else { return UITableViewCell() }
        
        let imageURL = URL(string: beerList[indexPath.row].beerImage)
        
        cell.beerIdLabel.text = beerList[indexPath.row].beerId
        cell.beerNameLabel.text = beerList[indexPath.row].beerName
        cell.beerImageView.kf.setImage(with: imageURL)
        cell.beerDescriptionLabel.text = beerList[indexPath.row].description
        
        return cell
    }
    
    func requestBeerList() {
        
        let url = EndPoint.beerListURL
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                for beer in json.arrayValue {
                    let id = beer["id"].stringValue
                    let name = beer["name"].stringValue
                    let imageURL = beer["image_url"].stringValue
                    let description = beer["description"].stringValue

                    let data = beerListModel(beerId: id, beerName: name, beerImage: imageURL, description: description)
                
                    self.beerList.append(data)
                }
                
                self.tableView.reloadData()
                    
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}
