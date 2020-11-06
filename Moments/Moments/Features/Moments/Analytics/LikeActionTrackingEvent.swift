//
//  LikeActionTrackingEvent.swift
//  Moments
//
//  Created by Jake Lin on 5/11/20.
//

import Foundation
import FirebaseAnalytics

struct LikeActionTrackingEvent: ActionTrackingEventType {
    let momentID: String
    let userID: String
}

extension LikeActionTrackingEvent: FirebaseActionTrackingEvent {
    // swiftlint:disable no_hardcoded_strings
    var parameters: [String : Any] {
        return [
            AnalyticsParameterItemID: "moment-id-\(momentID)-user-id-\(userID)",
            AnalyticsParameterItemName: "moment-like"
        ]
    }
}
