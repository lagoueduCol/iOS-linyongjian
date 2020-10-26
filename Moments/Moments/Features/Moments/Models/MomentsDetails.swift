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
}
