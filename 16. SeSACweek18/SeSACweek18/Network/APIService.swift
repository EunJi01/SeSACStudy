//
//  APIService.swift
//  SeSACweek18
//
//  Created by 황은지 on 2022/11/02.
//

import Foundation
import Alamofire

struct Login: Codable {
    let token: String
}

struct Profile: Codable {
    let user: User
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}

class APIService {
    func signup(userName: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        let api = SeSACAPI.signup(userName: userName, email: email, password: password)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            print(response)
            print((response.response?.statusCode)!)
            
            switch response.result {
            case .success(_):
                print("회원가입 성공")
                completion(true)
            case .failure(_):
                print("회원가입 실패")
                completion(false)
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let api = SeSACAPI.login(email: email, password: password)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) { response in
                
            switch response.result {
            case .success(let data):
                print("로그인 성공")
                completion(true)
                print(data.token)
                UserDefaults.standard.set(data.token, forKey: "token")
            case .failure(_):
                print("로그인 실패")
                completion(false)
                print((response.response?.statusCode)!)
            }
        }
    }
    
    func profile(completion: @escaping (User?, Error?) -> Void) {
        let api = SeSACAPI.profile
        
        AF.request(api.url, method: .get, headers: api.headers)
            .responseDecodable(of: Profile.self) { response in
                
                switch response.result {
                case .success(let data):completion(data.user, nil)
                case .failure(let error): completion(nil, error)
                }
            }
    }
}
