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

  private var movies: [Movie]?
  private let viewModel: MoviesViewModel

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
    collectionView.delegate = self
    collectionView.dataSource = self
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

    viewModel.moviesDidChange = { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.collectionView.reloadData()
    }
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
    let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .estimated(40))
    let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)

    // Section
    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [headerItem]
    section.orthogonalScrollingBehavior = .groupPaging
    section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: 8, bottom: inset, trailing: 0)

    return section
  }
}

extension MoviesViewController: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 4
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfMovies
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.reuseIdentifier,
                                                        for: indexPath) as? MoviesCollectionViewCell else {
                                                          fatalError("Unable to Dequeue Cells.") }
    let movie = viewModel.nowPlayingMovie(at: indexPath.item)

    cell.configure(with: movie)

    return cell
  }

  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: MoviesCollectionReusableView.reuseIdentifier,
                                                                           for: indexPath) as? MoviesCollectionReusableView else {
                                                                            fatalError("Unable to Dequeue Reusable View.") }
    switch indexPath.section {
    case 0:
      headerView.titleLabel.text = "Now Playing"
    case 1:
      headerView.titleLabel.text = "Popular"
    case 2:
      headerView.titleLabel.text = "Upcoming"
    case 3:
      headerView.titleLabel.text = "Top Rated"
    default:
      print("No Header Title to Display")
    }

    return headerView
  }
}

extension MoviesViewController: UICollectionViewDelegate {}

