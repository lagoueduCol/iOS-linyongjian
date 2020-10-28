//
//  Moment.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation

struct MomentUserDetails: Codable {
    let name: String
    let avatar: String
}

struct Moment: Codable {
    let id: String
    let userDetails: MomentUserDetails
    let type: MomentType
    let title: String?
    let url: String?
    let photos: [String]
    let createdDate: String
}
