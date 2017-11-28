//
//  String+FirstUpperCased.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

extension String {

  var firstUpperCased: String {
    guard let first = first else { return "" }
    return String(first).uppercased() + dropFirst()
  }

}
