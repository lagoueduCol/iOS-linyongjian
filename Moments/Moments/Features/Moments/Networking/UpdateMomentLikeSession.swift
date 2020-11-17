//
//  UpdateMomentLikeSession.swift
//  Moments
//
//  Created by Jake Lin on 3/11/20.
//

import Foundation
import Alamofire
import RxSwift

protocol UpdateMomentLikeSessionType {
    func updateLike(_ isLiked: Bool, momentID: String, userID: String) -> Observable<MomentsDetails>
}

// swiftlint:disable no_hardcoded_strings
struct UpdateMomentLikeSession: UpdateMomentLikeSessionType {
    struct Response: Codable {
        let data: Data

        struct Data: Codable {
            let updateMomentLike: MomentsDetails
        }
    }

    struct Session: APISession {
        typealias ReponseType = Response

        let path = L10n.Development.graphqlPath
        let parameters: Parameters
        let headers: HTTPHeaders = .init()

        init(momentID: String, userID: String, isLiked: Bool) {
            let variables: [AnyHashable: Encodable] = ["momentID": momentID,
                                                       "userID": userID,
                                                       "isLiked": isLiked]
            parameters = ["query": Self.query,
                          "variables": variables]
        }

        private static let query = """
           mutation updateMomentLike($momentID: ID!, $userID: ID!, $isLiked: Boolean!) {
             updateMomentLike(momentID: $momentID, userID: $userID, isLiked: $isLiked) {
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
                 isLiked
                 likes {
                   id
                   avatar
                 }
               }
             }
           }
        """
    }

    private let sessionHandler: (Session) -> Observable<Response>

    init(sessionHandler: @escaping (Session) -> Observable<Response> = {
        $0.post($0.path, parameters: $0.parameters, headers: $0.headers)
    }) {
        self.sessionHandler = sessionHandler
    }

    func updateLike(_ isLiked: Bool, momentID: String, userID: String) -> Observable<MomentsDetails> {
        let session = Session(momentID: momentID, userID: userID, isLiked: isLiked)
        return sessionHandler(session).map { $0.data.updateMomentLike }
    }
}
// swiftlint:enable no_hardcoded_strings
