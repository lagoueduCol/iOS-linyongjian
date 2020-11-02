//
//  UserDataStore.swift
//  Moments
//
//  Created by Jake Lin on 3/11/20.
//

import Foundation

protocol UserDataStoreType {
    var userID: String { get }
}

struct UserDataStore: UserDataStoreType {
    // Hardcode the user id to 1
    var userID: String {
        "1"
    }

    private init() { }

    static let current = UserDataStore()
}
