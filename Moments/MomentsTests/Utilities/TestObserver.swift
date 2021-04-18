//
//  TestObserver.swift
//  MomentsTests
//
//  Created by Jake Lin on 17/11/20.
//

import Foundation
import RxSwift

class TestObserver<ElementType>: ObserverType {
    private var lastEvent: Event<ElementType>?

    var lastElement: ElementType? {
        return lastEvent?.element
    }

    var lastError: Error? {
        return lastEvent?.error
    }

    var isCompleted: Bool {
        return lastEvent?.isCompleted ?? false
    }

    func on(_ event: Event<ElementType>) {
        lastEvent = event
    }
}
