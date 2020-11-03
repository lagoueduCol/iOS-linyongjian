//
//  MomentsRepo.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation
import RxSwift

protocol MomentsRepoType {
    func getMoments(userID: String) -> Observable<MomentsDetails>
    func updateLike(isLiked: Bool, momentID: String, from userID: String) -> Observable<MomentsDetails>
}

struct MomentsRepo: MomentsRepoType {
    private let getMomentsByUserIDSessionBuilder: () -> GetMomentsByUserIDSessionType
    private let updateMomentLikeSessionBuilder: () -> UpdateMomentLikeSessionType

    static var shared: MomentsRepo = {
        return MomentsRepo(
            getMomentsByUserIDSessionBuilder: { GetMomentsByUserIDSession() },
            updateMomentLikeSessionBuilder: { UpdateMomentLikeSession() }
        )
    }()

    init(getMomentsByUserIDSessionBuilder: @escaping () -> GetMomentsByUserIDSessionType,
         updateMomentLikeSessionBuilder: @escaping () -> UpdateMomentLikeSessionType) {
        self.getMomentsByUserIDSessionBuilder = getMomentsByUserIDSessionBuilder
        self.updateMomentLikeSessionBuilder = updateMomentLikeSessionBuilder
    }

    func getMoments(userID: String) -> Observable<MomentsDetails> {
        getMomentsByUserIDSessionBuilder().getMoments(userID: userID)
    }

    func updateLike(isLiked: Bool, momentID: String, from userID: String) -> Observable<MomentsDetails> {
        updateMomentLikeSessionBuilder().updateLike(isLiked, momentID: momentID, userID: userID)
    }
}
