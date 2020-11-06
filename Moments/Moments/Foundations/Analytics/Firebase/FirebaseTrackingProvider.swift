//
//  FirebaseTrackingProvider.swift
//  Moments
//
//  Created by Jake Lin on 5/11/20.
//

import Foundation
import FirebaseAnalytics

struct FirebaseTrackingProvider: TrackingProvider {
    func trackScreenviews(_ event: TrackingEventType) {
        guard let event = event as? ScreenviewsTrackingEvent else {
            return
        }

        // If need to send out this event manually, set `FirebaseAutomaticScreenReportingEnabled` to `Boolean(NO)` in Info.plist
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                            AnalyticsParameterScreenName: event.screenName,
                            AnalyticsParameterScreenClass: event.screenClass])
    }

    func trackEvent(_ event: TrackingEventType) {
        guard let event = event as? TrackingEvent else {
            return
        }

        Analytics.logEvent(event.name, parameters: event.parameters)
    }

    func trackAction(_ event: TrackingEventType) {
        guard let event = event as? FirebaseActionTrackingEvent else {
            return
        }

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: event.parameters)
    }
}
