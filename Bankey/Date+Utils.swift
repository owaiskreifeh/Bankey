//
//  Date+Utild.swift
//  Bankey
//
//  Created by Owais Kreifeh on 19/06/2022.
//

import Foundation

extension Date {
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter();
        formatter.timeZone = TimeZone(abbreviation: "EET")
        return formatter;
    }
    
    var dayMonthYearString: String {
        let dateFormatter = Date.bankeyDateFormatter;
        dateFormatter.dateFormat = "E d MMM";
        return dateFormatter.string(from: self);
    }
}
