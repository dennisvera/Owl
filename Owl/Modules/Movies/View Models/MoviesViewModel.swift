//
//  MoviesViewModel.swift
//  Owl
//
//  Created by Dennis Vera on 11/2/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

final class MoviesViewModel {

  // MARK: - Properties

  private let apiClient: APIClient

  // MARK: -

  var popularMovies: [Movie] = []
  var upcomingMovies: [Movie] = []
  var topRatedMovies: [Movie] = []
  var nowPlayingMovies: [Movie] = []

  // MARK: -

  var didShowNowPlayingMovies: (([Movie]) -> Void)?

  // MARK: - Initialization

  init(apiClient: APIClient) {
    self.apiClient = apiClient
  }

  // MARK: - Public Methods

  func loadData() {
    fetchPopularMovies()
    fetchUpcomingMovies()
    fetchTopRatedMovies()
    fetchNowPlayingMovies()
  }

  // MARK: - Private Methods

  private func fetchNowPlayingMovies() {
    apiClient.fetchNowPlayingMovies(1) { result in
      switch result {
      case .success(let movies):
        self.nowPlayingMovies = movies.results
        self.didShowNowPlayingMovies?(movies.results)
      case .failure(let error):
        print(error)
      }
    }
  }

  private func fetchPopularMovies() {
    apiClient.fetchPopularMovies(1) { result in
      switch result {
      case .success(let movies):
        self.popularMovies = movies.results
      case .failure(let error):
        print(error)
      }
    }
  }

  private func fetchUpcomingMovies() {
    apiClient.fetchUpcomingMovies(1) { result in
      switch result {
      case .success(let movies):
        self.upcomingMovies = movies.results
      case .failure(let error):
        print(error)
      }
    }
  }

  private func fetchTopRatedMovies() {
    apiClient.fetchTopRatedMovies(1) { result in
      switch result {
      case .success(let movies):
        self.topRatedMovies = movies.results
      case .failure(let error):
        print(error)
      }
    }
  }
}
