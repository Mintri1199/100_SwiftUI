//
//  animation.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 7/2/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI

struct AnimationView: View {
  @State private var animationAmount: CGFloat = 1
  var body: some View {
    Button("Hello, World!") {
      self.animationAmount += 1
    }
    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 50)
    .background(Color.red)
    .foregroundColor(.white)
    .clipShape(Circle())
    .scaleEffect(animationAmount, anchor: .center)
    .animation(.default)
    .blur(radius: (animationAmount - 1) * 3)
  }
}

struct Animation_Previews: PreviewProvider {
  static var previews: some View {
    AnimationView()
  }
}
