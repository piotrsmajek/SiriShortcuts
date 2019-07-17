//
//  Order.swift
//  SiriShotcutDemo
//
//  Created by Piotrek on 13/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Foundation

public enum Additions: String, Codable {
    case bacon = "Bacon"
    case nachos = "Nachos"
    case jalapeno = "Jalapeno"
}

public struct Order: Codable {
    public var name: String
    public var quantity: String
    public var additions: [Additions]
    public var date: Date
    
    public init(with name: String,
                quantity: String,
                additions: [Additions]) {
        self.name = name
        self.quantity = quantity
        self.additions = additions
        self.date = Date()
    }
    
    public init(from intent: OrderIntent) {
        self.name = intent.burgerName ?? ""
        self.quantity = intent.quantity?.stringValue ?? ""
        self.additions = intent.additions?.elements ?? []
        self.date = Date()
    }
}
