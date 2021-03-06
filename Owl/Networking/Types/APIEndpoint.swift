//
//  APIEndpoint.swift
//  Owl
//
//  Created by Dennis Vera on 10/30/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

// MARK: - Types

private enum QueryItem: String {

  // MARK: - Cases

  case apiKey = "2631ea46e7edd7894cf3eaee7d263667"
  case language = "en-US"
}

internal enum APIEndpoint {

  // MARK: - Cases

  case popular(pageIndex: Int)
  case upcoming(pageIndex: Int)
  case topRated(pageIndex: Int)
  case getNowPlayingMovies(pageIndex: Int)

  // MARK: - URL Components
  
  var url: URL? {
    var component = URLComponents()
    component.scheme = "https"
    component.host = "api.themoviedb.org"
    component.path = path
    component.queryItems = pageQuery()
    return component.url
  }

  // MARK: - URL Query Items

  private func pageQuery() -> [URLQueryItem]? {
    switch self {
    case .getNowPlayingMovies(let page):
      return queryItem(page: page)
    case .popular(let page):
      return queryItem(page: page)
    case .upcoming(let page):
      return queryItem(page: page)
    case .topRated(let page):
      return queryItem(page: page)
    }
  }

  private func queryItem(page: Int) -> [URLQueryItem]? {
    return [
      URLQueryItem(name: "api_key", value: QueryItem.apiKey.rawValue),
      URLQueryItem(name: "language", value: QueryItem.language.rawValue),
      URLQueryItem(name: "page", value: page.description)
    ]
  }
}

private extension APIEndpoint {

  var path: String {
    switch self {
    case .getNowPlayingMovies:
      return "/3/movie/now_playing"
    case .popular:
      return "/3/movie/popular"
    case .upcoming:
      return "/3/movie/upcoming"
      case .topRated:
        return "/3/movie/top_rated"
    }
  }
}
