//
//  YoutubeSearchResponse.swift
//  NetflixClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 2.12.2024.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String?
}
