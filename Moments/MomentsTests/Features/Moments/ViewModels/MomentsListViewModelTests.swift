//
//  MomentsListViewModelTests.swift
//  MomentsTests
//
//  Created by Jake Lin on 18/11/20.
//

import Foundation

import Quick
import Nimble
import RxSwift
import RxTest

@testable import Moments

private class MockMomentsRepo: MomentsRepoType {
    var momentsDetails: BehaviorSubject<MomentsDetails?> = .init(value: nil)

    private(set) var getMomentsHasBeenCalled: Bool = false
    private(set) var passedUserID: String!

    func getMoments(userID: String) -> Observable<Void> {
        getMomentsHasBeenCalled = true
        passedUserID = userID
        return Observable.just(())
    }

    func updateLike(isLiked: Bool, momentID: String, fromUserID userID: String) -> Observable<Void> {
        return Observable.just(())
    }
}

final class MomentsListViewModelTests: QuickSpec {
    override func spec() {
        describe("MomentsListViewModel") {
            var testSubject: MomentsListViewModel!
            var mockMomentsRepo: MockMomentsRepo!
            var disposeBag: DisposeBag!

            beforeEach {
                mockMomentsRepo = MockMomentsRepo()
                disposeBag = DisposeBag()
                testSubject = MomentsListViewModel(userID: "1", momentsRepo: mockMomentsRepo)
            }

            context("executeQuery") {
                beforeEach {
                    testSubject.executeQuery().subscribe().disposed(by: disposeBag)
                }

                it("call `momentsRepo.getMoments` with the correct parameters") {
                    expect(mockMomentsRepo.getMomentsHasBeenCalled).to(beTrue())
                    expect(mockMomentsRepo.passedUserID).to(equal("1"))
                }
            }
        }
    }
}
