//
//  MockTrackingRepo.swift
//  MomentsTests
//
//  Created by Jake Lin on 17/11/20.
//

import Foundation

@testable import Moments

class MockTrackingRepo: TrackingRepoType {
    func register(trackingProvider: TrackingProvider) { }

    func trackScreenviews(_ event: TrackingEventType) { }

    func trackEvent(_ event: TrackingEventType) { }

    private(set) var trackedActionEvent: TrackingEventType!

    func trackAction(_ event: TrackingEventType) {
        trackedActionEvent = event
    }
}
