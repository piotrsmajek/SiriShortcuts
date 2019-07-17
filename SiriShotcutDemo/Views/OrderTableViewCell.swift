//
//  OrderTableViewCell.swift
//  SiriShotcutDemo
//
//  Created by Piotr Smajek on 05/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Foundation
import UIKit
import OrderKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var burgerNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var additionsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        contentView.backgroundColor = .clear
    }
    
    func bind(with model: Order) {
        burgerNameLabel.text = model.name
        quantityLabel.text = "\(String(model.quantity)) pcs."
        additionsLabel.text = model.additions.isEmpty ? "-" : model.additions.toString
        dateLabel.text = model.date.toString
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
}
