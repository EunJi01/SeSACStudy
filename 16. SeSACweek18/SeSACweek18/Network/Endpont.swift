//
//  Endpont.swift
//  SeSACweek18
//
//  Created by 황은지 on 2022/11/02.
//

import Foundation
import Alamofire

enum SeSACAPI {
    case signup(userName: String, email: String, password: String)
    case login(email: String, password: String)
    case profile
}

extension SeSACAPI {
    var url: URL {
        switch self {
        case .signup:
            return URL(string: "http://api.memolease.com/api/v1/users/signup")!
        case .login:
            return URL(string: "http://api.memolease.com/api/v1/users/login")!
        case .profile:
            return URL(string: "http://api.memolease.com/api/v1/users/me")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup, .login:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .profile:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)" // propertyWrapper 5.1
            ]
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .signup(let userName, let email, let password):
            return [
                "userName": userName,
                "email": email,
                "password": password
            ]
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        default: return ["": ""]
        }
    }
}
