//
//  InternalMenuViewModel.swift
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

    init(router: InternalMenuRouting) {
        let appVersion = "Version \((Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String) ?? "1.0")"

        let infoSection = InternalMenuSection(
            title: "General Info",
            items: [InternalMenuDescriptionItemViewModel(title: appVersion)]
        )

        let designKitSection = InternalMenuSection(
            title: "DesignKit Demo",
            items: [DesignKitDemoItemViewModel(router: router)])

        sections = .just([
            infoSection,
            designKitSection
        ])
    }
}
