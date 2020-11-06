//
//  TrackingEvent.swift
//  Moments
//
//  Created by Jake Lin on 6/11/20.
//

import Foundation

// Can send any event name with any parameters
struct TrackingEvent: TrackingEventType {
    let name: String
    let parameters: [String: Any]
}
