//
//  InternalMenuViewModelType.swift
//  Moments
//
//  Created by Jake Lin on 17/10/20.
//

import RxSwift
import RxDataSources

protocol InternalMenuViewModelType {
    var title: String { get }
    var sections: Observable<[InternalMenuSection]> { get }
}

class InternalMenuViewModel: InternalMenuViewModelType {
    let title = "Area 51"
    let sections: Observable<[InternalMenuSection]>

    init(appRouter: AppRouting) {
        let appVersion = "Version \((Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String) ?? "1.0")"

        let infoSection = InternalMenuSection(
            title: "General Info",
            items: [InternalMenuDescriptionItemViewModel(title: appVersion)]
        )

        sections = .just([
            infoSection
        ])
    }
}
