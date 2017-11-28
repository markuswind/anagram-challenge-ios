//
//  NavigationController.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

  // MARK: - View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()

    configureNavigationBarStyling()
  }

  private func configureNavigationBarStyling() {
    navigationBar.barStyle = .black
    navigationBar.isTranslucent = false

    navigationBar.barTintColor = StyleConstants.colors.primary
    navigationBar.tintColor = StyleConstants.colors.navigationBarTextTintColor
  }

}
