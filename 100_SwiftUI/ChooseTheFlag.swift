//
//  ChooseTheFlag.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 3/26/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
  let imageString: String
  
  var body: some View {
    Image(imageString)
      .renderingMode(.original)
      .clipShape(Capsule())
      .overlay(Capsule().stroke(Color.black, lineWidth: 1))
      .shadow(color: .black, radius: 2)
  }
}

struct ChooseTheFlag: View {
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var selectedAnswer = 0
  @State private var userScore = 0
  @State private var opacityAmount = 1.0
  @State private var cellSpinArray = [0.0, 0.0, 0.0]
  @State private var cellOpacityBool = [true, true, true]
  @State private var incorrectOverlay = [false, false, false]
  
  @State private var correct = true
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
            FlagImage(imageString: self.countries[number])
              .rotation3DEffect(.degrees(cellSpinArray[number]), axis: (x: 0.0, y: 1.0, z: 0.0), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
              .opacity(cellOpacityBool[number] ? 1.0 : 0.25)
              .overlay(Color.red.opacity(incorrectOverlay[number] ? 0.75 : 0).clipShape(Capsule()))
          }
        }
        
        Text("Score: \(userScore)")
          .foregroundColor(.white)
          .font(.largeTitle)
          .fontWeight(.black)
        Spacer()
      }
    }
    .alert(isPresented: self.$showingScore) {
      Alert(title: Text(self.scoreTitle),
            message: Text("That was the flag of \(countries[selectedAnswer])"),
            dismissButton: .default(Text("Continue")) {
              self.askQuestion()
            })
    }
    
    
  }
  func flagTapped(_ number: Int) {
    let alertDelay = 1.5
    if number == correctAnswer {
      scoreTitle = "Correct"
      userScore += 1
      correct = true
      
      withAnimation(.default) {
        self.cellSpinArray[number] += 360
        
        for i in 0..<3 {
          if i != number {
            self.cellOpacityBool[i] = false
          }
        }
      }
      
    } else {
      scoreTitle = "Wrong"
      userScore -= 1
      correct = false
      
      withAnimation(.default) {
        self.incorrectOverlay[number] = true
        
        for i in 0..<3 {
          if i != number {
            self.cellOpacityBool[i] = false
          }
        }
      }
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + alertDelay) {
      self.showingScore = true
    }
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    cellSpinArray = [0.0, 0.0, 0.0]
    cellOpacityBool = [true, true , true]
    incorrectOverlay = [false, false, false]
  }
}


struct ChooseTheFlag_Preview: PreviewProvider {
  static var previews: some View {
    ChooseTheFlag()
  }
}
