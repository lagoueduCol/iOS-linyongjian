//
//  File.swift
//  Moments
//
//  Created by Jake Lin on 3/2/21.
//

import Foundation
import UIKit

protocol AppRouting {
    func register(path: String, navigator: Navigating)
    func route(to url: URL?, from routingSource: RoutingSource?, using transitionType: TransitionType)
}
