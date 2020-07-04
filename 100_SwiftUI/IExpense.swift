//
//  IExpense.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 7/4/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
  @Published var firstName: String = "Bilbo"
  @Published var lastName: String = "Baggins"
}

struct SecondView: View {
  @Environment(\.presentationMode) var presenationMode
  var name: String
  var body: some View {
    Button("Dismiss") {
      self.presenationMode.wrappedValue.dismiss()
    }
  }
}

struct ExpenseItem : Identifiable, Codable {
  let id = UUID()
  let name: String
  let type: String
  let amount: Int
}

class Expenses: ObservableObject {
  @Published var items: [ExpenseItem] {
    didSet {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(items) {
        UserDefaults.standard.set(encoded, forKey: "Items")
      }
    }
  }
  
  init() {
    if let items = UserDefaults.standard.data(forKey: "Items") {
      let decoder = JSONDecoder()
      if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
        self.items = decoded
        return
      }
    }
    
    self.items = []
  }
}

struct IExpenseView: View {
  @ObservedObject var expenses = Expenses()
  @ObservedObject private var user = User()
  @State private var showingAddExpense = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(expenses.items, id: \.id) { item in
          HStack {
            VStack(alignment: .leading) {
              Text(item.name)
                .font(.headline)
              
              Text(item.type)
            }
            
            Spacer()
            Text("$\(item.amount)")
          }
          
          
        }.onDelete(perform: removeItems)
      }
      
      .navigationBarTitle("iExpense")
      .navigationBarItems(trailing:
                            Button(action: {
                              self.showingAddExpense = true
                            }, label: {
                              Image(systemName: "plus")
                            })
      )
    }.sheet(isPresented: $showingAddExpense) {
      AddView(expenses: self.expenses)
    }
    
  }
  
  func removeItems(at offsets: IndexSet) {
    expenses.items.remove(atOffsets: offsets)
  }
}

struct IExpense_Previews: PreviewProvider {
  static var previews: some View {
    IExpenseView()
  }
}
