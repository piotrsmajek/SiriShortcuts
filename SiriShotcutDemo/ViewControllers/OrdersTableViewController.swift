//
//  OrdersTableViewController.swift
//  SiriShotcutDemo
//
//  Created by Piotr Smajek on 05/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import OrderKit

class OrdersTableViewController: UITableViewController {
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 145.0
        tableView.rowHeight = 145.0
    }
    
    private func setupRx() {
        Observable.just(Defaults.orders)
            .bind(to: tableView.rx.items(cellIdentifier: OrderTableViewCell.identifier,
                                         cellType: OrderTableViewCell.self)) { row, model, cell in
                                            cell.bind(with: model)
            }
            .disposed(by: disposeBag)
    }
    
}
