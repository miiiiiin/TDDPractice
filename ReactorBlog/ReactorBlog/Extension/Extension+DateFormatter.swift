//
//  Extension+DateFormatter.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Foundation

extension DateFormatter {
    
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.autoupdatingCurrent
        return formatter
    }()
}
