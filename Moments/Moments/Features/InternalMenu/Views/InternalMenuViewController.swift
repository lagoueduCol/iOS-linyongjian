//
//  InternalMenuViewController.swift
//  Moments
//
//  Created by Jake Lin on 17/10/20.
//

import UIKit
import RxDataSources
import SnapKit

final class InternalMenuViewController: BaseViewController {
    var viewModel: InternalMenuViewModelType!

    lazy var tableView: UITableView = configure(UITableView(frame: CGRect.zero, style: .grouped)) {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 44

        $0.register(InternalMenuDescriptionCell.self, forCellReuseIdentifier: InternalMenuItemType.description.rawValue)
        $0.register(InternalMenuActionTriggerCell.self, forCellReuseIdentifier: InternalMenuItemType.actionTrigger.rawValue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(dismissModal))

        setupLayout()
        setupBindings()
    }

    func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupBindings() {
        let dataSource = RxTableViewSectionedReloadDataSource<InternalMenuSection>(
            configureCell: { _, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: item.type.rawValue, for: indexPath)
                if let cell = cell as? InternalMenuItemViewing {
                    cell.update(with: item)
                }
            return cell
        }, titleForHeaderInSection: { dataSource, section in
            return dataSource.sectionModels[section].title
        }, titleForFooterInSection: { dataSource, section in
            return dataSource.sectionModels[section].footer
        })

        viewModel.sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)

        tableView.rx
            .modelSelected(InternalMenuItemViewModel.self)
            .subscribe(onNext: { item in
                item.select()
            })
            .disposed(by: disposeBag)
    }

    @objc
    func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
}
