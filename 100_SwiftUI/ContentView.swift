//
//  ContentView.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 3/26/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      List(0..<5) { item in
        HStack {
          Text("\(item)")
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
