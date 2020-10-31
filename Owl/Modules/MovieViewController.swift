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

  private var collectionView: UICollectionView!

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    fetchData()
    setupCollectionView()
  }

  private func setupCollectionView() {
    // Configure Collection View
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewLayout())
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .white
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    // Constraints
    let constraints = [
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ]

    view.addSubview(collectionView)
    NSLayoutConstraint.activate(constraints)
  }

  private func createCollectionViewLayout() -> UICollectionViewLayout {
    let inset: CGFloat = 2.5
    let fraction: CGFloat = 1 / 2

    // Item
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

    // Group
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    // Section
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

    // Layout
    let layout = UICollectionViewCompositionalLayout(section: section)

    return layout
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

