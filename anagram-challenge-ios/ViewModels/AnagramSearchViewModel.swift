//
//  AnagramSearchViewModel.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import Foundation

class AnagramSearchViewModel {

  // MARK: - Static Properties

  static let reuseIdentifier = "AnagramSearchTableViewCell"
  static let itemsPerPage = 50
  static let itemsTreshold = 25

  // MARK: - Properties

  var recentWordsData: [String]! = []

  var currentPage = 0
  var currentPermutation: Array<String>? = nil

  var totalNumberOfAnagrams = 0
  var anagramsData: [String]! = []

  // MARK: - View interaction

  func setNewWord(word: String, completion: () -> ()) {
    resetCurrentData()

    if word != "" {
      let word = word.lowercased()

      addWordToRecentWords(word: word)
      setTotalNumberOfAnagrams(word: word)
      requestNewPageOfAnagrams()
    }

    completion()
  }

  func requestNewPageOfAnagrams(completion: () -> ()) {
    requestNewPageOfAnagrams()
    completion()
  }

  private func resetCurrentData() {
    totalNumberOfAnagrams = 0
    anagramsData = []

    currentPage = 0
    currentPermutation = nil
  }

  // MARK: - Recent words

  private func addWordToRecentWords(word: String) {
    if word != "" {
      let uniqueRecentWordsData = recentWordsData.filter { $0.lowercased() != word}

      recentWordsData = uniqueRecentWordsData
      recentWordsData.insert(word.firstUpperCased, at: 0)
    }
  }

  public func mostRecentWord() -> String {
    return recentWordsData.first ?? ""
  }

  // NOTE: - see https://cs.stackexchange.com/questions/2443/finding-the-number-of-distinct-permutations-of-length-n-with-n-different-symbols
  private func setTotalNumberOfAnagrams(word: String) {
    let numberOfCharacters = word.count
    let sortedCharacters = word.sorted().map { String($0) }

    var denominator = 1
    var currentCharacter = sortedCharacters.first
    var currentCharacterCount = 0

    for character in sortedCharacters {
      if character == currentCharacter {
        currentCharacterCount += 1
      } else {
        denominator *= getFactorial(number: currentCharacterCount)

        currentCharacterCount = 1
        currentCharacter = character
      }
    }

    denominator *= getFactorial(number: currentCharacterCount)
    totalNumberOfAnagrams = getFactorial(number: numberOfCharacters) / denominator
  }

  private func getFactorial(number: Int) -> Int {
    var factorial = 1

    for i in 1...number {
      factorial = factorial * i
    }

    return factorial
  }

  // MARK: - Anagrams

  func requestNewPageOfAnagrams() {
    if let word = recentWordsData.first?.lowercased() {
      if currentPage == 0 {
        let sortedCharacters = word.sorted().map { String($0) }

        anagramsData.append(sortedCharacters.joined().firstUpperCased) // NOTE: - add lowest sorted permutation first
        currentPermutation = sortedCharacters
      }

      currentPage += 1
      addNewPageOfAnagramsToAnagramsData(word: word)
    }
  }

  private func addNewPageOfAnagramsToAnagramsData(word: String) {
    guard let _ = currentPermutation else {
      return
    }

    let anagramMax = currentPage * AnagramSearchViewModel.itemsPerPage
    var anagram = nextAnagram(characters: currentPermutation!)

    while(anagram != nil && (anagramsData.count < anagramMax)) {
      anagramsData.append(anagram!.joined().firstUpperCased)
      currentPermutation = anagram

      anagram = nextAnagram(characters: anagram!)
    }
  }

  // NOTE: - see: https://www.nayuki.io/page/next-lexicographical-permutation-algorithm
  private func nextAnagram(characters: Array<String>) -> Array<String>? {
    var characters = characters
    var indicatedPivotIndex = characters.count - 1

    while (indicatedPivotIndex > 0 && (characters[indicatedPivotIndex - 1] >= characters[indicatedPivotIndex])) {
      indicatedPivotIndex -= 1
    }

    if (indicatedPivotIndex <= 0) {
      return nil // NOTE: - Done
    }

    var swapIndex = characters.count - 1

    while (characters[swapIndex] <= characters[indicatedPivotIndex - 1]) {
      swapIndex -= 1
    }

    characters.swapAt(indicatedPivotIndex - 1, swapIndex)
    swapIndex = characters.count - 1

    while(indicatedPivotIndex < swapIndex) {
      characters.swapAt(indicatedPivotIndex, swapIndex)

      indicatedPivotIndex += 1
      swapIndex -= 1
    }

    return characters
  }

}
