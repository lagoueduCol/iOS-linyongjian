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
}

struct MomentsRepo: MomentsRepoType {
    private let getMomentsByUserIDAPISessionBuilder: () -> GetMomentsByUserIDAPISessionType

    static var shared: MomentsRepo = {
        return MomentsRepo(
            getMomentsByUserIDAPISessionBuilder: { GetMomentsByUserIDAPISession() }
        )
    }()

    init(getMomentsByUserIDAPISessionBuilder: @escaping () -> GetMomentsByUserIDAPISessionType) {
        self.getMomentsByUserIDAPISessionBuilder = getMomentsByUserIDAPISessionBuilder
    }

    func getMoments(userID: String) -> Observable<MomentsDetails> {
        getMomentsByUserIDAPISessionBuilder().getMoments(userID: userID)
    }
}
