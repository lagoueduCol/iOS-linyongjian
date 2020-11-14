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
    var parameters: [String : Any] {
        // swiftlint:disable no_hardcoded_strings
        return [
            AnalyticsParameterItemID: "moment-id-\(momentID)-user-id-\(userID)",
            AnalyticsParameterItemName: "moment-like"
        ]
        // swiftlint:enable no_hardcoded_strings
    }
}
