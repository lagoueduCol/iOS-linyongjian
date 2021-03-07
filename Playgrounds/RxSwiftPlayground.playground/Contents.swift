import UIKit
import RxSwift

let disposeBag: DisposeBag = .init()

// MARK: - Observable sequence
demo(of: "Observable sequence") {
    let numberObservable = Observable.of(9, 3, 2, 18, 3, 3, 11, 39)
    numberObservable.subscribe { event in
        print(event)
    }.disposed(by: disposeBag)
}


demo(of: "Observable with object") {
    struct Person {
        let name: String
        let income: Int
    }
    let peopleObservable = Observable.of(Person(name: "Jake", income: 10), Person(name: "Tom", income: 20))
    peopleObservable.subscribe { event in
        print(event)
    }.disposed(by: disposeBag)
}

// MARK: - Observable creators
demo(of: "Observable.just") {
    let observable1: Observable<Int> = Observable.just(1)
    observable1.subscribe { event in
        print(event)
    }.disposed(by: disposeBag)
}

demo(of: "Observable.of") {
    let observable2: Observable<Int> = Observable.of(1, 2, 3)
    observable2.subscribe { event in
        print(event)
    }.disposed(by: disposeBag)
}

demo(of: "Observable.of with array") {
    let observable3: Observable<[Int]> = Observable.of([1, 2, 3])
    observable3.subscribe { event in
        print(event)
    }.disposed(by: disposeBag)
}

demo(of: "Observable.from") {
    let observable4: Observable<Int> = Observable.from([1, 2, 3])
    observable4.subscribe { event in
        print(event)
    }.disposed(by: disposeBag)
}

// MARK: - Observer
demo(of: "Observer") {
    let observable = Observable.of(1, 2, 3)
    observable.subscribe { event in
        print(event)
    }.disposed(by: disposeBag)
}

demo(of: "Error event") {
    enum MyError: Error {
        case anError
    }

    Observable<Int>.create { observer in
        observer.onNext(1)
        observer.onNext(2)
        observer.onError(MyError.anError)
        observer.onNext(3)
        return Disposables.create()
    }.subscribe { event in
        print(event)
    }.disposed(by: disposeBag)
}

demo(of: "Completed event") {
    Observable<Int>.create { observer in
        observer.onNext(1)
        observer.onCompleted()
        observer.onNext(2)
        observer.onNext(3)
        return Disposables.create()
    }.subscribe { event in
        print(event)
    }.disposed(by: disposeBag)
}

demo(of: "Observable.empty") {
    let emptyObservable: Observable<Void> = Observable.empty()
    emptyObservable.subscribe { event in
        print(event)
    }.disposed(by: disposeBag)
}

demo(of: "Observable.never") {
    let neverObservable: Observable<Void> = Observable.never()
    neverObservable.subscribe { event in
        print(event)
    }.disposed(by: disposeBag)
}

// MARK: - DisposeBag
demo(of: "Disposable") {
    let disposable = Observable.of(1, 2).subscribe { element in
        print(element) // next event
    } onError: { error in
        print(error)
    } onCompleted: {
        print("Completed")
    } onDisposed: {
        print("Disposed")
    }
    disposable.dispose()
}

demo(of: "Disposable with delay") {
    let disposableWithDelay = Observable.of(1, 2).delay(.seconds(2), scheduler: MainScheduler.instance).subscribe { element in
        print(element) // next event
    } onError: { error in
        print(error)
    } onCompleted: {
        print("Completed")
    } onDisposed: {
        print("Disposed")
    }
    disposableWithDelay.dispose()
}

demo(of: "DisposeBag") {
    Observable.just(1).subscribe { event in
        print(event)
    }.disposed(by: disposeBag)

    Observable.of("a", "b").subscribe { event in
        print(event)
    }.disposed(by: disposeBag)
}

// MARK: - Subject
demo(of: "PublishSubject") {
    let publishSubject = PublishSubject<Int>()
    publishSubject.onNext(1)

    let observer1 = publishSubject.subscribe { event in
        print("observer1: \(event)")
    }
    observer1.disposed(by: disposeBag)

    publishSubject.onNext(2)

    let observer2 = publishSubject.subscribe { event in
        print("observer2: \(event)")
    }
    observer2.disposed(by: disposeBag)

    publishSubject.onNext(3)
    publishSubject.onCompleted()
    publishSubject.onNext(4)
}

demo(of: "BehaviorSubject") {
    let behaviorSubject = BehaviorSubject<Int>(value: 1)

    let observer1 = behaviorSubject.subscribe { event in
        print("observer1: \(event)")
    }
    observer1.disposed(by: disposeBag)

    behaviorSubject.onNext(2)

    let observer2 = behaviorSubject.subscribe { event in
        print("observer2: \(event)")
    }
    observer2.disposed(by: disposeBag)

    behaviorSubject.onNext(3)
    behaviorSubject.onCompleted()
    behaviorSubject.onNext(4)
}

demo(of: "ReplaySubject") {
    let replaySubject = ReplaySubject<Int>.create(bufferSize: 2)
    replaySubject.onNext(1)
    replaySubject.onNext(2)

    let observer1 = replaySubject.subscribe { event in
        print("observer1: \(event)")
    }
    observer1.disposed(by: disposeBag)

    replaySubject.onNext(3)

    let observer2 = replaySubject.subscribe { event in
        print("observer2: \(event)")
    }
    observer2.disposed(by: disposeBag)

    replaySubject.onNext(4)
    replaySubject.onCompleted()
    replaySubject.onNext(5)
}

// MARK: - Operator
demo(of: "filter") {
    Observable.of(2, 23, 5, 60, 1, 31)
        .filter { $0 > 10 }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

demo(of: "distinctUntilChanged") {
    Observable.of(1, 1, 2, 2, 1)
        .distinctUntilChanged()
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

demo(of: "map") {
    Observable.of(1, 2)
        .map { "String: " + String($0) }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

demo(of: "compactMap") {
    Observable.of("1", "not-a-number", "2")
        .compactMap { Int($0) }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}


demo(of: "flatMap") {
    struct TemperatureSensor {
      let temperature: Observable<Int>
    }

    let sensor1 = TemperatureSensor(temperature: Observable.of(21, 23))
    let sensor2 = TemperatureSensor(temperature: Observable.of(22, 25))

    Observable.of(sensor1, sensor2)
        .flatMap { $0.temperature }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

demo(of: "startWith") {
    Observable.of(1, 2)
        .startWith(3, 4)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

demo(of: "concat") {
    Observable.concat(Observable.of(1, 2), Observable.of(3, 4))
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

demo(of: "merge") {
    let first = PublishSubject<Int>()
    let second = PublishSubject<Int>()

    Observable.of(first, second)
        .merge()
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)

    first.onNext(1)
    first.onNext(2)
    second.onNext(11)
    first.onNext(3)
    second.onNext(12)
    second.onNext(13)
    first.onNext(4)
}

demo(of: "combineLatest") {
    let first = PublishSubject<String>()
    let second = PublishSubject<String>()

    Observable.combineLatest(first, second) { $0 + $1 }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)

    first.onNext("1")
    second.onNext("a")
    first.onNext("2")
    second.onNext("b")
    second.onNext("c")
    first.onNext("3")
    first.onNext("4")
}

demo(of: "zip") {
    let first = PublishSubject<String>()
    let second = PublishSubject<String>()

    Observable.zip(first, second) { $0 + $1 }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)

    first.onNext("1")
    second.onNext("a")
    first.onNext("2")
    second.onNext("b")
    second.onNext("c")
    first.onNext("3")
    first.onNext("4")
}

// MARK: - Scheduler
demo(of: "Scheduler") {
    Observable.of(1, 2, 3, 4)
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .dumpObservable()
        .map { "\(getThreadName()): \($0)" }
        .observeOn(MainScheduler.instance)
        .dumpObserver()
        .disposed(by: disposeBag)
}
