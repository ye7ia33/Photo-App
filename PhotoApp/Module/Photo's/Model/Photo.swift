//
//  Photo.swift
//  PhotoApp
//
//  Created by Yahia El-Dow on 15/05/2022.
//

import Foundation
struct Photo: Codable {
    let albumID, id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

