//
//  CastViewController.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/04.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class CastViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backdropPosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var movieData: MovieValue?
    var castList: [CastValue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        requestCredits()
        designView()
        
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "MY MEDIA"
    }
    
    func requestCredits() {
        
        let url = "\(endPoint.tmdbCastURL)/\((movieData?.id)!)/credits?api_key=\(APIKey.TMDB)&language=ko-KR"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                for cast in json["cast"].arrayValue {
                    let name = cast["name"].stringValue
                    let profileImage = endPoint.tmdbImageURL + cast["profile_path"].stringValue
                    let character = cast["character"].stringValue
                    
                    let data = CastValue(name: name, profileImage: profileImage, character: character)
                    self.castList.append(data)
                }
                
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func designView() {
        guard let movieData = movieData else { return }
        
        let imageURL = URL(string: movieData.image)
        posterImageView.kf.setImage(with: imageURL)
        let backdropImageURL = URL(string: movieData.backdrop)
        backdropPosterImageView.kf.setImage(with: backdropImageURL)
        
        movieTitleLabel.text = movieData.title
        
        view.backgroundColor = CustomColor.apricot
    }
}

extension CastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
        
        let imageURL = URL(string: castList[indexPath.row].profileImage)
        
        cell.castImageView.kf.setImage(with: imageURL)
        cell.castNameLabel.text = castList[indexPath.row].name
        cell.castPartLabel.text = castList[indexPath.row].character
        
        cell.castImageView.layer.cornerRadius = 10
        cell.castPartLabel.textColor = .darkGray
        cell.backgroundColor = CustomColor.apricot
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}