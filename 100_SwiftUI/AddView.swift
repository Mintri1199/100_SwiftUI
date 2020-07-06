//
//  AddView.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 7/4/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI

struct AddView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var expenses: Expenses
  @State private var showError = false
  @State private var errorTitle = ""
  @State private var errorMessage = ""
  @State private var name = ""
  @State private var type = "Personal"
  @State private var amount = ""
  
  static let types = ["Business", "Personal"]
  
  var body: some View {
    NavigationView {
      Form {
        TextField("Name", text: $name)
        Picker("Type", selection: $type) {
          ForEach(Self.types, id: \.self) {
            Text($0)
          }
        }
        
        TextField("Amount", text: $amount)
          .keyboardType(.numberPad)
        
      }
      
      .navigationBarTitle("Add new expense")
      .navigationBarItems(trailing: Button(action: validation, label: { Text("Save") }))
    }
    .alert(isPresented: $showError) {
      Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .destructive(Text("OK")))
    }
  }
  func validation() {
    if let actualAmount = Int(self.amount) {
      let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
      self.expenses.items.append(item)
      presentationMode.wrappedValue.dismiss()
    } else {
      errorTitle = "Invalid Input"
      errorMessage = "Expense Amount is not a number"
      showError = true
    }
    
  }
}
struct AddView_Previews: PreviewProvider {
  static var previews: some View {
    AddView(expenses: Expenses())
  }
}
