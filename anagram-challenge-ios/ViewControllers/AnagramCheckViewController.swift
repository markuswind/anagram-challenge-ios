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
    configureView()
  }

  private func configureScreen() {
    navigationItem.title = "Anagram Checker"
  }

  private func configureView() {
    let anagramCheckView = AnagramCheckView()
    anagramCheckView.delegate = self
    anagramCheckView.infoLabel.text = "Check if entered word is an anagram of \"\(viewModel.word!)\""

    view = anagramCheckView
  }

  // MARK: - View interaction

  private func updateIsAnagramLabel(isAnagram: Bool) {
    guard let view = view as? AnagramCheckView else {
      fatalError("AnagramCheckViewController's view needs to be a subclass of AnagramCheckView")
    }

    view.isAnagramLabel.text = isAnagram ? "YES" : "NO"
  }

}

// MARK: - AnagramCheckViewDelegate

extension AnagramCheckViewController: AnagramCheckViewDelegate {

  func checkButtonPressed(word: String) {
    viewModel.isAnagramOfCurrentWord(word: word, completion: updateIsAnagramLabel)
  }

}
