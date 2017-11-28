//
//  AnagramSearchView.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import UIKit

class AnagramSearchView: UIView {

  // MARK: - View initializers

  override lazy var inputView: AnagramSearchInputView = {
    return AnagramSearchInputView()
  }()

  public var resultView: AnagramSearchResultView = {
    return AnagramSearchResultView()
  }()

  // MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = StyleConstants.colors.background

    configureInputViewConstraints()
    configureResultViewConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // MARK: - Constraints configuration

  private func configureInputViewConstraints() {
    let topConstraint = NSLayoutConstraint(item: inputView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
    let rightConstraint = NSLayoutConstraint(item: inputView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
    let leftConstraint = NSLayoutConstraint(item: inputView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)

    addSubview(inputView)
    addConstraints([topConstraint, rightConstraint, leftConstraint])
  }

  private func configureResultViewConstraints() {
    let topConstraint = NSLayoutConstraint(item: resultView, attribute: .top, relatedBy: .equal, toItem: inputView, attribute: .bottom, multiplier: 1, constant: 0)
    let rightConstraint = NSLayoutConstraint(item: resultView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
    let bottomConstraint = NSLayoutConstraint(item: resultView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
    let leftConstraint = NSLayoutConstraint(item: resultView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)

    addSubview(resultView)
    addConstraints([topConstraint, rightConstraint, bottomConstraint, leftConstraint])
  }

}
