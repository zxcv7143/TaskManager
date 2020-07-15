//
//  DateUtils.swift
//  Tareas
//
//  Created by Anton Zuev on 14/07/2020.
//

import Foundation

struct DateUtils {
  static var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
  }
  
  static func displayDate(for date: Date) -> String {
    return dateFormatter.string(from: date)
  }
}
