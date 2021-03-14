//
//  GetMomentsByUserIDSession.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation
import Alamofire
import RxSwift

protocol GetMomentsByUserIDSessionType {
    func getMoments(userID: String) -> Observable<MomentsDetails>
}

// swiftlint:disable no_hardcoded_strings
struct GetMomentsByUserIDSession: GetMomentsByUserIDSessionType {
    struct Response: Codable {
        let data: Data

        struct Data: Codable {
            let getMomentsDetailsByUserID: MomentsDetails
        }
    }

    struct Session: APISession {
        typealias ReponseType = Response

        let path = L10n.Development.graphqlPath
        let parameters: Parameters
        let headers: HTTPHeaders = .init()

        init(userID: String, togglesDataStore: TogglesDataStoreType) {
            let variables: [AnyHashable: Encodable] = ["userID": userID,
                                                       "withLikes": togglesDataStore.isToggleOn(InternalToggle.isLikeButtonForMomentEnabled)]
            parameters = ["query": Self.query,
                          "variables": variables]
        }

        private static let query = """
           query getMomentsDetailsByUserID($userID: ID!, $withLikes: Boolean!) {
             getMomentsDetailsByUserID(userID: $userID) {
               userDetails {
                 id
                 name
                 avatar
                 backgroundImage
               }
               moments {
                 id
                 userDetails {
                   name
                   avatar
                 }
                 type
                 title
                 photos
                 createdDate
                 isLiked @include(if: $withLikes)
                 likes @include(if: $withLikes) {
                   id
                   avatar
                 }
               }
             }
           }
        """
    }

    private let togglesDataStore: TogglesDataStoreType
    private let sessionHandler: (Session) -> Observable<Response>

    init(togglesDataStore: TogglesDataStoreType = InternalTogglesDataStore.shared, sessionHandler: @escaping (Session) -> Observable<Response> = {
        $0.post($0.path, headers: $0.headers, parameters: $0.parameters)
    }) {
        self.togglesDataStore = togglesDataStore
        self.sessionHandler = sessionHandler
    }

    func getMoments(userID: String) -> Observable<MomentsDetails> {
        let session = Session(userID: userID, togglesDataStore: togglesDataStore)
        return sessionHandler(session).map { $0.data.getMomentsDetailsByUserID }
    }
}
// swiftlint:enable no_hardcoded_strings
