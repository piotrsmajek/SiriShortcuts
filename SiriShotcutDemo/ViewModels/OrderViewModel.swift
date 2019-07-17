//
//  OrderViewModel.swift
//  SiriShotcutDemo
//
//  Created by Piotr Smajek on 04/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import OrderKit

class OrderViewModel {
    
    let items: [String] = ["Boss Burger", "Deluxe Burger", "Chicken Burger"]
    
    private let selectedBurgerRelay = BehaviorRelay<String>(value: "")
    var selectedBurgerDriver: Driver<String> {
        return selectedBurgerRelay.asDriver()
    }
    
    private let quantityRelay = BehaviorRelay<Int>(value: 1)
    var quantityDriver: Driver<Int> {
        return quantityRelay.asDriver()
    }
    
    private let additionBaconRelay = BehaviorRelay<Bool>(value: false)
    var additionBaconDriver: Driver<Bool> {
        return additionBaconRelay.asDriver()
    }

    private let additionNachosRelay = BehaviorRelay<Bool>(value: false)
    var additionNachosDriver: Driver<Bool> {
        return additionNachosRelay.asDriver()
    }
    
    private let additionJalapenoRelay = BehaviorRelay<Bool>(value: false)
    var additionJalapenoDriver: Driver<Bool> {
        return additionJalapenoRelay.asDriver()
    }
    
    var additions: [Additions] {
        var array: [Additions] = []
        if additionBaconRelay.value { array.append(.bacon) }
        if additionNachosRelay.value { array.append(.nachos) }
        if additionJalapenoRelay.value { array.append(.jalapeno) }
        return array
    }
    
    var burgerOrder: Order?
    
    init() {
        setDefaultValue()
    }
    
    private func setDefaultValue() {
        guard let first = items.first,
            selectedBurgerRelay.value.isEmpty else { return }
        selectedBurgerRelay.accept(first)
    }
    
    func setQuantityValue(with value: Int) {
        quantityRelay.accept(value)
    }
    
    func setSelectedBurger(with value: String) {
        selectedBurgerRelay.accept(value)
    }
    
    func setAdditionalBacon(with value: Bool) {
        additionBaconRelay.accept(value)
    }
    
    func setAdditionalNachos(with value: Bool) {
        additionNachosRelay.accept(value)
    }
    
    func setAdditionalJalapeno(with value: Bool) {
        additionJalapenoRelay.accept(value)
    }
    
    func order() {
        let order = Order(with: selectedBurgerRelay.value,
                          quantity: String(quantityRelay.value),
                          additions: additions)
        Defaults.save(order: order)
        burgerOrder = order
    }
    
}
