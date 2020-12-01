//
//  DateUtils.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/02.
//

import Foundation

class DateUtils {
    static let shared = DateUtils()
    let calendar = Calendar.current
    
    func getYearFromDate(date:Date) -> String {
        return String(calendar.component(Calendar.Component.year, from: date))
    }
    
    func getMonthFromDate(date:Date) -> String {
        return String(calendar.component(Calendar.Component.month, from: date))
    }
    
    func getDayFromDate(date:Date) -> String {
        return String(calendar.component(Calendar.Component.day, from: date))
    }
    
    func convertStringDateToDate(stringDate:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        let date:Date = dateFormatter.date(from: stringDate)!
        return date
    }
}
