//
//  ViewController.swift
//  Owl
//
//  Created by Dennis Vera on 10/30/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    let owlClient = OwlClient()

    owlClient.fetchNowPlayingMovies(1) { result in
      switch result {
      case .success(let movies):
        print(movies)
      case .failure(let error):
        print(error)
      }
    }
  }
}
