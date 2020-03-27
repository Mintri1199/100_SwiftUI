//
//  WeSplit.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 3/26/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI

struct WeSplitView: View {
  let students = ["Harry", "Hermione", "Ron"]
  @State private var selectedStudent = "Harry"
  var body: some View {
    Picker("Select your student", selection: $selectedStudent) {
      ForEach(0 ..< students.count) {
        Text("\(self.students[$0])") 
      }
    }
  }

}

struct WeSplitView_Previews: PreviewProvider {
    static var previews: some View {
        WeSplitView()
    }
}
