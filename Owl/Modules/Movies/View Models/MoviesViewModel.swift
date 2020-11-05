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

  private var nowPlayingMovies: [Movie] = [] {
    didSet {
      DispatchQueue.main.async {
        self.moviesDidChange?()
      }
    }
  }

  private var popularMovies: [Movie] = [] {
    didSet {
      DispatchQueue.main.async {
        self.moviesDidChange?()
      }
    }
  }

  // MARK: -

  var numberOfNowPlayingMovies: Int {
    return nowPlayingMovies.count
  }

  var numberOfPopularMovies: Int {
    return popularMovies.count
  }

  // MARK: -

  var moviesDidChange: (() -> Void)?

  // MARK: - Initialization

  init(apiClient: APIClient) {
    self.apiClient = apiClient
  }

  // MARK: - Public Methods

  private func fetchNowPlayingMovies() {
    apiClient.fetchNowPlayingMovies(1) { result in
      switch result {
      case .success(let movies):
        self.nowPlayingMovies = movies.results
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

  // MARK: - Public Methods

  func loadData() {
    fetchNowPlayingMovies()
    fetchPopularMovies()
  }

  func nowPlayingMovie(at index: Int) -> Movie {
    return nowPlayingMovies[index]
  }

  func popularMovie(at index: Int) -> Movie {
    return popularMovies[index]
  }
}
