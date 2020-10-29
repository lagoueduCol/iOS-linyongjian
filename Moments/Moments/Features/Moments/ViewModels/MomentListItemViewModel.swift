//
//  MomentListItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 29/10/20.
//

import Foundation

struct MomentListItemViewModel: ListItemViewModel {
    let userAvatarURL: URL?
    let userName: String
    let title: String?
    let photoURL: URL? // This version only supports one image
    let postDateDescription: String?

    init(moment: MomentsDetails.Moment, now: Date = Date()) {
        userAvatarURL = URL(string: moment.userDetails.avatar)
        userName = moment.userDetails.name
        title = moment.title

        if let firstPhoto = moment.photos.first {
            photoURL = URL(string: firstPhoto)
        } else {
            photoURL = nil
        }

        let formatter: RelativeDateTimeFormatter = configure(.init()) {
            $0.unitsStyle = .full
        }
        if let timeInterval = TimeInterval(moment.createdDate) {
            let createdDate = Date(timeIntervalSince1970: timeInterval)
            postDateDescription = formatter.localizedString(for: createdDate, relativeTo: now)
        } else {
            postDateDescription = nil
        }
    }

    static var reuseIdentifier: String {
        String(describing: self)
    }
}
