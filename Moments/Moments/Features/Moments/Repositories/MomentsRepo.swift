//
//  MomentsRepo.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation
import RxSwift

protocol MomentsRepoType {
    var momentsDetails: BehaviorSubject<MomentsDetails?> { get }

    func getMoments(userID: String) -> Observable<Void>
    func updateLike(isLiked: Bool, momentID: String, from userID: String) -> Observable<Void>
}

struct MomentsRepo: MomentsRepoType {
    private(set) var momentsDetails: BehaviorSubject<MomentsDetails?> = .init(value: nil)
    private let disposeBag: DisposeBag = .init()

    private let persistentDataStore: PersistentDataStoreType
    private let getMomentsByUserIDSessionBuilder: () -> GetMomentsByUserIDSessionType
    private let updateMomentLikeSessionBuilder: () -> UpdateMomentLikeSessionType

    static let shared: MomentsRepo = {
        return MomentsRepo(
            persistentDataStore: UserDefaultsPersistentDataStore.shared,
            getMomentsByUserIDSessionBuilder: { GetMomentsByUserIDSession() },
            updateMomentLikeSessionBuilder: { UpdateMomentLikeSession() }
        )
    }()

    private init(persistentDataStore: PersistentDataStoreType,
                 getMomentsByUserIDSessionBuilder: @escaping () -> GetMomentsByUserIDSessionType,
                 updateMomentLikeSessionBuilder: @escaping () -> UpdateMomentLikeSessionType) {
        self.persistentDataStore = persistentDataStore
        self.getMomentsByUserIDSessionBuilder = getMomentsByUserIDSessionBuilder
        self.updateMomentLikeSessionBuilder = updateMomentLikeSessionBuilder

        persistentDataStore.momentsDetails.compactMap { $0 }.subscribe(momentsDetails).disposed(by: disposeBag)
    }

    func getMoments(userID: String) -> Observable<Void> {
        return getMomentsByUserIDSessionBuilder()
            .getMoments(userID: userID)
            .do(onNext: { persistentDataStore.save(momentsDetails: $0) })
            .map { _ in () }
            .catchErrorJustReturn(())
    }

    func updateLike(isLiked: Bool, momentID: String, from userID: String) -> Observable<Void> {
        return updateMomentLikeSessionBuilder()
            .updateLike(isLiked, momentID: momentID, userID: userID)
            .do(onNext: { persistentDataStore.save(momentsDetails: $0) })
            .map { _ in () }
            .catchErrorJustReturn(())
    }
}
