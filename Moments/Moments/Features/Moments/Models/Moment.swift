//
//  Moment.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation

struct Moment: Codable {
    let id: String
    let userDetails: UserDetails
    let type: MomentType
    let title: String?
    let url: String?
    let photos: [String]
    let createdDate: String
}
