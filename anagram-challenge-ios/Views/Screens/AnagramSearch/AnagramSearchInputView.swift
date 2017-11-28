//
//  AnagramSearchInputView.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import UIKit

protocol AnagramSearchInputViewDelegate {
  func searchButtonPressed(_ sender: UIButton?)
  func openCheckerButtonPressed(_ sender: UIButton?)
}

class AnagramSearchInputView: UIView {

  // MARK: - Properties

  var delegate: AnagramSearchInputViewDelegate?

  // MARK: - View initializers

  public lazy var textField: NormalTextField = { [weak self] in
    let normalTextField = NormalTextField()
    normalTextField.delegate = self

    return normalTextField
    }()

  private let searchButton: NormalButton = {
    let normalButton = NormalButton()
    normalButton.setTitle("Search", for: .normal)
    normalButton.addTarget(self, action: #selector(searchButtonPressed(_:)), for: .touchUpInside)

    return normalButton
  }()

  private let openCheckerButton: NormalButton = {
    let normalButton = NormalButton()
    normalButton.setTitle("Open Checker", for: .normal)
    normalButton.addTarget(self, action: #selector(openCheckerButtonPressed(_:)), for: .touchUpInside)

    return normalButton
  }()

  // MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false

    configureTextFieldConstraints()
    configureSearchButtonContraints()
    configureOpenCheckerButtonContraints()
    configureBottomConstraint()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // MARK: - Constraints configuration

  private func configureTextFieldConstraints() {
    let topConstraint = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: StyleConstants.margins.medium)
    let rightConstraint = NSLayoutConstraint(item: textField, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -StyleConstants.margins.medium)
    let leftConstraint = NSLayoutConstraint(item: textField, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: StyleConstants.margins.medium)

    addSubview(textField)
    addConstraints([topConstraint, rightConstraint, leftConstraint])
  }

  private func configureSearchButtonContraints() {
    let topConstraint = NSLayoutConstraint(item: searchButton, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: StyleConstants.margins.medium)
    let leftConstraint = NSLayoutConstraint(item: searchButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: StyleConstants.margins.medium)

    addSubview(searchButton)
    addConstraints([topConstraint, leftConstraint])
  }

  private func configureOpenCheckerButtonContraints() {
    let widthConstraint = NSLayoutConstraint(item: openCheckerButton, attribute: .width, relatedBy: .equal, toItem: searchButton, attribute: .width, multiplier: 1, constant: 0)

    let topConstraint = NSLayoutConstraint(item: openCheckerButton, attribute: .top, relatedBy: .equal, toItem: searchButton, attribute: .top, multiplier: 1, constant: 0)
    let rightConstraint = NSLayoutConstraint(item: openCheckerButton, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -StyleConstants.margins.medium)
    let leftConstraint = NSLayoutConstraint(item: openCheckerButton, attribute: .left, relatedBy: .equal, toItem: searchButton, attribute: .right, multiplier: 1, constant: StyleConstants.margins.medium)

    addSubview(openCheckerButton)
    addConstraints([widthConstraint, topConstraint, rightConstraint, leftConstraint])
  }

  private func configureBottomConstraint() {
    let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: openCheckerButton, attribute: .bottom, multiplier: 1, constant: StyleConstants.margins.medium)

    addConstraint(bottomConstraint)
  }

  // MARK: - User interaction

  @objc private func searchButtonPressed(_ sender: UIButton?) {
    delegate?.searchButtonPressed(sender)
  }

  @objc private func openCheckerButtonPressed(_ sender: UIButton?) {
    delegate?.openCheckerButtonPressed(sender)
  }

}

// MARK: - UITextFieldDelegate

extension AnagramSearchInputView: UITextFieldDelegate {

  // FIXME: - When entering more characters than "abcdefghijklmnopqrst"..
  //        - the app will crash due to exceeding the max Int value, see: AnagramSearchViewModel.setTotalNumberOfAnagrams()
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let maxLength = 20

    let currentString: NSString = textField.text! as NSString
    let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString

    return newString.length <= maxLength
  }

}
