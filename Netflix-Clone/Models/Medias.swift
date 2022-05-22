//
//  Medias.swift
//  Netflix-Clone
//
//  Created by Murillo R. Araújo on 18/04/22.
//

import Foundation

struct Trending: Decodable {
    let results: [Media]
}

struct Media: Decodable {
    let id: Int
    let mediaType: String?
    let originalName: String?
    let posterPath: String?
    let overview: String?
    let voteCount: Int
    let releaseDate: String?
    let voteAverage: Double
}
