//
//  ChooseTheFlag.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 3/26/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI

struct ChooseTheFlag: View {
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var selectedAnswer = 0
  @State private var userScore = 0
  @State private var correct = false
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
      
      VStack(spacing: 30) {
        VStack {
          Text("Tap the flag of")
            .foregroundColor(.white)
          
          Text(countries[correctAnswer])
            .foregroundColor(.white)
            .font(.largeTitle)
            .fontWeight(.black)
        }
        
        ForEach(0 ..< 3) { number in
          Button(action: {
            self.selectedAnswer = number
            self.flagTapped(number)
          }) {
            Image(self.countries[number])
              .renderingMode(.original)
              .clipShape(Capsule())
              .overlay(Capsule().stroke(Color.black, lineWidth: 1))
              .shadow(color: .black, radius: 2)
          }
          
        }
        
        Text("Score: \(userScore)")
        .foregroundColor(.white)
        .font(.largeTitle)
        .fontWeight(.black)
        Spacer()
      }
    }.alert(isPresented: self.$showingScore) {
      Alert(title: Text(self.scoreTitle), message: Text("That was the flag of \(countries[selectedAnswer])"), dismissButton: .default(Text("Continue")) {
        self.askQuestion()
        })
    }
  }
  
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      userScore += 1
      correct = true
    } else {
      scoreTitle = "Wrong"
      userScore -= 1
      correct = false
    }
    showingScore = true
    
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
}

struct ChooseTheFlag_Preview: PreviewProvider {
  static var previews: some View {
    ChooseTheFlag()
  }
}
