//
//  TMDBAPIManager.swift
//  SeSACWeek6
//
//  Created by 황은지 on 2022/08/10.
//

import Foundation

import Alamofire
import SwiftyJSON

/*
 TMDB API
 https://developers.themoviedb.org/3/tv-seasons/get-tv-season-details
 */

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    private init() {}
    
    let tvList = [
        ("환혼", 135157),
        ("이상한 변호사 우영우", 197067),
        ("인사이더", 135655),
        ("미스터 션사인", 75820),
        ("스카이 캐슬", 84327),
        ("사랑의 불시착", 94796),
        ("이태원 클라스", 96162),
        ("호텔 델루나", 90447)
    ]
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
    
    func callRequest(query: Int, completionHandler: @escaping ([String]) -> () ) {
        print(#function)
        let url = "https://api.themoviedb.org/3/tv/\(query)/season/1?api_key=\(APIKey.tmdb)&language=ko-KR"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                // json still_path > [String]
                
                //                var stillArray: [String] = []
                //                for list in json["episodes"].arrayValue {
                //                    let value = list["still_path"].stringValue
                //                    stillArray.append(value)
                //                }
                
                let value = json["episodes"].arrayValue.map { $0["still_path"].stringValue }
                
                //dump(stillArray) // print vs dump => dump가 더 예쁘게 나온다
                completionHandler(value)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestImage(completionHandler: @escaping ([[String]]) -> ()) {
        
        var posterList: [[String]] = []
        
        // 나~~~~중에 배울 것 : async/await (iOS13 이상에서 등장한 비동기 구문)
        TMDBAPIManager.shared.callRequest(query: tvList[0].1) { value in
            posterList.append(value)

            TMDBAPIManager.shared.callRequest(query: self.tvList[1].1) { value in
                posterList.append(value)

                TMDBAPIManager.shared.callRequest(query: self.tvList[2].1) { value in
                    posterList.append(value)
                   
                    TMDBAPIManager.shared.callRequest(query: self.tvList[3].1) { value in
                        posterList.append(value)
                     
                        TMDBAPIManager.shared.callRequest(query: self.tvList[4].1) { value in
                            posterList.append(value)
                           
                            TMDBAPIManager.shared.callRequest(query: self.tvList[5].1) { value in
                                posterList.append(value)
                                
                                TMDBAPIManager.shared.callRequest(query: self.tvList[6].1) { value in
                                    posterList.append(value)
                                    
                                    TMDBAPIManager.shared.callRequest(query: self.tvList[7].1) { value in
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
    
    func requestEpisodeImage() {
        
        // completionHandler를 반복문으로 구성할 경우 문제점
        // 1. 순서 보장 X // 2. 언제 끝날 지 모름 // 3. Limit (ex. 1초 5번 Block)
//        for item in tvList {
//            TMDBAPIManager.shared.callRequest(query: item.1) { stillPath in
//                dump(stillPath)
//            }
//        }
        
        let id = tvList[7].1 // 90447
        
        TMDBAPIManager.shared.callRequest(query: id) { stillPath in
            dump(stillPath)
            
            TMDBAPIManager.shared.callRequest(query: self.tvList[5].1) { stillPath in
                dump(stillPath)
            }
        }
    }
}
