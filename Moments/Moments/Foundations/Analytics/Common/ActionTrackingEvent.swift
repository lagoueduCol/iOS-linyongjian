//
//  ActionTrackingEvent.swift
//  Moments
//
//  Created by Jake Lin on 5/11/20.
//

import Foundation

protocol ActionTrackingEvent: TrackingEvent {
    var parameters: [String: Any] { get }
}
