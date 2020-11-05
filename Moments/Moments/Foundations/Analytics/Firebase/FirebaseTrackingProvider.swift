//
//  FirebaseTrackingProvider.swift
//  Moments
//
//  Created by Jake Lin on 5/11/20.
//

import Foundation
import FirebaseAnalytics

struct FirebaseTrackingProvider: TrackingProvider {
    func trackScreenviews(_ event: TrackingEvent) {
        guard let event = event as? ScreenviewsTrackingEvent else {
            return
        }

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                            AnalyticsParameterScreenName: event.screenName,
                            AnalyticsParameterScreenClass: event.screenClass])
    }

    func trackAction(_ event: TrackingEvent) {
        guard let event = event as? FirebaseActionTrackingEvent else {
            return
        }

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: event.parameters)
    }
}
