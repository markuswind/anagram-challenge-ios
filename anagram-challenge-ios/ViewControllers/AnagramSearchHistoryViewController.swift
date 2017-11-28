//
//  AnagramSearchHistoryViewController.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import UIKit

protocol AnagramSearchHistoryViewControllerDelegate {
  func setWordAndCheckForAnagrams(word: String)
}

class AnagramSearchHistoryViewController: UITableViewController {

  // MARK: - Properties

  fileprivate let viewModel: AnagramSearchHistoryViewModel!

  var delegate: AnagramSearchHistoryViewControllerDelegate?

  // MARK: - View initializers

  private lazy var closeButton: UIBarButtonItem = {
    let title = "Close"
    let style: UIBarButtonItemStyle = .plain

    return UIBarButtonItem(title: title, style: style, target: self, action: #selector(closeButtonPressed))
  }()

  // MARK: - Lifecycle

  init(withViewModel: AnagramSearchHistoryViewModel) {
    viewModel = withViewModel

    super.init(style: .plain)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    configureNavigationBar()
    configureTableView()
  }

  private func configureNavigationBar() {
    navigationItem.title = "Search History"
    navigationItem.rightBarButtonItem = closeButton
  }

  private func configureTableView() {
    guard let tableView = tableView else {
      fatalError("tableView could not be found")
    }

    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = StyleConstants.colors.background

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: AnagramSearchHistoryViewModel.reuseIdentifier)
  }

  // MARK: - User interaction

  @objc private func closeButtonPressed(_sender: UIBarButtonItem?) {
    navigationController?.dismiss(animated: true, completion: nil)
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let word = viewModel.recentWordsData[indexPath.row]

    delegate?.setWordAndCheckForAnagrams(word: word)
    navigationController?.dismiss(animated: true, completion: nil)
  }

}

// MARK: - UITableViewDataSource

extension AnagramSearchHistoryViewController {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.recentWordsData.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: AnagramSearchHistoryViewModel.reuseIdentifier, for: indexPath) as UITableViewCell
    cell.textLabel?.text = viewModel.recentWordsData[indexPath.row]

    return cell
  }

}
