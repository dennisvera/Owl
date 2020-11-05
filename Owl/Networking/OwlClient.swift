//
//  OwlClient.swift
//  Owl
//
//  Created by Dennis Vera on 10/30/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

final class OwlClient: APIClient {

  // MARK: - Properties

  private let session: DataTaskMaker

  // MARK: - Initialization

  init() {
    self.session = URLSession.shared
  }

  // MARK: - GET Now Playing Movies Request /TMDB Feed

  func fetchNowPlayingMovies(_ page: Int, completion: @escaping (Result<MovieResponse, APIError>) -> Void) {
    guard let urlString = APIEndpoint.getNowPlayingMovies(pageIndex: page).url?.absoluteString else { return }

    fetchGenericJsonData(with: urlString, completion: completion)
  }

  // MARK: - GET Popular Movies Request /TMDB Feed

  func fetchPopularMovies(_ page: Int, completion: @escaping (Result<MovieResponse, APIError>) -> Void) {
    guard let urlString = APIEndpoint.popular(pageIndex: page).url?.absoluteString else { return }

    fetchGenericJsonData(with: urlString, completion: completion)
  }

  // MARK: - GET Upcoming Movies Request /TMDB Feed

  func fetchUpcomingMovies(_ page: Int, completion: @escaping (Result<MovieResponse, APIError>) -> Void) {
    guard let urlString = APIEndpoint.upcoming(pageIndex: page).url?.absoluteString else { return }

    fetchGenericJsonData(with: urlString, completion: completion)
  }

  // MARK: - GET Upcoming Movies Request /TMDB Feed

  func fetchTopRatedMovies(_ page: Int, completion: @escaping (Result<MovieResponse, APIError>) -> Void) {
    guard let urlString = APIEndpoint.upcoming(pageIndex: page).url?.absoluteString else { return }

    fetchGenericJsonData(with: urlString, completion: completion)
  }

  // MARK: - Helper Method

  private func fetchGenericJsonData<T: Decodable>(with urlString: String, completion: @escaping (Result<T, APIError>) -> Void) {
    guard let url = URL(string: urlString) else { return }

    // Create and Initiate Data Task
    session.dataTask(with: url) { (data, response, error) in
      if let data = data {
        do {
          // Initialize JSON Decoder
          let decoder = JSONDecoder()

          // Configure JSON Decoder
          decoder.dateDecodingStrategy = .iso8601
          decoder.keyDecodingStrategy = .convertFromSnakeCase

          // Decode JSON Response
          let response = try decoder.decode(T.self, from: data)

          // Invoke Handler
          completion(.success(response))
        } catch {
          // Invoke Handler
          completion(.failure(.invalidResponse))
        }

      } else {
        // Invoke Handler
        completion(.failure(.requestFailed))

        if let error = error {
          print("Unable to fetch data: \(error)")
        } else {
          print("Unable to fetch data")
        }
      }
    }.resume()
  }
}

// MARK: - DataTaskMaker

extension URLSession: DataTaskMaker {}
