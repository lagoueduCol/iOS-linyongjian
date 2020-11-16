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
import Alamofire

@testable import Moments

extension MomentsDetails: EquatableViaDump { }

final class GetMomentsByUserIDSessionTests: QuickSpec {
    override func spec() {
        describe("GetMomentsByUserIDSession") {
            var testSubject: GetMomentsByUserIDSession!
            var testScheduler: TestScheduler!
            var observer: TestableObserver<MomentsDetails>!
            var mockResponseEvent: Recorded<Event<GetMomentsByUserIDSession.Response>>!
            var disposeBag: DisposeBag!

            beforeEach {
                testSubject = GetMomentsByUserIDSession()
                testScheduler = TestScheduler(initialClock: 0)
                observer = testScheduler.createObserver(MomentsDetails.self)
                disposeBag = DisposeBag()
            }

            context("getMoments(userID:)") {
                context("on response status code 200") {
                    beforeEach {
                        mockResponseEvent = .next(100, TestData.successResponse)
                        getMoments(mockResponseEvent)
                    }

                    it("should complete and map the response correctly") {
                        let expectedUserDetails = MomentsDetails.UserDetails(id: "0", name: "Jake Lin", avatar: "https://avatars0.githubusercontent.com/u/573856?s=460&v=4", backgroundImage: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg")
                        let expectedMoments = [
                            MomentsDetails.Moment(id: "0",
                                                  userDetails:  MomentsDetails.Moment.MomentUserDetails(name: "Taylor Swift", avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlk0dgrwcQ0FiTKdgR3atzstJ_wZC4gtPgOmUYBsLO2aa9ssXs"), type: MomentsDetails.Moment.MomentType.photos, title: nil, url: nil, photos: [ "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRisv-yQgXGrto6OxQxX62JyvyQGvRsQQ760g&usqp=CAU"], createdDate: "1605521360", isLiked: true, likes: [MomentsDetails.Moment.LikedUserDetails(id: "0", avatar: "https://avatars0.githubusercontent.com/u/573856?s=460&v=4")]),
                            MomentsDetails.Moment(id: "1", userDetails: MomentsDetails.Moment.MomentUserDetails(name: "Mattt", avatar: "https://pbs.twimg.com/profile_images/969321564050112513/fbdJZmEh_400x400.jpg"), type: MomentsDetails.Moment.MomentType.photos, title: "Low-level programming on iOS", url: nil, photos: ["https://i.pinimg.com/originals/15/27/3e/15273e2fa37cba67b5c539f254b26c21.png"], createdDate: "1605519980", isLiked: false, likes: [MomentsDetails.Moment.LikedUserDetails(id: "105", avatar: "https://randomuser.me/api/portraits/women/69.jpg")])                        ]
                        let expectedMomentsDetails = MomentsDetails(userDetails: expectedUserDetails, moments: expectedMoments)
                        expect(observer.events).to(equal([.next(100, expectedMomentsDetails)]))
                    }
                }
            }

            func getMoments(_ mockEvent: Recorded<Event<GetMomentsByUserIDSession.Response>>) {
                let testableObservable = testScheduler.createHotObservable([mockEvent])
                testSubject = GetMomentsByUserIDSession { _ in testableObservable.asObservable() }
                testSubject.getMoments(userID: "0").subscribe(observer).disposed(by: disposeBag)
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
              "title": null,
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
