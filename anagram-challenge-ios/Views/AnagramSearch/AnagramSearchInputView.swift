//
//  AnagramSearchInputView.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import UIKit

protocol AnagramSearchInputViewDelegate {
  func buttonAPressed(_ sender: UIButton?)
  func buttonBPressed(_ sender: UIButton?)
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

  private let buttonA: NormalButton = {
    let normalButton = NormalButton()
    normalButton.setTitle("Knop A", for: .normal)
    normalButton.addTarget(self, action: #selector(buttonAPressed(_:)), for: .touchUpInside)

    return normalButton
  }()

  private let buttonB: NormalButton = {
    let normalButton = NormalButton()
    normalButton.setTitle("Knop B", for: .normal)
    normalButton.addTarget(self, action: #selector(buttonBPressed(_:)), for: .touchUpInside)

    return normalButton
  }()

  // MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false

    configureTextFieldConstraints()
    configureButtonAContraints()
    configureButtonBContraints()
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

  private func configureButtonAContraints() {
    let topConstraint = NSLayoutConstraint(item: buttonA, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: StyleConstants.margins.medium)
    let leftConstraint = NSLayoutConstraint(item: buttonA, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: StyleConstants.margins.medium)

    addSubview(buttonA)
    addConstraints([topConstraint, leftConstraint])
  }

  private func configureButtonBContraints() {
    let widthConstraint = NSLayoutConstraint(item: buttonB, attribute: .width, relatedBy: .equal, toItem: buttonA, attribute: .width, multiplier: 1, constant: 0)

    let topConstraint = NSLayoutConstraint(item: buttonB, attribute: .top, relatedBy: .equal, toItem: buttonA, attribute: .top, multiplier: 1, constant: 0)
    let rightConstraint = NSLayoutConstraint(item: buttonB, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -StyleConstants.margins.medium)
    let leftConstraint = NSLayoutConstraint(item: buttonB, attribute: .left, relatedBy: .equal, toItem: buttonA, attribute: .right, multiplier: 1, constant: StyleConstants.margins.medium)

    addSubview(buttonB)
    addConstraints([widthConstraint, topConstraint, rightConstraint, leftConstraint])
  }

  private func configureBottomConstraint() {
    let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: buttonB, attribute: .bottom, multiplier: 1, constant: StyleConstants.margins.medium)

    addConstraint(bottomConstraint)
  }

  // MARK: - User interaction

  @objc private func buttonAPressed(_ sender: UIButton?) {
    delegate?.buttonAPressed(sender)
  }

  @objc private func buttonBPressed(_ sender: UIButton?) {
    delegate?.buttonBPressed(sender)
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
