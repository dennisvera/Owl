//
//  MovieViewController.swift
//  Owl
//
//  Created by Dennis Vera on 10/30/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

final class MovieViewController: UIViewController {

  // MARK: - Properties

  private weak var collectionView: UICollectionView!

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    fetchData()
    setupCollectionView()
  }

  private func setupCollectionView() {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    let constraints = [
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ]

    view.addSubview(collectionView)
    NSLayoutConstraint.activate(constraints)

    self.collectionView = collectionView
  }

  private func fetchData() {
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

extension MovieViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 30
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = .red
    return cell
  }
}

extension MovieViewController: UICollectionViewDelegate {}

