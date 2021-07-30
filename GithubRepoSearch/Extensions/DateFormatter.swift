//
//  DateFormatter.swift
//  GithubRepoSearch
//
//  Created by Koushal, Kumar Ajitesh | Ajitesh | TDD on 2021/07/30.
//

import Foundation

public extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let dateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    static func string(iso string: String) -> String {
        let date = DateFormatter.iso8601Full.date(from: string)!
        return  DateFormatter.dateOnly.string(from: date)
    }
}
