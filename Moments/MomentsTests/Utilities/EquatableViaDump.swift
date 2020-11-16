//
//  EquatableViaDump.swift
//  MomentsTests
//
//  Created by Jake Lin on 16/11/20.
//

import Foundation

public protocol EquatableViaDump: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool
}

public extension EquatableViaDump {
    static func == (lhs: Self, rhs: Self) -> Bool {
        var ldump = ""
        var rdump = ""
        dump(lhs, to: &ldump)
        dump(rhs, to: &rdump)
        return ldump == rdump
    }
}
