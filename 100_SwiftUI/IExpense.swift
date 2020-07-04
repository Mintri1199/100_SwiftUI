//
//  IExpense.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 7/4/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI

struct IExpenseView: View {
  @State private var enable = false
  
  var body: some View {
    VStack {
      Toggle(isOn: $enable.animation(), label: {
        Text("Toggle Opacity")
      })
      
      Circle()
        .foregroundColor(.red)
        .opacity(enable ? 1 : 0)
      
    }
  }
}

struct IExpense_Previews: PreviewProvider {
  static var previews: some View {
    IExpenseView()
  }
}
