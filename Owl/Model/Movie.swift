//
//  Movie.swift
//  Owl
//
//  Created by Dennis Vera on 10/30/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {

  // MARK: - Properties
  
  let page: Int
  let results: [Movie]
  let totalResults: Int
}

struct Movie: Decodable, Hashable {

  // MARK: - Properties

  let id: Int
  let title: String
  let voteCount: Int
  let overview: String
  let releaseDate: String
  let posterPath: String?
  let popularity: Double
  let backdropPath: String?
}
