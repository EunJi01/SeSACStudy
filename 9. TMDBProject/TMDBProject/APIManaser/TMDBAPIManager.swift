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
    
    let movieList = [
        ("An Egg Rescue", 573164),
        ("Elvis", 614934),
        ("Ishq Vishk", 41901),
        ("Jurassic World Dominion", 507086),
        ("The Gray Man", 725201),
        ("The Black Phone", 756999),
        ("Quicksand", 871693)
    ]
    
    typealias completionHadndler = ([MovieValue]) -> Void
    
    func requestContentsData(movieNumber: Int, movieList: [MovieValue], page: Int, completionHandler: @escaping completionHadndler) {
        
        let url = EndPoint.tmdbURL + "api_key=" + APIKey.TMDB + "&page=\(page)"
        var newMovieList: [MovieValue] = []
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                for j in json["results"].arrayValue {
                    
                    let id = j["id"].intValue
                    let title = j["title"].stringValue
                    let image = EndPoint.tmdbImageURL + j["poster_path"].stringValue
                    let overview = j["overview"].stringValue
                    let release = j["release_date"].stringValue
                    let grade = j["vote_average"].doubleValue
                    let backdrop = EndPoint.tmdbImageURL + j["backdrop_path"].stringValue
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
        let url = EndPoint.tmdbGenreURL + "api_key=" + APIKey.TMDB + "&language=ko-KR"
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
    
    func requestRecommendations(movieId: Int, completionHandler: @escaping ([String]) -> () ) {
        let url = EndPoint.tmdbrecommendations + "\(movieId)/recommendations?api_key=" + APIKey.TMDB + "&language=ko-KR"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                let value = json["results"].arrayValue.map { $0["poster_path"].stringValue }
                completionHandler(value)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestImage(completionHandler: @escaping ([[String]]) -> () ) {
        
        var posterList: [[String]] = []
        
        TMDBAPIManager.shared.requestRecommendations(movieId: movieList[0].1) { value in
            posterList.append(value)
            
            TMDBAPIManager.shared.requestRecommendations(movieId: self.movieList[1].1) { value in
                posterList.append(value)
                
                TMDBAPIManager.shared.requestRecommendations(movieId: self.movieList[2].1) { value in
                    posterList.append(value)
                    
                    TMDBAPIManager.shared.requestRecommendations(movieId: self.movieList[3].1) { value in
                        posterList.append(value)
                        
                        TMDBAPIManager.shared.requestRecommendations(movieId: self.movieList[4].1) { value in
                            posterList.append(value)
                            
                            TMDBAPIManager.shared.requestRecommendations(movieId: self.movieList[5].1) { value in
                                posterList.append(value)
                                
                                TMDBAPIManager.shared.requestRecommendations(movieId: self.movieList[6].1) { value in
                                    posterList.append(value)
                                    completionHandler(posterList)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

