//
//  UpdateMomentLikeSessionTests.swift
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

final class UpdateMomentLikeSessionTests: QuickSpec {
    override func spec() {
        describe("UpdateMomentLikeSession") {
            var testSubject: UpdateMomentLikeSession!
            var testScheduler: TestScheduler!
            var testObserver: TestableObserver<MomentsDetails>!
            var mockResponseEvent: Recorded<Event<UpdateMomentLikeSession.Response>>!
            var disposeBag: DisposeBag!

            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                testObserver = testScheduler.createObserver(MomentsDetails.self)
                disposeBag = DisposeBag()
            }

            context("updateLike(:momentID:userID:") {
                context("when response status code 200") {
                    beforeEach {
                        mockResponseEvent = .next(100, TestData.successResponse)
                        updateLike(mockEvent: mockResponseEvent)
                    }

                    it("should complete and map the response correctly") {
                        let expectedMomentsDetails = TestFixture.momentsDetails
                        let actualMomentsDetails = testObserver.events.first!.value.element!

                        expect(actualMomentsDetails).toEventually(equal(expectedMomentsDetails))
                    }
                }

                context("when response status code 200 with invalid data") {
                    let invalidJSONError: APISessionError = .invalidJSON

                    beforeEach {
                        mockResponseEvent = .error(100, invalidJSONError, UpdateMomentLikeSession.Response.self)
                        updateLike(mockEvent: mockResponseEvent)
                    }

                    it("should throw invalid json error") {
                        let actualError = testObserver.events.first!.value.error as! APISessionError
                        expect(actualError).toEventually(equal(.invalidJSON))
                    }
                }

                context("when response status code non-200") {
                    let networkError: APISessionError = .networkError(error: MockError(), statusCode: 500)

                    beforeEach {
                        mockResponseEvent = .error(100, networkError, UpdateMomentLikeSession.Response.self)
                        updateLike(mockEvent: mockResponseEvent)
                    }

                    it("should throw a network error") {
                        let actualError = testObserver.events.first!.value.error as! APISessionError
                        expect(actualError).toEventually(equal(networkError))
                    }
                }
            }

            func updateLike(mockEvent: Recorded<Event<UpdateMomentLikeSession.Response>>) {
                let testableObservable = testScheduler.createHotObservable([mockEvent])
                testSubject = UpdateMomentLikeSession { _ in testableObservable.asObservable() }
                testSubject.updateLike(true, momentID: "0", fromUserID: "1").subscribe(testObserver).disposed(by: disposeBag)
                testScheduler.start()
            }
        }
    }
}

private struct TestData {
    static let successResponse: UpdateMomentLikeSession.Response = {
        let response = try! JSONDecoder().decode(UpdateMomentLikeSession.Response.self,
                                               from: TestData.successjson.data(using: .utf8)!)
        return response
    }()

    static let successjson = """
    {
      "data": {
        "updateMomentLike": {
          "userDetails": {
            "id": "0",
            "name": "Jake Lin",
            "avatar": "https://avatars0.githubusercontent.com/u/573856?s=460&v=4",
            "backgroundImage": "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg"
          },
          "moments": [
            {
              "id": "0",
              "userDetails": {
                "name": "Taylor Swift",
                "avatar": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlk0dgrwcQ0FiTKdgR3atzstJ_wZC4gtPgOmUYBsLO2aa9ssXs"
              },
              "type": "PHOTOS",
              "title": "the pic is awesome",
              "photos": [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRisv-yQgXGrto6OxQxX62JyvyQGvRsQQ760g&usqp=CAU"
              ],
              "createdDate": "1605521360",
              "isLiked": true,
              "likes": [
                {
                  "id": "0",
                  "avatar": "https://avatars0.githubusercontent.com/u/573856?s=460&v=4"
                }
              ]
            },
            {
              "id": "1",
              "userDetails": {
                "name": "Mattt",
                "avatar": "https://pbs.twimg.com/profile_images/969321564050112513/fbdJZmEh_400x400.jpg"
              },
              "type": "PHOTOS",
              "title": "Low-level programming on iOS",
              "photos": [
                "https://i.pinimg.com/originals/15/27/3e/15273e2fa37cba67b5c539f254b26c21.png"
              ],
              "createdDate": "1605519980",
              "isLiked": false,
              "likes": [
                {
                  "id": "105",
                  "avatar": "https://randomuser.me/api/portraits/women/69.jpg"
                }
              ]
            }
          ]
        }
      }
    }
    """
}
