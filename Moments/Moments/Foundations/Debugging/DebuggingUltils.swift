//
//  DebuggingUltils.swift
//  Moments
//
//  Created by Jake Lin on 15/3/21.
//

import Foundation
import RxSwift

// swiftlint:disable no_hardcoded_strings
func getThreadName() -> String {
    if Thread.current.isMainThread {
        return "Main Thread"
    } else if let name = Thread.current.name {
        if name.isEmpty {
          return "Unnamed Thread"
        }
        return name
    } else {
        return "Unknown Thread"
    }
}

extension ObservableType {
    func dumpObservable() -> Observable<Element> {
        return self.do(onNext: { element in
            print("[Observable] \(element) emitted on \(getThreadName())")
        })
    }

    func dumpObserver() -> Disposable {
        return self.subscribe(onNext: { element in
            print("[Observer] \(element) received on \(getThreadName())")
        })
    }
}

// swiftlint:enable no_hardcoded_strings
