//
//  MoviesCollectionViewCell.swift
//  Owl
//
//  Created by Dennis Vera on 11/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SDWebImage

final class MoviesCollectionViewCell: UICollectionViewCell {

  // MARK: - Static Properties

  static var reuseIdentifier: String {
    return String(describing: self)
  }

  // MARK: - Properties

  private let movieImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 20
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Helper Methods

  private func setupViews() {
    addSubview(movieImageView)
    movieImageView.translatesAutoresizingMaskIntoConstraints = false

    let constraints = [
      // Movie Image View
      movieImageView.topAnchor.constraint(equalTo: topAnchor),
      movieImageView.leftAnchor.constraint(equalTo: leftAnchor),
      movieImageView.rightAnchor.constraint(equalTo: rightAnchor),
      movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]

    NSLayoutConstraint.activate(constraints)
  }

  // MARK: - Public Methods

  func configure(with movie: Movie) {
    // Configure Image view
    let imageBaseUrl = "https://image.tmdb.org/t/p/w300/"
    guard let posterPath = movie.posterPath else { return }
    guard let posterUrl = URL(string: imageBaseUrl + posterPath) else { return }
    movieImageView.sd_setImage(with: posterUrl)
  }
}
