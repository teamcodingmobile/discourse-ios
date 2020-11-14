//
//  Date+Extension.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 14/11/2020.
//

import Foundation

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date) > 0 {
            return NSLocalizedString("date_offset.years", comment: "").replacingOccurrences(of: "%u", with: String(years(from: date)))
        }
        
        if months(from: date) > 0 {
            return NSLocalizedString("date_offset.months", comment: "").replacingOccurrences(of: "%u", with: String(months(from: date)))
        }
        
        if weeks(from: date) > 0 {
            return NSLocalizedString("date_offset.weeks", comment: "").replacingOccurrences(of: "%u", with: String(weeks(from: date)))
        }
        
        if days(from: date) > 0 {
            return NSLocalizedString("date_offset.days", comment: "").replacingOccurrences(of: "%u", with: String(days(from: date)))
        }
        
        if hours(from: date) > 0 {
            return NSLocalizedString("date_offset.hours", comment: "").replacingOccurrences(of: "%u", with: String(hours(from: date)))
        }
        
        if minutes(from: date) > 0 {
            return NSLocalizedString("date_offset.minutes", comment: "").replacingOccurrences(of: "%u", with: String(minutes(from: date)))
        }
        
        if seconds(from: date) > 0 {
            return NSLocalizedString("date_offset.seconds", comment: "").replacingOccurrences(of: "%u", with: String(seconds(from: date)))
        }
        
        return ""
    }
}
