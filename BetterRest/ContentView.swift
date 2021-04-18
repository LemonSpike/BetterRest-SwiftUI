//
//  ContentView.swift
//  BetterRest
//
//  Created by Pranav Kasetti on 06/04/2021.
//

import SwiftUI

struct ContentView: View {

  @State private var sleepAmount = 8.0

  var body: some View {
    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
      Text("\(floor(sleepAmount), specifier: "%g") hours, \(sleepAmount.truncatingRemainder(dividingBy: 1) * 60, specifier: "%g") minutes")
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
