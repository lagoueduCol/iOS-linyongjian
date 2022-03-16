//
//  UserDataStoreObservableObject.swift
//  Moments
//
//  Created by Jake Lin on 21/11/20.
//

import Foundation

final class UserDataStoreObservableObject: ObservableObject {
    @Published var currentUser: UserDataStoreType = UserDataStore.current
}
