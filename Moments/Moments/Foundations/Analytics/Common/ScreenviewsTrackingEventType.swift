//
//  ScreenviewsTrackingEventType.swift
//  Moments
//
//  Created by Jake Lin on 5/11/20.
//

import Foundation

protocol ScreenviewsTrackingEventType: TrackingEvent {
    var screenName: String { get }
    var screenClass: String { get }
}
