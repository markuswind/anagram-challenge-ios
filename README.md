# anagram-challenge-ios

Example of an Anagram search/checker app for iOS, using the MVVM architecture. Written in Xcode 9.

### Screenshots

TODO: - add screenshots

### Running

Clone the repository and run application inside Xcode.

```
git clone https://github.com/markuswind/anagram-challenge-ios
```

### Features

* Search Screen
  * Search anagrams with entered word from a textfield
  * Show length of entered word
  * Show total number of all possible unique anagrams
  * Show list with all possible unique anagrams (+lazy loading)
  * + Button to open anagram checker screen
  * + Button to open search history of current session

* History Screen
  * Show search history of current session
  * Dismiss when search entry is pressed + search anagrams with pressed entry

* Checker Screen
  * Check if entered word is an anagram of the previous entered word in Search Screen

### Plugins used

* None
* \+ [StyleGuide](https://github.com/raywenderlich/swift-style-guide)

## License

MIT.
