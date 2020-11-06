//
//  ActionTrackingEventType.swift
//  Moments
//
//  Created by Jake Lin on 5/11/20.
//

import Foundation

protocol ActionTrackingEventType: TrackingEventType {
    var parameters: [String: Any] { get }
}
