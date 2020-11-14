//
//  API.swift
//  Moments
//
//  Created by Jake Lin on 25/10/20.
//

import Foundation

enum API {
    // swiftlint:disable force_try
    // swiftlint:disable force_unwrapping
    // swiftlint:disable no_hardcoded_strings
    static let baseURL = try! URL(string: "https://" + Configuration.value(for: "API_BASE_URL"))!
    // swiftlint:enable force_try
    // swiftlint:enable force_unwrapping
    // swiftlint:enable no_hardcoded_strings
}
