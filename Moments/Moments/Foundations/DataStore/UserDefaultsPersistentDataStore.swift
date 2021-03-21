//
//  UserDefaultsPersistentDataStore.swift
//  Moments
//
//  Created by Jake Lin on 3/11/20.
//

import Foundation
import RxSwift

struct UserDefaultsPersistentDataStore: PersistentDataStoreType {
    static let shared: UserDefaultsPersistentDataStore = .init()

    private(set) var momentsDetails: ReplaySubject<MomentsDetails> = .create(bufferSize: 1)
    private let disposeBage: DisposeBag = .init()
    private let defaults = UserDefaults.standard
    private let momentsDetailsKey = String(describing: MomentsDetails.self)

    private init() {
        setupBindings()
    }

    func save(momentsDetails: MomentsDetails) {
        if let encodedData = try? JSONEncoder().encode(momentsDetails) {
            defaults.set(encodedData, forKey: momentsDetailsKey)
        }
    }
}

private extension UserDefaultsPersistentDataStore {
    func setupBindings() {
        defaults.rx
            .observe(Data.self, momentsDetailsKey)
            .compactMap { $0 }
            .compactMap { try? JSONDecoder().decode(MomentsDetails.self, from: $0) }
            .subscribe(momentsDetails)
            .disposed(by: disposeBage)
    }
}
