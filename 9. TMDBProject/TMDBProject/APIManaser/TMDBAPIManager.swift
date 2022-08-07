//
//  TMDBAPIManater.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/06.
//

import Foundation

import Alamofire
import SwiftyJSON

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    private init() {}
    
    typealias completionHadndler = ([MovieValue]) -> Void
    
    func requestContentsData(movieNumber: Int, movieList: [MovieValue], completionHandler: @escaping completionHadndler) {
        
        let url = endPoint.tmdbURL + "api_key=" + APIKey.TMDB
        var newMovieList: [MovieValue] = []
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                for i in movieList.count ..< movieNumber {
                    let j = json["results"][i]
                    
                    let id = j["id"].intValue
                    let title = j["title"].stringValue
                    let image = endPoint.tmdbImageURL + j["poster_path"].stringValue
                    let overview = j["overview"].stringValue
                    let release = j["release_date"].stringValue
                    let grade = j["vote_average"].doubleValue
                    let backdrop = endPoint.tmdbImageURL + j["backdrop_path"].stringValue
                    let genreId = j["genre_ids"][0].intValue
                    
                    let data = MovieValue(id: id, title: title, image: image, overview: overview, release: release, grade: grade, backdrop: backdrop, genreId: genreId)

                    newMovieList.append(data)
                    print(title)
                }
               
                completionHandler(newMovieList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestGenreData(completionHandler: @escaping ([Int: String]) -> Void) {
        let url = endPoint.tmdbGenreURL + "api_key=" + APIKey.TMDB + "&language=ko-KR"
        var genreDictionary: [Int: String] = [:]
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                for i in json["genres"].arrayValue {
                    let genreId = i["id"].intValue
                    let genre = i["name"].stringValue
                    genreDictionary.updateValue(genre, forKey: genreId)
                }
                
                completionHandler(genreDictionary)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

