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

  private lazy var buttonC: UIBarButtonItem = {
    let title = "Knop C"
    let style: UIBarButtonItemStyle = .plain

    return UIBarButtonItem(title: title, style: style, target: self, action: #selector(buttonCPressed))
  }()

  override lazy var inputView: AnagramSearchInputView = { [weak self] in
    let anagramSearchInputView = AnagramSearchInputView()
    anagramSearchInputView.delegate = self

    return anagramSearchInputView
    }()

  private lazy var resultView: AnagramSearchResultView = { [weak self] in
    let anagramSearchResultView = AnagramSearchResultView()
    anagramSearchResultView.tableView.delegate = self
    anagramSearchResultView.tableView.dataSource = self

    return anagramSearchResultView
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
    configureInputViewConstraints()
    configureResultViewConstraints()
  }

  private func configureScreen() {
    navigationItem.title = "Scherm 1"
    navigationItem.rightBarButtonItem = buttonC

    view.backgroundColor = StyleConstants.colors.background
  }

  // MARK: - Constraints configuration

  private func configureInputViewConstraints() {
    let topConstraint = NSLayoutConstraint(item: inputView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
    let rightConstraint = NSLayoutConstraint(item: inputView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
    let leftConstraint = NSLayoutConstraint(item: inputView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)

    view.addSubview(inputView)
    view.addConstraints([topConstraint, rightConstraint, leftConstraint])
  }

  private func configureResultViewConstraints() {
    let topConstraint = NSLayoutConstraint(item: resultView, attribute: .top, relatedBy: .equal, toItem: inputView, attribute: .bottom, multiplier: 1, constant: 0)
    let rightConstraint = NSLayoutConstraint(item: resultView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
    let bottomConstraint = NSLayoutConstraint(item: resultView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
    let leftConstraint = NSLayoutConstraint(item: resultView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)

    view.addSubview(resultView)
    view.addConstraints([topConstraint, rightConstraint, bottomConstraint, leftConstraint])
  }

  // MARK: - User interaction

  @objc private func buttonCPressed() {
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

  func buttonAPressed(_ sender: UIButton?) {
    inputView.textField.endEditing(true)
    viewModel.setNewWord(word: inputView.textField.text!, completion: reloadResultViews)
  }

  func buttonBPressed(_ sender: UIButton?) {
    pushAnagramCheckViewController()
  }

  func setWordAndCheckForAnagrams(word: String) {
    inputView.textField.text = word
    viewModel.setNewWord(word: word, completion: reloadResultViews)
  }

  private func reloadResultViews() {
    resultView.tableView.reloadData()
    resultView.tableView.layoutIfNeeded()
    resultView.tableView.setContentOffset(.zero, animated: true)

    resultView.wordLengthLabel.text = "Lengte:\n \(viewModel.mostRecentWord().count)"
    resultView.resultCountLabel.text = "Aantal:\n \(viewModel.totalNumberOfAnagrams)"
  }

}

// MARK: - ResultTableView Delegate

extension AnagramSearchViewController: UITableViewDelegate {

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    guard let currentItem = resultView.tableView.indexPathsForVisibleRows?.last?.row else {
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
    let numberOfRows = resultView.tableView.numberOfRows(inSection: 0)
    let indexPaths = (numberOfRows..<viewModel.anagramsData.count).map { IndexPath(row: $0, section: 0) }

    resultView.tableView.beginUpdates()
    resultView.tableView.insertRows(at: indexPaths, with: .none)
    resultView.tableView.endUpdates()
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
