//
//  Date.swift
//  Sky
//
//  Created by Qing ’s on 2019/2/12.
//  Copyright © 2019 Qing's. All rights reserved.
//

import Foundation

extension Date {
    static func from(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+8:00")
        return dateFormatter.date(from: string)!
    }
}
