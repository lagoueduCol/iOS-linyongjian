//
//  TestFixture.swift
//  MomentsTests
//
//  Created by Jake Lin on 16/11/20.
//

import Foundation
@testable import Moments

struct TestFixture { }

extension TestFixture {
    static let momentsDetails: MomentsDetails = {
        let userDetails = MomentsDetails.UserDetails(id: "0", name: "Jake Lin", avatar: "https://avatars0.githubusercontent.com/u/573856?s=460&v=4", backgroundImage: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg")
        let moments = [
            MomentsDetails.Moment(id: "0", userDetails:  MomentsDetails.Moment.MomentUserDetails(name: "Taylor Swift", avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlk0dgrwcQ0FiTKdgR3atzstJ_wZC4gtPgOmUYBsLO2aa9ssXs"), type: MomentsDetails.Moment.MomentType.photos, title: nil, url: nil, photos: [ "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRisv-yQgXGrto6OxQxX62JyvyQGvRsQQ760g&usqp=CAU"], createdDate: "1605521360", isLiked: true, likes: [MomentsDetails.Moment.LikedUserDetails(id: "0", avatar: "https://avatars0.githubusercontent.com/u/573856?s=460&v=4")]),
            MomentsDetails.Moment(id: "1", userDetails: MomentsDetails.Moment.MomentUserDetails(name: "Mattt", avatar: "https://pbs.twimg.com/profile_images/969321564050112513/fbdJZmEh_400x400.jpg"), type: MomentsDetails.Moment.MomentType.photos, title: "Low-level programming on iOS", url: nil, photos: ["https://i.pinimg.com/originals/15/27/3e/15273e2fa37cba67b5c539f254b26c21.png"], createdDate: "1605519980", isLiked: false, likes: [MomentsDetails.Moment.LikedUserDetails(id: "105", avatar: "https://randomuser.me/api/portraits/women/69.jpg")])                        ]
        return MomentsDetails(userDetails: userDetails, moments: moments)
    }()
}
