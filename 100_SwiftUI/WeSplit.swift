//
//  WeSplit.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 3/26/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI

struct WeSplitView: View {
  @State private var checkAmount = ""
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 2
  let tipPercentages = [10, 15, 20, 25, 0]
  
  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPercentages[tipPercentage])
    
    let orderAmount = Double(checkAmount) ?? 0
    let tipValue = orderAmount / 100 * tipSelection
    return (orderAmount + tipValue) / peopleCount
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Amount", text: $checkAmount)
            .keyboardType(.decimalPad)
          
          Picker("Number of people", selection: $numberOfPeople) {
            ForEach(2 ..< 100) {
              Text("\($0) people")
            }
          }
        }
        
        Section(header: Text("How much tip do you want to leave?")) {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(0 ..< tipPercentages.count) {
              Text("\(self.tipPercentages[$0])%")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        
        Section(header: Text("Tip Amount Per Person")) {
          Text("$\(totalPerPerson, specifier: "%.2f")")
        }
      }
      .navigationBarTitle("WeSplit")
    }
  }
}

struct WeSplitView_Previews: PreviewProvider {
  static var previews: some View {
    WeSplitView()
  }
}
