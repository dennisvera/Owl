//
//  MovieViewController.swift
//  Owl
//
//  Created by Dennis Vera on 10/30/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {

  // MARK: - Properties

  private var collectionView: UICollectionView!

  // MARK: -

  private let viewModel: MoviesViewModel

  private var movies: [Movie]?

  // MARK: - Initialization

  init(viewModel: MoviesViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: Bundle.main)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

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
    collectionView.register(MoviesCollectionViewCell.self,
                            forCellWithReuseIdentifier: MoviesCollectionViewCell.reuseIdentifier)
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
    viewModel.loadData()

    viewModel.moviesDidChange = { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.collectionView.reloadData()
    }
  }
}

extension MoviesViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfMovies
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.reuseIdentifier,
                                                        for: indexPath) as? MoviesCollectionViewCell else {
                                                          fatalError("Unable to Dequeue Cells.") }
    let movie = viewModel.movie(at: indexPath.item)

    cell.configure(with: movie)

    return cell
  }
}

extension MoviesViewController: UICollectionViewDelegate {}

