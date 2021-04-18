//
//  Challenge.swift
//  BetterRest
//
//  Created by Pranav Kasetti on 07/04/2021.
//

import SwiftUI

struct Challenge: View {

  @State var wakeUp = defaultWakeTime
  @State private var sleepAmount = 8.0
  @State private var coffeeAmount = 1
  private var coffeeIntakeString: String {
    if coffeeAmount == 1 {
      return "1 cup"
    } else {
      return "\(coffeeAmount) cups"
    }
  }

  @State private var alertTitle = ""
  @State private var alertMessage = ""


  static var defaultWakeTime: Date {
    var components = DateComponents()
    components.hour = 7
    components.minute = 0
    return Calendar.current.date(from: components) ?? Date()
  }

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("When do you want to wake up?").font(.headline)) {


          DatePicker("Please enter a time", selection: $wakeUp,
                     displayedComponents: .hourAndMinute)
            .labelsHidden()
            .datePickerStyle(WheelDatePickerStyle())
            .onChange(of: wakeUp, perform: { value in
              calculateBedtime()
            })
        }

        Section(header: Text("Desired amount of sleep")
                  .font(.headline)
                  .padding()) {

          Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
            Text("\(sleepAmount, specifier: "%g") hours")
          }
          .onChange(of: sleepAmount, perform: { value in
            calculateBedtime()
          })
          .padding()
        }

        Section(header: Text("Daily coffee intake")
                  .font(.headline)) {

          Picker(coffeeIntakeString, selection: $coffeeAmount) {
            ForEach(0..<9) { num in
              if num == 1 {
                Text("\(num) cup")
              } else {
                Text("\(num) cups")
              }
            }
          }
          .onChange(of: coffeeAmount, perform: { value in
            calculateBedtime()
          })
          .padding()
        }

        Section(header: Text("Recommended Bedtime")) {
          Text(alertTitle)
          Text(alertMessage).font(.largeTitle)
        }
      }
      .onAppear {
        calculateBedtime()
      }
      .navigationBarTitle("BetterRest")
    }
  }

  func calculateBedtime() {
    let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
    let hour = (components.hour ?? 0) * 60 * 60
    let minute = (components.minute ?? 0) * 60
    do {
      let model = try SleepCalculator(configuration: .init())
      let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
      let sleepTime = wakeUp - prediction.actualSleep

      let formatter = DateFormatter()
      formatter.timeStyle = .short

      alertMessage = formatter.string(from: sleepTime)
      alertTitle = "Your ideal bedtime is…"
    } catch {
      alertTitle = "Error"
      alertMessage = "Sorry, there was a problem calculating your bedtime."
    }
  }
}

struct Challenge_Previews: PreviewProvider {
  static var previews: some View {
    Challenge()
  }
}
