//
//  Order+Intents.swift
//  SiriShotcutDemo
//
//  Created by Piotr Smajek on 13/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Foundation
import Intents

public extension Order {
    
    var intent: OrderIntent {
        let orderIntent = OrderIntent()
        orderIntent.burgerName = name
        if let intValue = Int(quantity) {
            orderIntent.quantity = NSNumber(value: intValue)
        }
        orderIntent.suggestedInvocationPhrase = "Burger time"
        
        orderIntent.additions = additions.map { option -> INObject in
            return INObject(identifier: option.rawValue,
                            display: option.rawValue)
        }
        return orderIntent
    }
    
}

