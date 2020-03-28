//
//  RPS.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 3/27/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI

struct RPS: View {
  private let options = ["shield", "map", "scissors"]
  private let names = ["Rock", "Paper", "Scissors"]
  @State private var compSelection = Int.random(in: 0...2)
  @State private var result = false
  @State private var showingResult = false
  @State private var gameMessage = ""
  @State private var score = 0
  var body: some View {
    VStack(spacing: 50) {
      Text("Let's play")
        .font(.largeTitle)
      
      Image(systemName: showingResult ? options[compSelection] : "questionmark.square.fill")
        .resizable()
        .frame(width: 150, height: 150)
        
        
      Text(showingResult ? gameMessage : "Choose")
        .font(.largeTitle)
      
      HStack(alignment: .top, spacing: 35) {
        Spacer()
        ForEach(0 ..< 3) { number in
          VStack {
            Text(self.names[number])
              .font(.title)
            
            Button(action: {
              self.gameLogic(selected: number)
              self.showingResult = true
              
              DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.resetGame()
              }
              
            }, label: {
              
              Image(systemName: self.options[number])
                .font(.largeTitle)
            })
          }
        }
        Spacer()
      }
      Text("Score: \(score)")
        .font(.title)
      .bold()
    }
  }
  
  func resetGame() {
    compSelection = Int.random(in: 0...2)
    showingResult = false
  }
  
  func gameLogic(selected: Int) {
    let resultString = options[selected]
    if resultString == options[compSelection] {
      result = false
      self.gameMessage = "You Tied"
    } else if (options[compSelection] == "scissors" && resultString == "shield")  ||
      (options[compSelection] == "map" && resultString == "scissors") ||
      (options[compSelection] == "shield" && resultString == "map") {
      result = true
      gameMessage = "You Won"
      score += 1
    } else {
      result = false
      gameMessage = "You Loss"
      score -= 1
    }
  }
}

struct RPS_Preview: PreviewProvider {
  static var previews: some View {
    RPS()
  }
}
