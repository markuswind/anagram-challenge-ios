//
//  AnagramHistoryViewModel.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

class AnagramCheckViewModel {

  // MARK: - Properties

  let word: String?

  // MARK: - Lifecycle

  init(word: String?) {
    self.word = word
  }

  // MARK: - Anagram checker

  func isAnagramOfCurrentWord(word: String, completion: (Bool) -> ()) {
    guard let currentWord = self.word else {
      completion(false)
      return
    }

    if currentWord.count != word.count {
      completion(false)
      return
    }

    completion(checkIfAnagram(currentWord: currentWord, newWord: word))
  }

  /**
   If newWord contains exactly the same characters as currentWord,
   the newWord will be empty and it's an anagram.

   This seems to be the fastest way to do this.

   @param currentWord the current word that is entered in screen 1
   @param newWord the new word that is entered in screen 2
   @return isAnagram
   */
  private func checkIfAnagram(currentWord: String, newWord: String) -> Bool {
    let currentWord = currentWord.lowercased()
    var newWord = newWord.lowercased()

    for character in currentWord.characters {
      if let characterIndex = newWord.index(of: character) {
        newWord.remove(at: characterIndex)
      } else {
        break
      }
    }

    return newWord.count == 0
  }

}
