//
//  AppDelegate.swift
//  anagram-challenge-ios
//
//  Created by Markus Wind on 28/11/2017.
//  Copyright © 2017 Markus Wind. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let rootNavigationController = createRootNavigationController()

    window = createWindow(rootViewController: rootNavigationController)
    window!.makeKeyAndVisible()

    return true
  }

  private func createRootNavigationController() -> NavigationController {
    let anagramSearchViewModel = AnagramSearchViewModel()
    let anagramSearchViewController = AnagramSearchViewController(withViewModel: anagramSearchViewModel)
    let navigationController = NavigationController(rootViewController: anagramSearchViewController)

    return navigationController
  }

  private func createWindow(rootViewController: UIViewController) -> UIWindow {
    let window = UIWindow(frame: UIScreen.main.bounds)

    window.tintColor = StyleConstants.colors.primary
    window.rootViewController = rootViewController

    return window
  }

}
