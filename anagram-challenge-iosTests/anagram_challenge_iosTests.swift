//
//  anagram_challenge_iosTests.swift
//  anagram-challenge-iosTests
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import XCTest

class anagram_challenge_iosTests: XCTestCase {
    
  override func setUp() {
    super.setUp()
  }
    
  override func tearDown() {
    super.tearDown()
  }
    
  func testAnagramSearchViewModel() {
    let anagramSearchViewModel = AnagramSearchViewModel()

    anagramSearchViewModel.setNewWord(word: "ABC") {
      XCTAssertTrue(anagramSearchViewModel.totalNumberOfAnagrams == 6)
      XCTAssertTrue(anagramSearchViewModel.anagramsData.count == 6)
      XCTAssertTrue(anagramSearchViewModel.mostRecentWord() == "Abc")
    }

    anagramSearchViewModel.setNewWord(word: "ABBA") {
      XCTAssertTrue(anagramSearchViewModel.totalNumberOfAnagrams == 6)
      XCTAssertTrue(anagramSearchViewModel.anagramsData.count == 6)
      XCTAssertTrue(anagramSearchViewModel.mostRecentWord() == "Abba")
    }

    anagramSearchViewModel.setNewWord(word: "HELLO", completion: {
      XCTAssertTrue(anagramSearchViewModel.totalNumberOfAnagrams == 60)
      XCTAssertTrue(anagramSearchViewModel.anagramsData.count == AnagramSearchViewModel.itemsPerPage)
      XCTAssertTrue(anagramSearchViewModel.mostRecentWord() == "Hello")

      anagramSearchViewModel.requestNewPageOfAnagrams(completion: {
        XCTAssertTrue(anagramSearchViewModel.anagramsData.count == 60)
      })
    })
  }

  func testAnagramCheckViewModel() {
    let anagramCheckViewModel = AnagramCheckViewModel(word: "Apple")

    anagramCheckViewModel.isAnagramOfCurrentWord(word: "Apple") { (result) in
      XCTAssert(result == true)
    }

    anagramCheckViewModel.isAnagramOfCurrentWord(word: "Banana") { (result) in
      XCTAssert(result == false)
    }
  }

  func testAnagramSearchHistoryViewModel() {
    let recentWords = ["Apple", "Banana", "Orange", "Strawberry"]
    let anagramSearchHistoryViewModel = AnagramSearchHistoryViewModel(recentWords: recentWords)

    XCTAssert(anagramSearchHistoryViewModel.recentWordsData.count == 4)
  }
    
  func testPerformanceExample() {
    self.measure {
    }
  }

}
