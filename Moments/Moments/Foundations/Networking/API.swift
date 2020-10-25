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
    static let baseURL = try! URL(string: Configuration.value(for: "API_BASE_URL"))!
}
