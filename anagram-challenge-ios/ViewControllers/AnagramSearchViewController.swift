//
//  ViewController.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import UIKit

class AnagramSearchViewController: UIViewController {

  // MARK: - Properties

  fileprivate let viewModel: AnagramSearchViewModel!

  // MARK: - View initializers

  private lazy var historyButton: UIBarButtonItem = {
    let title = "History"
    let style: UIBarButtonItemStyle = .plain

    return UIBarButtonItem(title: title, style: style, target: self, action: #selector(historyButtonPressed))
  }()

  // MARK: - Lifecycle

  init(withViewModel: AnagramSearchViewModel) {
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
    configureView()
  }

  private func configureScreen() {
    navigationItem.title = "Search Anagrams"
    navigationItem.rightBarButtonItem = historyButton
  }

  private func configureView() {
    let anagramSearchView = AnagramSearchView()
    anagramSearchView.inputView.delegate = self
    anagramSearchView.resultView.tableView.delegate = self
    anagramSearchView.resultView.tableView.dataSource = self

    view = anagramSearchView
  }

  // MARK: - User interaction

  @objc private func historyButtonPressed() {
    pushAnagramSearchHistoryViewController()
  }

  // MARK - View Interaction

  private func pushAnagramCheckViewController() {
    let viewModel = AnagramCheckViewModel(word: self.viewModel.mostRecentWord())
    let viewController = AnagramCheckViewController(withViewModel: viewModel)

    navigationController?.pushViewController(viewController, animated: true)
  }

  private func pushAnagramSearchHistoryViewController() {
    let viewModel = AnagramSearchHistoryViewModel(recentWords: self.viewModel.recentWordsData)
    let viewController = AnagramSearchHistoryViewController(withViewModel: viewModel)
    viewController.delegate = self

    let navigationController = NavigationController(rootViewController: viewController)
    navigationController.modalPresentationStyle = .overCurrentContext

    self.navigationController?.present(navigationController, animated: true, completion: nil)
  }

}

// MARK: - AnagramSearchInputViewDelegate + AnagramSearchHistoryViewControllerDelegate

extension AnagramSearchViewController: AnagramSearchInputViewDelegate, AnagramSearchHistoryViewControllerDelegate {

  func searchButtonPressed(_ sender: UIButton?) {
    guard let view = view as? AnagramSearchView else {
      fatalError("AnagramSearchViewController's view needs to be a subclass of AnagramSearchView")
    }

    view.inputView.textField.endEditing(true)
    viewModel.setNewWord(word: view.inputView.textField.text!, completion: reloadResultViews)
  }

  func openCheckerButtonPressed(_ sender: UIButton?) {
    pushAnagramCheckViewController()
  }

  func setWordAndCheckForAnagrams(word: String) {
    guard let view = view as? AnagramSearchView else {
      fatalError("AnagramSearchViewController's view needs to be a subclass of AnagramSearchView")
    }

    view.inputView.textField.text = word
    viewModel.setNewWord(word: word, completion: reloadResultViews)
  }

  private func reloadResultViews() {
    guard let view = view as? AnagramSearchView else {
      fatalError("AnagramSearchViewController's view needs to be a subclass of AnagramSearchView")
    }

    view.resultView.tableView.reloadData()
    view.resultView.tableView.layoutIfNeeded()
    view.resultView.tableView.setContentOffset(.zero, animated: true)

    view.resultView.wordLengthLabel.text = "Length:\n \(viewModel.mostRecentWord().count)"
    view.resultView.resultCountLabel.text = "Count:\n \(viewModel.totalNumberOfAnagrams)"
  }

}

// MARK: - ResultTableView Delegate

extension AnagramSearchViewController: UITableViewDelegate {

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    guard let view = view as? AnagramSearchView else {
      fatalError("AnagramSearchViewController's view needs to be a subclass of AnagramSearchView")
    }

    guard let currentItem = view.resultView.tableView.indexPathsForVisibleRows?.last?.row else {
      return
    }

    let itemsPerPage = AnagramSearchViewModel.itemsPerPage
    let itemsTreshold = AnagramSearchViewModel.itemsTreshold
    let totalPages = ceil(Double(viewModel.totalNumberOfAnagrams) / Double(AnagramSearchViewModel.itemsPerPage))
    let tresholdItem = (viewModel.currentPage * itemsPerPage) - itemsTreshold

    if (currentItem > tresholdItem) && (viewModel.currentPage < Int(totalPages)) {
      viewModel.requestNewPageOfAnagrams(completion: insertNewRowsIntoTableView)
    }
  }

  private func insertNewRowsIntoTableView() {
    guard let view = view as? AnagramSearchView else {
      fatalError("AnagramSearchViewController's view needs to be a subclass of AnagramSearchView")
    }

    let numberOfRows = view.resultView.tableView.numberOfRows(inSection: 0)
    let indexPaths = (numberOfRows..<viewModel.anagramsData.count).map { IndexPath(row: $0, section: 0) }

    view.resultView.tableView.beginUpdates()
    view.resultView.tableView.insertRows(at: indexPaths, with: .none)
    view.resultView.tableView.endUpdates()
  }

}

// MARK: - ResultTableView DataSource

extension AnagramSearchViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.anagramsData.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: AnagramSearchViewModel.reuseIdentifier, for: indexPath) as UITableViewCell
    cell.textLabel?.text = viewModel.anagramsData[indexPath.row]

    return cell
  }

}
