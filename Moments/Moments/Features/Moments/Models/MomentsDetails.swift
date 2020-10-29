//
//  MomentsDetails.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation

struct MomentsDetails: Codable {
    let userDetails: UserDetails
    let moments: [Moment]

    struct UserDetails: Codable {
        let id: String
        let name: String
        let avatar: String
        let backgroundImage: String
    }

    struct Moment: Codable {
        let id: String
        let userDetails: MomentUserDetails
        let type: MomentType
        let title: String?
        let url: String?
        let photos: [String]
        let createdDate: String

        struct MomentUserDetails: Codable {
            let name: String
            let avatar: String
        }

        // swiftlint:disable no_hardcoded_strings
        enum MomentType: String, Codable {
            case url = "URL"
            case photos = "PHOTOS"
        }
    }
}
