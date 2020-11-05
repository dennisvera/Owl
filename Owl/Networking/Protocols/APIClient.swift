//
//  APIClient.swift
//  Owl
//
//  Created by Dennis Vera on 10/30/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

protocol APIClient: AnyObject {

  func fetchPopularMovies(_ page: Int, completion: @escaping (Result<MovieResponse, APIError>) -> Void)
  func fetchTopRatedMovies(_ page: Int, completion: @escaping (Result<MovieResponse, APIError>) -> Void)
  func fetchUpcomingMovies(_ page: Int, completion: @escaping (Result<MovieResponse, APIError>) -> Void)
  func fetchNowPlayingMovies(_ page: Int, completion: @escaping (Result<MovieResponse, APIError>) -> Void)
}
