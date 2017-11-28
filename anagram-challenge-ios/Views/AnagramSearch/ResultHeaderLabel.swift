//
//  ResultHeaderLabel.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import UIKit

class ResultHeaderLabel: UILabel {

  // MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureDefaults()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  private func configureDefaults() {
    translatesAutoresizingMaskIntoConstraints = false

    textAlignment = .center
    numberOfLines = 2
  }

}
