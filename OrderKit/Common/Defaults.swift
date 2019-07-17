//
//  Defaults.swift
//  SiriShotcutDemo
//
//  Created by Piotr Smajek on 05/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Foundation
import Intents

public struct UserDefaultsKeys {
    public static let ShortcutOrders = "ShortcutOrders"
}

public struct Defaults {
    
    public static let userDefaults = UserDefaults(suiteName: "group.com.miquido.siriShortcutsDemo")
    
    public static func save(order: Order) {
        var array = [order]
        orders.forEach { array.append($0) }
        do {
            let ordersData = try JSONEncoder().encode(array)
            userDefaults?.set(ordersData, forKey: UserDefaultsKeys.ShortcutOrders)
            donateInteraction(for: order)
        }
        catch { }
    }
    
    public static func clear() {
        userDefaults?.removeObject(forKey: UserDefaultsKeys.ShortcutOrders)
    }
    
    public static var orders: [Order] {
        guard let orders = userDefaults?.data(forKey: UserDefaultsKeys.ShortcutOrders) else { return [] }
        do {
            return try JSONDecoder().decode([Order].self, from: orders)
        } catch {
            return []
        }
    }
    
    private static func donateInteraction(for order: Order) {
        let interaction = INInteraction(intent: order.intent, response: nil)
        
        interaction.donate { (error) in
            if error != nil {
                print("Error")
            } else {
                print("Successfully donated interaction")
            }
        }
    }
    
}
