//
//  NormalButton.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import UIKit

class NormalButton: UIButton {

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

    setTitleColor(StyleConstants.colors.primary, for: .normal)
    setTitleColor(StyleConstants.colors.secondary, for: .highlighted)

    layer.cornerRadius = 5
    layer.borderWidth = 1
    layer.borderColor = StyleConstants.colors.primary.cgColor
  }

}
