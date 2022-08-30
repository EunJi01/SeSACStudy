//
//  PersonAPIManager.swift
//  SeSACWeek9
//
//  Created by 황은지 on 2022/08/30.
//

import Foundation

class PersonAPIManager {
    
    static func requestPerson(query: String, completion: @escaping (Person?, APIError?) -> Void) {
//        let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=\(APIKey.TMDB)&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")!
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let language = "ko-KR"
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents() // 유지보수 측면에서 좋음
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: APIKey.TMDB),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: language)
        ]
        
//        URLSession.request(endpoint: component.url!) { success, error in
//
//        }
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completion(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Person.self, from: data)
                    completion(result, nil)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
        }.resume()
    }
}
