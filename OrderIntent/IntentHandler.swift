//
//  IntentHandler.swift
//  OrderIntent
//
//  Created by Piotr Smajek on 13/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Intents
import OrderKit

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        return OrderIntentHandler()
    }
    
}
