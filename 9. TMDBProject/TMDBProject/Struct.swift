//
//  ResponseValue.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/03.
//

import Foundation
import UIKit

struct MovieValue {
    var id: Int
    var title: String
    var image: String
    var overview: String
    var release: String
    var grade: Double
    var backdrop: String
    var genreId: Int
}

struct CastValue {
    var name: String
    var profileImage: String
    var character: String
}

struct StoryboardName {
    private init() {}
    static let main = "Main"
}

struct CustomColor {
    static let apricot = UIColor(named: "Apricot")
}
