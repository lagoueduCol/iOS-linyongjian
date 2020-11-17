//
//  MockNow.swift
//  MomentsTests
//
//  Created by Jake Lin on 17/11/20.
//

import Foundation

struct MockNow { }

extension MockNow {
    static let now: Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.date(from: "2020/11/11 00:00:00")!
    }()
}
