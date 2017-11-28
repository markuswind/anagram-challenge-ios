//
//  AnagramCheckViewController.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import UIKit

class AnagramCheckViewController: UIViewController {

  // MARK: - Properties

  fileprivate let viewModel: AnagramCheckViewModel!

  // MARK: - View initializers

  private let textField: NormalTextField = {
    return NormalTextField()
  }()

  private lazy var infoLabel: UILabel = { [weak self] in
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.text = "Check if entered word is an anagram of \"\(self!.viewModel.word!)\""

    return label
  }()

  private let checkButton: NormalButton = {
    let normalButton = NormalButton()
    normalButton.setTitle("Check", for: .normal)
    normalButton.addTarget(self, action: #selector(checkButtonPressed(_:)), for: .touchUpInside)

    return normalButton
  }()

  private let isAnagramLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()

  // MARK: - Lifecycle

  init(withViewModel: AnagramCheckViewModel) {
    viewModel = withViewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    configureScreen()
    configureInfoLabelConstraints()
    configureTextFieldConstraints()
    configureCheckButtonConstraints()
    configureIsAnagramLabelConstraints()
  }

  private func configureScreen() {
    navigationItem.title = "Anagram Checker"
    view.backgroundColor = StyleConstants.colors.background
  }

  // MARK: - Constraints configuration

  private func configureInfoLabelConstraints() {
    let centerConstraint = NSLayoutConstraint(item: infoLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
    let topConstraint = NSLayoutConstraint(item: infoLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: StyleConstants.margins.medium)
    let rightConstraint = NSLayoutConstraint(item: infoLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -StyleConstants.margins.medium)
    let leftConstraint = NSLayoutConstraint(item: infoLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: StyleConstants.margins.medium)

    view.addSubview(infoLabel)
    view.addConstraints([centerConstraint, topConstraint, rightConstraint, leftConstraint])
  }

  private func configureTextFieldConstraints() {
    let topConstraint = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: infoLabel, attribute: .bottom, multiplier: 1, constant: StyleConstants.margins.medium)
    let rightConstraint = NSLayoutConstraint(item: textField, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -StyleConstants.margins.medium)
    let leftConstraint = NSLayoutConstraint(item: textField, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: StyleConstants.margins.medium)

    view.addSubview(textField)
    view.addConstraints([topConstraint, rightConstraint, leftConstraint])
  }

  private func configureCheckButtonConstraints() {
    let topConstraint = NSLayoutConstraint(item: checkButton, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: StyleConstants.margins.medium)
    let rightConstraint = NSLayoutConstraint(item: checkButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -StyleConstants.margins.medium)
    let leftConstraint = NSLayoutConstraint(item: checkButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: StyleConstants.margins.medium)

    view.addSubview(checkButton)
    view.addConstraints([topConstraint, rightConstraint, leftConstraint])
  }

  private func configureIsAnagramLabelConstraints() {
    let centerConstraint = NSLayoutConstraint(item: isAnagramLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
    let topConstraint = NSLayoutConstraint(item: isAnagramLabel, attribute: .top, relatedBy: .equal, toItem: checkButton, attribute: .bottom, multiplier: 1, constant: StyleConstants.margins.medium)

    view.addSubview(isAnagramLabel)
    view.addConstraints([centerConstraint, topConstraint])
  }

  // MARK: - User interaction

  @objc private func checkButtonPressed(_: UIButton?) {
    let word = textField.text

    viewModel.isAnagramOfCurrentWord(word: word!, completion: updateIsAnagramLabel)
  }

  // MARK: - View interaction

  private func updateIsAnagramLabel(isAnagram: Bool) {
    isAnagramLabel.text = isAnagram ? "YES" : "NO"
  }

}
