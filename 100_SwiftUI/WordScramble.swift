//
//  WordScramble.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 3/29/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI


struct WordScramble: View {
  @State private var allwords = [String]()
  @State private var usedWords = [String]()
  @State private var rootWord = ""
  @State private var newWord = ""
  @State private var currentScore = 0
  @State private var errorTitle = ""
  @State private var errorMessage = ""
  @State private var showingError = false
  
  var body: some View {
    NavigationView {
      VStack {
        TextField("Enter your word", text: $newWord, onCommit: addNewWord)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .autocapitalization(.none)
          .padding()
        
        Text("Current Score: \(currentScore)")
        
        List(usedWords, id: \.self) {
          Text($0)
        }
        .listStyle(PlainListStyle())
     }
      .navigationBarTitle(rootWord)
      .navigationBarItems(leading: Button("Restart", action: restartGame))
    }
    .onAppear(perform: startGame)
    .alert(isPresented: $showingError) {
      Alert(title: Text(errorTitle),
            message: Text(errorMessage),
            dismissButton: .default(Text("OK")))
    }
  }
  
  func addNewWord() {
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    guard answer.count > 0 else {
      return
    }
    
    guard isOriginal(word: answer) else {
      wordError(title: "Word used already", message: "Be more original")
      return
    }
    
    guard isPossible(word: answer) else {
      wordError(title: "Word not recognized", message: "Can't make up a word with given letters")
      return
    }
    
    guard isRealWord(word: answer) else {
      wordError(title: "Word not real", message: "You can't put gibberish")
      return
    }
    
    guard rootWord != answer else {
      wordError(title: "Root word used", message: "You can't use the root word")
      return
    }
    
    usedWords.insert(answer, at: 0)
    newWord = ""
    currentScore += 1
  }
  
  func startGame() {
    if let wordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
      if let words = try? String(contentsOf: wordsURL) {
        allwords = words.components(separatedBy: "\n")
        rootWord = allwords.randomElement() ?? "silkworm"
        return
      }
    }
    
    fatalError("Could not load words.txt from bundle")
  }
  
  func isOriginal(word: String) -> Bool {
    !usedWords.contains(word)
  }
  
  func isPossible(word: String) -> Bool {
    var tempWord = rootWord.lowercased()
    
    for letter in word {
      if let pos = tempWord.firstIndex(of: letter) {
        tempWord.remove(at: pos)
      } else {
        return false
      }
    }
    return true
  }
  
  func isRealWord(word: String) -> Bool {
    
    if word.count < 3 {
      return false
    }
    
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    
    let misspelledRange =  checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    return misspelledRange.location == NSNotFound
  }
  
  func restartGame() {
    usedWords = []
    rootWord = allwords.randomElement() ?? "silkworm"
    currentScore = 0
  }
  
  func wordError(title: String, message: String) {
    errorTitle = title
    errorMessage = message
    showingError = true
  }
}
 
struct WordScramble_Preview: PreviewProvider {
  static var previews: some View {
    WordScramble()
  }
}
