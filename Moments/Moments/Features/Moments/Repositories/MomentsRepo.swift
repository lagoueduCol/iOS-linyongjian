//
//  MomentsRepo.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation
import RxSwift

protocol MomentsRepoType {
    var momentsDetails: ReplaySubject<MomentsDetails> { get }

    func getMoments(userID: String) -> Observable<Void>
    func updateLike(isLiked: Bool, momentID: String, fromUserID userID: String) -> Observable<Void>
}

struct MomentsRepo: MomentsRepoType {
    private(set) var momentsDetails: ReplaySubject<MomentsDetails> = .create(bufferSize: 1)
    private let disposeBag: DisposeBag = .init()

    private let persistentDataStore: PersistentDataStoreType
    private let getMomentsByUserIDSession: GetMomentsByUserIDSessionType
    private let updateMomentLikeSession: UpdateMomentLikeSessionType

    static let shared: MomentsRepo = {
        return MomentsRepo(
            persistentDataStore: UserDefaultsPersistentDataStore.shared,
            getMomentsByUserIDSession: GetMomentsByUserIDSession(),
            updateMomentLikeSession: UpdateMomentLikeSession()
        )
    }()

    init(persistentDataStore: PersistentDataStoreType,
                 getMomentsByUserIDSession: GetMomentsByUserIDSessionType,
                 updateMomentLikeSession: UpdateMomentLikeSessionType) {
        self.persistentDataStore = persistentDataStore
        self.getMomentsByUserIDSession = getMomentsByUserIDSession
        self.updateMomentLikeSession = updateMomentLikeSession

        persistentDataStore
            .momentsDetails
            .subscribe(momentsDetails)
            .disposed(by: disposeBag)
    }

    func getMoments(userID: String) -> Observable<Void> {
        return getMomentsByUserIDSession
            .getMoments(userID: userID)
            .do(onNext: { persistentDataStore.save(momentsDetails: $0) })
            .map { _ in () }
            .catchErrorJustReturn(())
    }

    func updateLike(isLiked: Bool, momentID: String, fromUserID userID: String) -> Observable<Void> {
        return updateMomentLikeSession
            .updateLike(isLiked, momentID: momentID, fromUserID: userID)
            .do(onNext: { persistentDataStore.save(momentsDetails: $0) })
            .map { _ in () }
            .catchErrorJustReturn(())
    }
}
