//
//  BaseTableViewController.swift
//  Moments
//
//  Created by Jake Lin on 30/10/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import DesignKit

class BaseTableViewController: BaseViewController {
    var viewModel: ListViewModel!

    private let tableView: UITableView = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
        $0.contentInsetAdjustmentBehavior = .never
    }
    private let activityIndicatorView: UIActivityIndicatorView = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let errorLabel: UILabel = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        $0.textColor = UIColor.designKit.primaryText
        $0.text = L10n.MomentsList.errorMessage
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        DispatchQueue.main.async {
            // Walkaround for a warning
            // https://github.com/RxSwiftCommunity/RxDataSources/issues/331
            self.setupBindings()
        }

        loadViewModel()
    }
}

private extension BaseTableViewController {
    func setupUI() {
        view.backgroundColor = UIColor.designKit.background
        tableView.backgroundColor = UIColor.designKit.background

        [
            UserProfileListItemViewModel.reuseIdentifier: BaseTableViewCell<UserProfileListItemView>.self,
            MomentListItemViewModel.reuseIdentifier: BaseTableViewCell<MomentListItemView>.self
        ].forEach {
            tableView.register($0.value, forCellReuseIdentifier: $0.key)
        }

        [tableView, activityIndicatorView, errorLabel].forEach {
            view.addSubview($0)
        }
    }

    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        activityIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }

        errorLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func setupBindings() {
        let refreshControl = UIRefreshControl()
        refreshControl.rx.controlEvent(.valueChanged)
            .map { refreshControl.isRefreshing }
            .filter { $0 }
            .bind { [weak self] _ in self?.loadViewModel() }
            .disposed(by: disposeBag)

        tableView.refreshControl = refreshControl

        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ListItemViewModel>>(configureCell: { _, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: type(of: item)), for: indexPath)
            (cell as? ListItemCell)?.update(with: item)
            return cell
        })

        viewModel.listItems
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    func loadViewModel() {
        viewModel.load()
            .do(onDispose: { self.activityIndicatorView.rx.isAnimating.onNext(false) })
            .map { false }
            .startWith(true)
            .distinctUntilChanged()
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
