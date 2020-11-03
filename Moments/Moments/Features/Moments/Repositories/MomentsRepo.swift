//
//  MomentsRepo.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation
import RxSwift

protocol MomentsRepoType {
    var momentsDetails: PublishSubject<MomentsDetails> { get }

    func getMoments(userID: String) -> Observable<Void>
    func updateLike(isLiked: Bool, momentID: String, from userID: String) -> Observable<MomentsDetails>
}

struct MomentsRepo: MomentsRepoType {
    private(set) var momentsDetails: PublishSubject<MomentsDetails> = .init()
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

        momentsDetails.bind(to: persistentDataStore.momentsDetails).disposed(by: disposeBag)
    }

    func getMoments(userID: String) -> Observable<Void> {
        return getMomentsByUserIDSessionBuilder()
            .getMoments(userID: userID)
            .do(onNext: {
                persistentDataStore.save(momentsDetails: $0)
                momentsDetails.onNext($0)
            })
            .map { _ in () }
            .catchErrorJustReturn(())
    }

    func updateLike(isLiked: Bool, momentID: String, from userID: String) -> Observable<MomentsDetails> {
        updateMomentLikeSessionBuilder().updateLike(isLiked, momentID: momentID, userID: userID)
    }
}
