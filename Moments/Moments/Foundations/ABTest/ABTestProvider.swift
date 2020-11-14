//
//  ABTestProvider.swift
//  Moments
//
//  Created by Jake Lin on 14/11/20.
//

import Foundation

enum LikeButtonStyle: String {
    case heart, star
}

protocol ABTestProvider {
    var likeButtonStyle: LikeButtonStyle? { get }
}
