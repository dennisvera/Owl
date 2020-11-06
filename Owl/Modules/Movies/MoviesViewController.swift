//
//  MovieViewController.swift
//  Owl
//
//  Created by Dennis Vera on 10/30/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

enum Section {

  // MARK: - Properties

  case nowPlaying
  case popular
  case upcoming
  case topRated
}

final class MoviesViewController: UIViewController {

  // MARK: - Typealias

  typealias DataSource = UICollectionViewDiffableDataSource<Section, Movie>
  typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Movie>

  // MARK: - Properties

  private var collectionView: UICollectionView!

  // MARK: -

  private let viewModel: MoviesViewModel

  // MARK: -

  private var dataSource: DataSource?
  private var snapshot = DataSourceSnapshot()

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

    setupView()
    fetchData()
    setupCollectionView()
    setupCollectionViewDataSource()
    applySnapshot()
  }

  private func setupView() {
    title = "Movies"

    view.backgroundColor = .white

    // Configure Navigation Controller
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  private func setupCollectionView() {
    // Configure Collection View
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewLayout())
    collectionView.dataSource = dataSource
    collectionView.backgroundColor = .systemBackground
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    // Register Collection View Cell
    collectionView.register(MoviesCollectionViewCell.self,
                            forCellWithReuseIdentifier: MoviesCollectionViewCell.reuseIdentifier)

    // Register Collection Header View
    collectionView.register(MoviesCollectionReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: MoviesCollectionReusableView.reuseIdentifier)

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

  private func fetchData() {
    viewModel.loadData()
  }

  // MARK: - UICollection View Layout

  private func createCollectionViewLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
      return self.createLayoutSection()
    }

    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = 20
    layout.configuration = config

    return layout
  }

  private func createLayoutSection() -> NSCollectionLayoutSection {
    let inset: CGFloat = 3
    let fraction: CGFloat = 1/3

    // Item
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction),
                                          heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: 0)

    // Group
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.94),
                                           heightDimension: .estimated(200))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    // Header
    //    let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
    //                                                heightDimension: .estimated(40))
    //    let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize,
    //                                                                 elementKind: UICollectionView.elementKindSectionHeader,
    //                                                                 alignment: .top)

    // Section
    let section = NSCollectionLayoutSection(group: group)
    //    section.boundarySupplementaryItems = [headerItem]
    section.orthogonalScrollingBehavior = .groupPaging
    section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: 8, bottom: inset, trailing: 0)

    return section
  }

  private func setupCollectionViewDataSource() {
    dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> MoviesCollectionViewCell? in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.reuseIdentifier,
                                                          for: indexPath) as? MoviesCollectionViewCell else { fatalError("DEAD") }

      cell.configure(with: movie)

      return cell
    })
  }
  
//  private func applySnapshot() {
//    snapshot = DataSourceSnapshot()
//    snapshot.appendSections([.nowPlaying])
//    snapshot.appendItems(viewModel.nowPlayingMovies, toSection: .nowPlaying)
//
//    dataSource?.apply(snapshot, animatingDifferences: false)
//  }

  private func applySnapshot() {
    viewModel.didShowNowPlayingMovies = { [weak self] movie in
      self?.snapshot = DataSourceSnapshot()
      self?.snapshot.appendSections([.nowPlaying])
      self?.snapshot.appendItems(movie, toSection: .nowPlaying)

      self?.dataSource?.apply(self!.snapshot, animatingDifferences: false)
    }
  }
}
