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
    func updateLike(momentID: String, from userID: String)
}

struct MomentsRepo: MomentsRepoType {
    private let getMomentsByUserIDSessionBuilder: () -> GetMomentsByUserIDSessionType

    static var shared: MomentsRepo = {
        return MomentsRepo(
            getMomentsByUserIDSessionBuilder: { GetMomentsByUserIDSession() }
        )
    }()

    init(getMomentsByUserIDSessionBuilder: @escaping () -> GetMomentsByUserIDSessionType) {
        self.getMomentsByUserIDSessionBuilder = getMomentsByUserIDSessionBuilder
    }

    func getMoments(userID: String) -> Observable<MomentsDetails> {
        getMomentsByUserIDSessionBuilder().getMoments(userID: userID)
    }

    func updateLike(momentID: String, from userID: String) {

    }
}
