//
//  MoviesCollectionViewCell.swift
//  Owl
//
//  Created by Dennis Vera on 11/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

  // MARK: - Static Properties

  static var reuseIdentifier: String {
    return String(describing: self)
  }

  // MARK: - Properties

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Donut"
    label.font = .systemFont(ofSize: 14)
    return label
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
    backgroundColor = .cyan

    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    let constraints = [titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                       titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
                       titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
                       titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)]

    NSLayoutConstraint.activate(constraints)
  }

  // MARK: - Public Methods

  func configure(with movie: Movie) {
    titleLabel.text = movie.title
  }
}
