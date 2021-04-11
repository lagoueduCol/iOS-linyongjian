//
//  GetMomentsByUserIDSessionTests.swift
//  MomentsTests
//
//  Created by Jake Lin on 16/11/20.
//

import Foundation
import Quick
import Nimble
import RxSwift
import RxTest

@testable import Moments

extension MomentsDetails: EquatableViaDump { }
extension APISessionError: EquatableViaDump { }

private final class MockTogglesDataStore: TogglesDataStoreType {
    let isToggleOn: Bool

    init(isToggleOn: Bool) {
        self.isToggleOn = isToggleOn
    }

    func isToggleOn(_ toggle: ToggleType) -> Bool {
        return isToggleOn
    }

    func update(toggle: ToggleType, value: Bool) { }
}

final class GetMomentsByUserIDSessionTests: QuickSpec {
    override func spec() {
        describe("GetMomentsByUserIDSession") {
            var testSubject: GetMomentsByUserIDSession!
            var testScheduler: TestScheduler!
            var testObserver: TestableObserver<MomentsDetails>!
            var mockResponseEvent: Recorded<Event<GetMomentsByUserIDSession.Response>>!
            var mockInternalToggleDataStore: MockTogglesDataStore!
            var disposeBag: DisposeBag!

            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                testObserver = testScheduler.createObserver(MomentsDetails.self)
                disposeBag = DisposeBag()
            }

            context("getMoments(userID:)") {
                context("when response status code 200") {
                    beforeEach {
                        mockResponseEvent = .next(100, TestData.successResponse)
                        getMoments(mockEvent: mockResponseEvent)
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
                        mockResponseEvent = .error(100, invalidJSONError, GetMomentsByUserIDSession.Response.self)
                        getMoments(mockEvent: mockResponseEvent)
                    }

                    it("should throw invalid json error") {
                        let actualError = testObserver.events.first!.value.error as! APISessionError
                        expect(actualError).toEventually(equal(.invalidJSON))
                    }
                }

                context("when response status code non-200") {
                    let networkError: APISessionError = .networkError(error: MockError(), statusCode: 500)

                    beforeEach {
                        mockResponseEvent = .error(100, networkError, GetMomentsByUserIDSession.Response.self)
                        getMoments(mockEvent: mockResponseEvent)
                    }

                    it("should throw a network error") {
                        let actualError = testObserver.events.first!.value.error as! APISessionError
                        expect(actualError).toEventually(equal(networkError))
                    }
                }
            }

            context("feature toggles") {
                context("isLikeButtonForMomentEnabled") {
                    context("when is on") {
                        it("should set the query variables correctly") {
                            mockInternalToggleDataStore = MockTogglesDataStore(isToggleOn: true)
                            let testableObservable = testScheduler.createHotObservable([mockResponseEvent])
                            testSubject = GetMomentsByUserIDSession(togglesDataStore: mockInternalToggleDataStore) { session in
                                let variables = session.parameters["variables"] as! [String: Any?]

                                expect(variables["userID"] as? String).to(equal("1"))
                                expect(variables["withLikes"] as? Bool).to(beTrue())

                                return testableObservable.asObservable()
                            }

                            testSubject.getMoments(userID: "1").subscribe(testObserver).disposed(by: disposeBag)
                            testScheduler.start()
                        }
                    }

                    context("when is off") {
                        it("should set the query variables correctly") {
                            mockInternalToggleDataStore = MockTogglesDataStore(isToggleOn: false)
                            let testableObservable = testScheduler.createHotObservable([mockResponseEvent])
                            testSubject = GetMomentsByUserIDSession(togglesDataStore: mockInternalToggleDataStore) { session in
                                let variables = session.parameters["variables"] as! [String: Any?]

                                expect(variables["userID"] as? String).to(equal("1"))
                                expect(variables["withLikes"] as? Bool).to(beFalse())

                                return testableObservable.asObservable()
                            }

                            testSubject.getMoments(userID: "1").subscribe(testObserver).disposed(by: disposeBag)
                            testScheduler.start()
                        }
                    }
                }
            }

            func getMoments(mockEvent: Recorded<Event<GetMomentsByUserIDSession.Response>>) {
                let testableObservable = testScheduler.createHotObservable([mockEvent])
                testSubject = GetMomentsByUserIDSession { _ in testableObservable.asObservable() }
                testSubject.getMoments(userID: "0").subscribe(testObserver).disposed(by: disposeBag)
                testScheduler.start()
            }
        }
    }
}

private struct TestData {
    static let successResponse: GetMomentsByUserIDSession.Response = {
        let response = try! JSONDecoder().decode(GetMomentsByUserIDSession.Response.self,
                                               from: TestData.successjson.data(using: .utf8)!)
        return response
    }()

    static let successjson = """
    {
      "data": {
        "getMomentsDetailsByUserID": {
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
