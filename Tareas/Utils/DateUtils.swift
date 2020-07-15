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
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
        return formatter
    }
    
    static func displayDate(for date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    static func getDateFromString(for stringDate: String) -> Date? {
        return dateFormatter.date(from: stringDate)
    }
    
    static func tomorrow() -> Date {
        var dateComponents = DateComponents()
        dateComponents.setValue(1, for: .day); // +1 day
        
        let now = Date() // Current date
        let tomorrow = Calendar.current.date(byAdding: dateComponents, to: now)  // Add the DateComponents
        
        return tomorrow!
    }
}
