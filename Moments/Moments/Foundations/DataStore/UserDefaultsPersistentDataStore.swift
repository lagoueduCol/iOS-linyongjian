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

    private(set) var momentsDetails: BehaviorSubject<MomentsDetails?> = .init(value: nil)
    private let disposeBage: DisposeBag = .init()
    private let defaults = UserDefaults.standard
    private let momentsDetailsKey = String(describing: MomentsDetails.self)

    private init() {
        setupBindings()
    }

    func save(momentsDetails: MomentsDetails) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(momentsDetails) {
            defaults.set(encoded, forKey: momentsDetailsKey)
        }
    }
}

private extension UserDefaultsPersistentDataStore {
    func setupBindings() {
        defaults.rx
            .observe(Data.self, momentsDetailsKey)
            .compactMap { $0 }
            .map { try? JSONDecoder().decode(MomentsDetails.self, from:$0) }
            .compactMap { $0 }
            .subscribe(onNext: { momentsDetails.onNext($0) })
            .disposed(by: disposeBage)
    }
}
