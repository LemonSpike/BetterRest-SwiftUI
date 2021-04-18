//
//  DatesAndTimes.swift
//  BetterRest
//
//  Created by Pranav Kasetti on 06/04/2021.
//

import SwiftUI

struct DatesAndTimes: View {

  @State private var wakeUp = Date()

  var body: some View {
    Form {
      DatePicker("Please enter a date: ", selection: $wakeUp, in: Date()..., displayedComponents: .hourAndMinute)
    }
  }
}

struct DatesAndTimes_Previews: PreviewProvider {
  static var previews: some View {
    DatesAndTimes()
  }
}
