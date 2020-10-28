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
    private struct Session: APISession {
        typealias ModelType = MomentsDetails

        let path = L10n.Development.graphqlPath
        let parameters: Parameters
        let headers: HTTPHeaders = .init()

        init(userID: String) {
            let variables: [AnyHashable: Encodable] = ["userID": userID]
            parameters = ["query": Self.query,
                          "variables": variables]
        }

        fileprivate func post() -> Observable<MomentsDetails> {
            return post(path, parameters: parameters, headers: headers)
        }

        private static let query = """
           query getMomentsDetailsByUserID($userID: ID!){
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
               }
             }
           }
        """
    }

    func getMoments(userID: String) -> Observable<MomentsDetails> {
        let session = Session(userID: userID)
        return session.post()
    }
}
