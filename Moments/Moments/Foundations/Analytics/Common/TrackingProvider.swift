//
//  TrackingProvider.swift
//  Moments
//
//  Created by Jake Lin on 5/11/20.
//

import Foundation

protocol TrackingProvider {
    func trackScreenviews(_ event: TrackingEventType)
    func trackEvent(_ event: TrackingEventType)
    func trackAction(_ event: TrackingEventType)
}
