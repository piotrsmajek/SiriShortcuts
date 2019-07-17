//
//  OrderIntentHandler.swift
//  OrderKit
//
//  Created by Piotr Smajek on 13/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Foundation

public class OrderIntentHandler: NSObject, OrderIntentHandling {
    
    public func confirm(intent: OrderIntent,
                        completion: @escaping (OrderIntentResponse) -> Void) {
        completion(OrderIntentResponse(code: OrderIntentResponseCode.ready,
                                       userActivity: nil))
    }
    
    public func handle(intent: OrderIntent,
                       completion: @escaping (OrderIntentResponse) -> Void) {
        guard let burgerName = intent.burgerName else {
            completion(OrderIntentResponse(code: .failure,
                                           userActivity: nil))
            return
        }
        
        Defaults.save(order: Order(from: intent))
        completion(OrderIntentResponse.success(burgerName: burgerName,
                                               waitTime: "5"))
    }
    
}
