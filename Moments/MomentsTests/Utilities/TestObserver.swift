//
//  TestObserver.swift
//  MomentsTests
//
//  Created by Jake Lin on 17/11/20.
//

import Foundation
import RxSwift

class TestObserver<ElementType> : ObserverType {
    private(set) var events = [Event<ElementType>]()

    var isCompleted: Bool {
        return events.last?.isCompleted ?? false
    }

    var isStopEvent: Bool {
        return events.last?.isStopEvent ?? false
    }

    var lastElement: ElementType? {
        return events.last?.element
    }

    func on(_ event: Event<ElementType>) {
        events.append(event)
    }
}
