//
//  MoviesCollectionReusableView.swift
//  Owl
//
//  Created by Dennis Vera on 11/3/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

final class MoviesCollectionReusableView: UICollectionReusableView {

  // MARK: - Static Properties

  static var reuseIdentifier: String {
    return String(describing: self)
  }

  // MARK: - Properties

  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 20)
    return label
  }()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Helper Methods

  private func setupView() {
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    let constraints = [
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
    ]

    NSLayoutConstraint.activate(constraints)
  }
}
