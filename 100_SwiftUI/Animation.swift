//
//  animation.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 7/2/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
  let amount: Double
  let anchor: UnitPoint
  
  func body(content: Content) -> some View {
    content.rotationEffect(.degrees(amount), anchor: anchor)
      .clipped()
  }
}

extension AnyTransition {
  static var pivot: AnyTransition {
    .modifier(active: CornerRotateModifier(amount: -90, anchor: .topTrailing), identity: CornerRotateModifier(amount: 0, anchor: .topTrailing))
  }
  
  static var bottomPivot: AnyTransition {
    .modifier(active: CornerRotateModifier(amount: -90, anchor: .topTrailing), identity: CornerRotateModifier(amount: 0, anchor: .topTrailing))
  }
  
  
}

struct AnimationView: View {
  @State private var isShowingRed = false

  var body: some View {
    VStack{
      Button("Tap Me") {
        withAnimation {
          self.isShowingRed.toggle()
        }
      }
      
      if isShowingRed {
        Rectangle()
          .fill(Color.red)
          .frame(width: 200, height: 200)
          .transition(.asymmetric(insertion: .pivot, removal: .bottomPivot))
      }
    }
  }
}

struct Animation_Previews: PreviewProvider {
  static var previews: some View {
    AnimationView()
  }
}
