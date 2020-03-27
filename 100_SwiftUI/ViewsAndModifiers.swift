//
//  ViewsAndModifiers.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 3/27/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
  let rows: Int
  let columns: Int
  let content: (Int, Int) -> Content
  
  var body: some View {
    VStack {
      ForEach(0 ..< rows) { row in
        HStack {
          ForEach(0 ..< self.columns) { column in
            self.content(row, column)
          }
        }
      }
    }
  }
  init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
    self.rows = rows
    self.columns = columns
    self.content = content
  }
}

struct blueTitle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundColor(.blue)
  }
}

extension View {
  func blueStyle() -> some View {
    self.modifier(blueTitle())
  }
}

struct ViewsAndModifiers: View {
  var body: some View {
    GridStack(rows: 4, columns: 4) { row, col in
      Image(systemName: "\(row * 4 + col).circle")
      Text("R\(row) C\(col)")
      .blueStyle()
    }
  }
}

struct ViewsAndModifiers_Previews: PreviewProvider {
  static var previews: some View {
    ViewsAndModifiers()
  }
}
