//
//  Movies.swift
//  Netflix-Clone
//
//  Created by Murillo R. Araújo on 18/04/22.
//

import Foundation

struct Movies: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let mediaType: String?
    let originalName: String?
    let posterPath: String?
    let overview: String?
    let voteCount: Int
    let releaseDate: String?
    let voteAverage: Double
}
