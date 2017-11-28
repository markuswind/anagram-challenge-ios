//
//  AnagramSearchResultView.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import UIKit

class AnagramSearchResultView: UIView {

  // MARK: - View initializers

  public let wordLengthLabel: ResultHeaderLabel = {
    let resultHeaderLabel = ResultHeaderLabel()
    resultHeaderLabel.text = "Length:\n0"

    return resultHeaderLabel
  }()

  public let resultCountLabel: ResultHeaderLabel = {
    let resultHeaderLabel = ResultHeaderLabel()
    resultHeaderLabel.text = "Count:\n0"

    return resultHeaderLabel
  }()

  public lazy var tableView: UITableView = { [weak self] in
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = StyleConstants.colors.background

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: AnagramSearchViewModel.reuseIdentifier)

    return tableView
  }()

  // MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false

    configureWordLengthLabelConstraints()
    configureResultCountLabelConstraints()
    configureTableViewConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // MARK: - Constraints configuration

  private func configureWordLengthLabelConstraints() {
    let topConstraint = NSLayoutConstraint(item: wordLengthLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: StyleConstants.margins.medium)
    let leftConstraint = NSLayoutConstraint(item: wordLengthLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: StyleConstants.margins.medium)

    addSubview(wordLengthLabel)
    addConstraints([topConstraint, leftConstraint])
  }

  private func configureResultCountLabelConstraints() {
    let widthConstraint = NSLayoutConstraint(item: resultCountLabel, attribute: .width, relatedBy: .equal, toItem: wordLengthLabel, attribute: .width, multiplier: 1, constant: 0)

    let topConstraint = NSLayoutConstraint(item: resultCountLabel, attribute: .top, relatedBy: .equal, toItem: wordLengthLabel, attribute: .top, multiplier: 1, constant: 0)
    let rightConstraint = NSLayoutConstraint(item: resultCountLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -StyleConstants.margins.medium)
    let leftConstraint = NSLayoutConstraint(item: resultCountLabel, attribute: .left, relatedBy: .equal, toItem: wordLengthLabel, attribute: .right, multiplier: 1, constant: StyleConstants.margins.medium)

    addSubview(resultCountLabel)
    addConstraints([widthConstraint, topConstraint, rightConstraint, leftConstraint])
  }

  private func configureTableViewConstraints() {
    let topConstraint = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: wordLengthLabel, attribute: .bottom, multiplier: 1, constant: StyleConstants.margins.medium)
    let rightConstraint = NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
    let bottomConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
    let leftConstraint = NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)

    addSubview(tableView)
    addConstraints([topConstraint, rightConstraint, bottomConstraint, leftConstraint])
  }

}
