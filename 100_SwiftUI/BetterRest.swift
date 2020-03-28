//
//  BetterRest.swift
//  100_SwiftUI
//
//  Created by Jackson Ho on 3/28/20.
//  Copyright © 2020 Jackson Ho. All rights reserved.
//

import SwiftUI


struct BetterRest: View {
  @State private var wakeUp = defaultWakeTime
  @State private var sleepAmount = 8.0
  @State private var coffeeAmount = 1
  @State private var sleepTimeMessage = ""
  
  var body: some View {
    NavigationView {
      Form {
        VStack(alignment: .leading, spacing: 0) {
          Text("Your ideal sleep time: \(sleepTimeMessage)")
            .font(.title)
        }
        VStack(alignment: .leading, spacing: 0) {
          Text("When do you want to wake up?")
            .font(.headline)
          
          DatePicker(selection: $wakeUp, displayedComponents: .hourAndMinute) {
            Text("Please enter a time")
          }
          .labelsHidden()
          .datePickerStyle(WheelDatePickerStyle())
          .onReceive([self.$wakeUp].publisher.first()) { (_) in
            self.sleepTimeMessage = self.calculateBedtime()
          }
        }
        
        VStack(alignment: .leading, spacing: 0) {
          Text("Desired amount of sleep")
            .font(.headline)
          
          Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
            Text("\(sleepAmount, specifier: "%g") hours")
          }
          .onReceive([self.$sleepAmount].publisher.first()) { _ in
            self.sleepTimeMessage = self.calculateBedtime()
          }
        }
        
        VStack(alignment: .leading, spacing: 0) {
          Text("Daily coffee intake")
          
          HStack {
            Spacer()
            Picker(selection: $coffeeAmount,
                   label: Text("Please choose a number for your daily coffee intake")) {
                    ForEach(1..<21) { number in
                      
                      Text(number == 1 ? "1 cup" : "\(number) cups")
                      Spacer()
                    }
                    
            }
              .pickerStyle(WheelPickerStyle())
              .labelsHidden()
              .onReceive([self.$sleepAmount].publisher.first()) { _ in
                self.sleepTimeMessage = self.calculateBedtime()
              }
            Spacer()
          }
        }
        
      }
      .navigationBarTitle("BetterRest")
    }
  }
  
  static var defaultWakeTime: Date {
    var components = DateComponents()
    components.hour = 7
    components.minute = 0
    return Calendar.current.date(from: components) ?? Date()
    
  }
  
  func calculateBedtime() -> String {
    let model = SleepCalculator()
    let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
    let minutes = (components.minute  ?? 0) * 60
    let hours = (components.hour ?? 0) * 60 * 60
    
    do {
      
      let predication = try  model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
      
      let sleepTime = wakeUp - predication.actualSleep
      
      let formatter = DateFormatter()
      formatter.timeStyle = .short
      return formatter.string(from: sleepTime)
      
    } catch {
      #if DEBUG
      print("Unable to generate prediction")
      #endif
      return  "Sorry, there was a problem calculating your bedtime."
    }
  }
}

struct BetterRest_Previews: PreviewProvider {
  static var previews: some View {
    BetterRest()
  }
}
