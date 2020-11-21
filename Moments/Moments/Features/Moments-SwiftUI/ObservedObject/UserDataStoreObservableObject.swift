//
//  UserDataStoreObservableObject.swift
//  Moments
//
//  Created by Jake Lin on 21/11/20.
//

import Foundation
import Combine
import RxSwift

final class UserDataStoreObservableObject: ObservableObject {
    @Published var currentUser: UserDataStoreType = UserDataStore.current
}
