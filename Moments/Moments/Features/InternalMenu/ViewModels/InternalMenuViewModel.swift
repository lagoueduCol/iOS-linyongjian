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

struct InternalMenuViewModel: InternalMenuViewModelType {
    let title = L10n.InternalMenu.area51
    let sections: Observable<[InternalMenuSection]>

    private let routingSourceRetriever: RoutingSourceRetriever

    init(router: AppRouting, routingSourceRetriever: @escaping RoutingSourceRetriever) {
        self.routingSourceRetriever = routingSourceRetriever

        let appVersion = "\(L10n.InternalMenu.version) \((Bundle.main.object(forInfoDictionaryKey: L10n.InternalMenu.cfBundleVersion) as? String) ?? "1.0")"

        let infoSection = InternalMenuSection(
            title: L10n.InternalMenu.generalInfo,
            items: [InternalMenuDescriptionItemViewModel(title: appVersion)]
        )

        let designKitSection = InternalMenuSection(
            title: L10n.InternalMenu.designKitDemo,
            items: [InternalMenuDesignKitDemoItemViewModel(router: router, routingSourceRetriever: routingSourceRetriever)])

        let featureTogglesSection = InternalMenuSection(
            title: L10n.InternalMenu.featureToggles,
            items: [
                InternalMenuFeatureToggleItemViewModel(title: L10n.InternalMenu.likeButtonForMomentEnabled, toggle: InternalToggle.isLikeButtonForMomentEnabled)
            ])

        let toolsSection = InternalMenuSection(
            title: L10n.InternalMenu.tools,
            items: [InternalMenuCrashAppItemViewModel()]
        )

        sections = .just([
            infoSection,
            designKitSection,
            featureTogglesSection,
            toolsSection
        ])
    }
}
