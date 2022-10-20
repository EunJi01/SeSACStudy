//
//  PhotoDetails.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/20.
//

import Foundation

struct PhotoDetails: Codable, Hashable {
    let id, description: String
    let likes: Int?
}
