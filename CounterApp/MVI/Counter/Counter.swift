//
//  Counter.swift
//  CounterApp
//
//  Created by APPLE on 24/01/21.
//

import Foundation

class Counter {
    var value           : Int
    var isAutoIncrement : Bool
    
    init(initialValue : Int, isAutoIncrement : Bool) {
        self.value = initialValue
        self.isAutoIncrement = isAutoIncrement
    }
    
    convenience init() {
        self.init(initialValue : 0,isAutoIncrement : false)
    }
    
    //-----------------------------------------------------
    //MARK: -
    func increment() {
        value += 1
    }
    
    func decrement() {
        value -= 1
    }
    
    func reset() {
        value = 0
    }
    
    func toggelAutoIncrement() {
        isAutoIncrement = !isAutoIncrement
    }
    
}


