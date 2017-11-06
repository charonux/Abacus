//
//  Model.swift
//  Abacus
//
//  Created by Kay Remus Barth on 23/09/2017.
//  Copyright © 2017 Kay Remus Barth. All rights reserved.
//

import Foundation
struct AbacusModel {
    private var accumulator: Double?
    private enum Operation {
        case binaryOperation((Double,Double) -> Double)
        case equal
    }
    private var operation:[String:Operation] = [
        "+": Operation.binaryOperation({$0 + $1}),
        "−": Operation.binaryOperation({$0 - $1}),
        "÷": Operation.binaryOperation({$0 / $1}),
        "x": Operation.binaryOperation({$0 * $1}),
        "=": Operation.equal
    ]
    struct PendingBinaryOperation {
        var firstOperand:Double
        var function: ((Double,Double) -> Double)
        func performOperation(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    private var pendingBinaryOperation: PendingBinaryOperation?
    mutating func performPendingBinaryOperation() {
        if accumulator != nil && pendingBinaryOperation != nil {
            accumulator = pendingBinaryOperation!.performOperation(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    mutating func setOperand(_ operand: Double) {
            accumulator = operand
 }
    var result: Double? {
        get {
            return accumulator
        }
    }
    mutating func performOperation(_ symbol: String){
        if let operationType = operation[symbol] {
            switch operationType {
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(firstOperand: accumulator!, function: function)
                    accumulator = nil
                }
            case .equal:
                if accumulator != nil {
                    performPendingBinaryOperation()
                }
            }
        }
    }
}
