//
//  Array+Additions.swift
//  OrderKit
//
//  Created by Piotrek on 17/07/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Foundation
import Intents

public extension Array where Element == INObject {
    
    var elements: [Additions] {
        var additionsArray: [Additions] = []
        forEach { option in
            guard let identifier = option.identifier,
                let addition = Additions.init(rawValue: identifier) else { return }
            additionsArray.append(addition)
        }
        return additionsArray
    }
    
}

public extension Array where Element == Additions {
    
    var toString: String {
        return map { $0.rawValue }.joined(separator: ", ")
    }
    
}
