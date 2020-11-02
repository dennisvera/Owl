//
//  AppCoordinator.swift
//  Owl
//
//  Created by Dennis Vera on 11/2/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

final class AppCoordinator {

  // MARK: Properties

  private let owlClient = OwlClient()

  // MARK: -
  
  private let navigationController = UINavigationController()

  // MARK: - Public API

  var rootViewController: UIViewController {
    return navigationController
  }

  // MARK: -

  func start() {
    showMovies()
  }

  // MARK: - Helper Methods

  private func showMovies() {
    // Initialize Movies View Model
    let viewModel = MoviesViewModel(apiClient: owlClient)

    // Initialize Movies View Controller
    let moviesViewController = MoviesViewController(viewModel: viewModel)

    // Push Feed View Controller Onto Navigation Stack
    navigationController.navigationBar.prefersLargeTitles = true
    navigationController.pushViewController(moviesViewController, animated: true)
  }
}
