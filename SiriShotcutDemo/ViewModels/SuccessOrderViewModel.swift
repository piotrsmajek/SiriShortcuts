//
//  SuccessOrderViewModel.swift
//  SiriShotcutDemo
//
//  Created by Piotrek on 17/07/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Foundation
import OrderKit

class SuccessOrderViewModel {
    
    let order: Order?
    
    init(with order: Order) {
        self.order = order
    }

}
