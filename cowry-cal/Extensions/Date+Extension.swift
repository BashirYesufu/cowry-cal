//
//  Date+Extension.swift
//  cowry-cal
//
//  Created by Bash on 13/07/2023.
//

import Foundation

extension Date {
    static func getDate(forLastNDays nDays: Int) -> [String] {
        let cal = Calendar.current
        // start with today
        var date = cal.startOfDay(for: Date())
        
        var arrDates = [String]()
        
        for _ in 1 ... nDays {
            // move back in time by one day:
            date = cal.date(byAdding: Calendar.Component.day, value: -1, to: date)!
            print(date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            arrDates.append(dateString)
        }
        return arrDates
    }
}
