//
//  RandomPhotos.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/29.
//

import Foundation

struct RandomPhotos: Codable, Hashable {
    let id: String
    let likes: Int
    let urls: Urls
}
