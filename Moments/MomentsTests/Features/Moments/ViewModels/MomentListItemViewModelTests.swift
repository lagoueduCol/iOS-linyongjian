//
//  MomentListItemViewModelTests.swift
//  MomentsTests
//
//  Created by Jake Lin on 17/11/20.
//

import Foundation

import Quick
import Nimble
import RxSwift
import RxTest

@testable import Moments

private class MockMomentsRepo: MomentsRepoType {
    var momentsDetails: BehaviorSubject<MomentsDetails?> = .init(value: nil)

    func getMoments(userID: String) -> Observable<Void> {
        return Observable.just(())
    }

    private(set) var passedIsLiked: Bool!
    private(set) var passedMomentID: String!
    private(set) var passedUserID: String!

    func updateLike(isLiked: Bool, momentID: String, from userID: String) -> Observable<Void> {
        passedIsLiked = isLiked
        passedMomentID = momentID
        passedUserID = userID
        return Observable.just(())
    }
}

private struct MockRelativeDateTimeFormatter: RelativeDateTimeFormatterType {
    var unitsStyle: RelativeDateTimeFormatter.UnitsStyle = .full

    func localizedString(for date: Date, relativeTo referenceDate: Date) -> String {
        return "3 days ago"
    }
}

final class MomentListItemViewModelTests: QuickSpec {
    override func spec() {
        describe("MomentListItemViewModel") {
            var testSubject: MomentListItemViewModel!
            var mockMomentsRepo: MockMomentsRepo!
            var mockTrackingRepo: MockTrackingRepo!
            var mockNow: Date!
            var disposeBag: DisposeBag!

            beforeEach {
                mockMomentsRepo = MockMomentsRepo()
                mockTrackingRepo = MockTrackingRepo()
                mockNow = MockNow.now
                disposeBag = DisposeBag()
            }

            context("init(userDetails:)") {
                context("when all data provided") {
                    beforeEach {
                        testSubject = MomentListItemViewModel(moment: TestFixture.moment, momentsRepo: mockMomentsRepo, trackingRepo: mockTrackingRepo, now: mockNow, relativeDateTimeFormatter: MockRelativeDateTimeFormatter())
                    }

                    it("should initialize the properties correctly") {
                        expect(testSubject.userAvatarURL).to(equal(URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlk0dgrwcQ0FiTKdgR3atzstJ_wZC4gtPgOmUYBsLO2aa9ssXs")))
                        expect(testSubject.userName).to(equal("Taylor Swift"))
                        expect(testSubject.title).to(equal("the pic is awesome"))
                        expect(testSubject.photoURL).to(equal(URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRisv-yQgXGrto6OxQxX62JyvyQGvRsQQ760g&usqp=CAU")))
                        expect(testSubject.postDateDescription).to(equal("3 days ago"))
                    }
                }

                context("when `moment.userDetails.avatar` is not a valid URL") {
                    beforeEach {
                        testSubject = MomentListItemViewModel(moment: MomentsDetails.Moment(id: "0", userDetails:  MomentsDetails.Moment.MomentUserDetails(name: "Taylor Swift", avatar: "this is not a valid URL"), type: MomentsDetails.Moment.MomentType.photos, title: "the pic is awesome", url: nil, photos: [ "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRisv-yQgXGrto6OxQxX62JyvyQGvRsQQ760g&usqp=CAU"], createdDate: "1605521360", isLiked: true, likes: [MomentsDetails.Moment.LikedUserDetails(id: "0", avatar: "https://avatars0.githubusercontent.com/u/573856?s=460&v=4")]), momentsRepo: mockMomentsRepo, trackingRepo: mockTrackingRepo, now: mockNow, relativeDateTimeFormatter: MockRelativeDateTimeFormatter())
                    }

                    it("`userAvatarURL` should be nil") {
                        expect(testSubject.userAvatarURL).to(beNil())
                    }
                }

                context("when `moment.photos` is empty") {
                    beforeEach {
                        testSubject = MomentListItemViewModel(moment: MomentsDetails.Moment(id: "0", userDetails:  MomentsDetails.Moment.MomentUserDetails(name: "Taylor Swift", avatar: "this is not a valid URL"), type: MomentsDetails.Moment.MomentType.photos, title: "the pic is awesome", url: nil, photos: [], createdDate: "1605521360", isLiked: true, likes: [MomentsDetails.Moment.LikedUserDetails(id: "0", avatar: "https://avatars0.githubusercontent.com/u/573856?s=460&v=4")]), momentsRepo: mockMomentsRepo, trackingRepo: mockTrackingRepo, now: mockNow, relativeDateTimeFormatter: MockRelativeDateTimeFormatter())
                    }

                    it("`photoURL` should be nil") {
                        expect(testSubject.photoURL).to(beNil())
                    }
                }
            }

            context("reuseIdentifier") {
                it("should return the view model's name") {
                    expect(MomentListItemViewModel.reuseIdentifier).to(equal("MomentListItemViewModel"))
                }
            }

            context("like(from:)") {
                beforeEach {
                    testSubject = MomentListItemViewModel(moment: TestFixture.moment, momentsRepo: mockMomentsRepo, trackingRepo: mockTrackingRepo, now: mockNow, relativeDateTimeFormatter: MockRelativeDateTimeFormatter())

                    testSubject.like(from: "1").subscribe().disposed(by: disposeBag)
                }

                it("should track with correct event") {
                    expect(mockTrackingRepo.trackedActionEvent).to(beAKindOf(LikeActionTrackingEvent.self))
                }

                it("should call `momentsRepo.updateLike` with correct parameters") {
                    expect(mockMomentsRepo.passedIsLiked).to(beTrue())
                    expect(mockMomentsRepo.passedMomentID).to(equal("0"))
                    expect(mockMomentsRepo.passedUserID).to(equal("1"))
                }
            }

            context("unlike(from:)") {
                beforeEach {
                    testSubject = MomentListItemViewModel(moment: TestFixture.moment, momentsRepo: mockMomentsRepo, trackingRepo: mockTrackingRepo, now: mockNow, relativeDateTimeFormatter: MockRelativeDateTimeFormatter())

                    testSubject.unlike(from: "1").subscribe().disposed(by: disposeBag)
                }

                it("should track with correct event") {
                    expect(mockTrackingRepo.trackedActionEvent).to(beAKindOf(UnlikeActionTrackingEvent.self))
                }

                it("should call `momentsRepo.updateLike` with correct parameters") {
                    expect(mockMomentsRepo.passedIsLiked).to(beFalse())
                    expect(mockMomentsRepo.passedMomentID).to(equal("0"))
                    expect(mockMomentsRepo.passedUserID).to(equal("1"))
                }
            }
        }
    }
}
