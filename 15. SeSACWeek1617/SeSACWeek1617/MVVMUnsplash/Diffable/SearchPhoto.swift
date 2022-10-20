//
//  SearchPhoto.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/20.
//

import Foundation

// MARK: diffableDataSource 에게 알려주기 위한 Hashable 채택

struct SearchPhoto: Codable, Hashable {
    let total, totalPages: Int
    let results: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct SearchResult: Codable, Hashable {
    let id: String
    let urls: Urls
    let likes: Int
}

struct Urls: Codable, Hashable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
