import Foundation
import RxSwift

public func demo(of description: String, action: () -> Void) {
    print("\n——— Demo of:", description, "———")
    action()
}

public func getThreadName() -> String {
    if Thread.current.isMainThread {
        return "Main Thread"
    } else if let name = Thread.current.name {
        if name == "" {
          return "Unnamed Thread"
        }
        return name
    } else {
        return "Unknown Thread"
    }
}

public extension ObservableType {
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
