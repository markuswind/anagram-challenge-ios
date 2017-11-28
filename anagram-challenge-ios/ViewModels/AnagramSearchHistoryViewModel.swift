//
//  AnagramSearchHistoryViewModel.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

class AnagramSearchHistoryViewModel {

  // MARK: - Properties

  static let reuseIdentifier = "ScreenThreeTableViewCell"

  let recentWordsData: [String]!

  // MARK: - Lifecycle

  init(recentWords: [String]) {
    recentWordsData = recentWords
  }

}
