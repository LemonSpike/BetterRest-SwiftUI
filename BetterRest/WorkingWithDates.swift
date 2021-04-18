//
//  WorkingWithDates.swift
//  BetterRest
//
//  Created by Pranav Kasetti on 06/04/2021.
//

import SwiftUI

struct WorkingWithDates: View {
  
  var body: some View {
    Text("Hello, World!").onAppear {
      // BAD!!!
      let now = Date()
      let tomorrow = Date().addingTimeInterval(86400)
      let range = now ... tomorrow
      // BETTER!!
      var components = DateComponents()
      components.hour = 8
      components.minute = 0
      let date = Calendar.current.date(from: components) ?? Date()

      let newComponents = Calendar.current.dateComponents([.hour, .minute],
                                                       from: date)
      let hour = newComponents.hour ?? 0
      let minute = newComponents.minute ?? 0
    }
  }
}

struct WorkingWithDates_Previews: PreviewProvider {
  static var previews: some View {
    WorkingWithDates()
  }
}
