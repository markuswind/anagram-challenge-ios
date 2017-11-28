//
//  AnagramCheckView.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import UIKit

protocol AnagramCheckViewDelegate {
  func checkButtonPressed(word: String)
}

class AnagramCheckView: UIView {

  // MARK: - Properties

  var delegate: AnagramCheckViewDelegate?

  // MARK: - View initializers

  private let textField: NormalTextField = {
    return NormalTextField()
  }()

  public lazy var infoLabel: UILabel = { [weak self] in
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0

    return label
  }()

  private let checkButton: NormalButton = {
    let normalButton = NormalButton()
    normalButton.setTitle("Check", for: .normal)
    normalButton.addTarget(self, action: #selector(checkButtonPressed(_:)), for: .touchUpInside)

    return normalButton
  }()

  public let isAnagramLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()

  // MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = StyleConstants.colors.background

    configureInfoLabelConstraints()
    configureTextFieldConstraints()
    configureCheckButtonConstraints()
    configureIsAnagramLabelConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // MARK: - Constraints configuration

  private func configureInfoLabelConstraints() {
    let centerConstraint = NSLayoutConstraint(item: infoLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
    let topConstraint = NSLayoutConstraint(item: infoLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: StyleConstants.margins.medium)
    let rightConstraint = NSLayoutConstraint(item: infoLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -StyleConstants.margins.medium)
    let leftConstraint = NSLayoutConstraint(item: infoLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: StyleConstants.margins.medium)

    addSubview(infoLabel)
    addConstraints([centerConstraint, topConstraint, rightConstraint, leftConstraint])
  }

  private func configureTextFieldConstraints() {
    let topConstraint = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: infoLabel, attribute: .bottom, multiplier: 1, constant: StyleConstants.margins.medium)
    let rightConstraint = NSLayoutConstraint(item: textField, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -StyleConstants.margins.medium)
    let leftConstraint = NSLayoutConstraint(item: textField, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: StyleConstants.margins.medium)

    addSubview(textField)
    addConstraints([topConstraint, rightConstraint, leftConstraint])
  }

  private func configureCheckButtonConstraints() {
    let topConstraint = NSLayoutConstraint(item: checkButton, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: StyleConstants.margins.medium)
    let rightConstraint = NSLayoutConstraint(item: checkButton, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -StyleConstants.margins.medium)
    let leftConstraint = NSLayoutConstraint(item: checkButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: StyleConstants.margins.medium)

    addSubview(checkButton)
    addConstraints([topConstraint, rightConstraint, leftConstraint])
  }

  private func configureIsAnagramLabelConstraints() {
    let centerConstraint = NSLayoutConstraint(item: isAnagramLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
    let topConstraint = NSLayoutConstraint(item: isAnagramLabel, attribute: .top, relatedBy: .equal, toItem: checkButton, attribute: .bottom, multiplier: 1, constant: StyleConstants.margins.medium)

    addSubview(isAnagramLabel)
    addConstraints([centerConstraint, topConstraint])
  }

  // MARK: - User interaction

  @objc private func checkButtonPressed(_ sender: UIButton?) {
    let word = textField.text!
    delegate?.checkButtonPressed(word: word)
  }

}
