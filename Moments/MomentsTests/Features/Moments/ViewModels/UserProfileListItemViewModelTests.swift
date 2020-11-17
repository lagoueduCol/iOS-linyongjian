//
//  UserProfileListItemViewModelTests.swift
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

final class UserProfileListItemViewModelTests: QuickSpec {
    override func spec() {
        describe("UserProfileListItemViewModel") {
            var testSubject: UserProfileListItemViewModel!

            context("init(userDetails:)") {
                context("when all data provided") {
                    beforeEach {
                        testSubject = UserProfileListItemViewModel(userDetails: TestFixture.userDetails)
                    }

                    it("should initialize the properties correctly") {
                        expect(testSubject.name).to(equal("Jake Lin"))
                        expect(testSubject.avatarURL).to(equal(URL(string: "https://avatars0.githubusercontent.com/u/573856?s=460&v=4")))
                        expect(testSubject.backgroundImageURL).to(equal(URL(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg")))
                    }
                }

                context("when `userDetails.avatar` is not a valid URL") {
                    beforeEach {
                        testSubject = UserProfileListItemViewModel(userDetails: MomentsDetails.UserDetails(id: "1", name: "name", avatar: "this is not a valid URL", backgroundImage: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg"))
                    }

                    it("`avatarURL` should be nil") {
                        expect(testSubject.avatarURL).to(beNil())
                    }
                }

                context("when `userDetails.backgroundImage` is not a valid URL") {
                    beforeEach {
                        testSubject = UserProfileListItemViewModel(userDetails: MomentsDetails.UserDetails(id: "1", name: "name", avatar: "https://avatars0.githubusercontent.com/u/573856?s=460&v=4", backgroundImage: "this is not a valid URL"))
                    }

                    it("`backgroundImageURL` should be nil") {
                        expect(testSubject.backgroundImageURL).to(beNil())
                    }
                }
            }

            context("reuseIdentifier") {
                it("should return the view model's name") {
                    expect(UserProfileListItemViewModel.reuseIdentifier).to(equal("UserProfileListItemViewModel"))
                }
            }
        }
    }
}
