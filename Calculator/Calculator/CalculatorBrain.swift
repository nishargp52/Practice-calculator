//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by nisharg patel on 2017-06-27.
//  Copyright © 2017 nisharg patel. All rights reserved.
//

import Foundation

struct calculatorBrain {
    
    private var accumulator: Double?
    
    private enum operation {
        case constant (Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
        case clear
    }
    
    private var operations: Dictionary<String, operation> = [
    
        "∏" :operation.constant(Double.pi),
        "log" : operation.unaryOperation(log),
        "√" : operation.unaryOperation(sqrt),
        "+" : operation.binaryOperation({$0 + $1}),
        "-" : operation.binaryOperation({$0 - $1}),
        "x" : operation.binaryOperation({$0 * $1}),
        "÷" : operation.binaryOperation({$0 / $1}),
        "=" : operation.equals,
        "C" : operation.clear,
        ]
    
    public mutating func performOperation(_ symbol: String){
        if let Operation = operations [symbol] {
            switch Operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if pbo != nil {
                   accumulator = pbo?.perform(with: accumulator!)
                    pbo?.firstOperand = accumulator!
                    pbo?.function = function
                } else if accumulator != nil {
                    pbo = pendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryFunction()
            
            case .clear:
                if accumulator == 0 {
                    pbo = nil
                } else {
                    accumulator = 0
                }
                
            }
        }
        
    }
    
    private mutating func performPendingBinaryFunction() {
        if pbo != nil && accumulator != nil {
        accumulator = pbo?.perform(with: accumulator!)
        pbo = nil
        }
    }
    
    private var pbo: pendingBinaryOperation?

    
    private struct pendingBinaryOperation {
        var function:(Double,Double) -> Double
        var firstOperand: Double
        
        func perform (with secondOperand: Double) ->Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    
    
    public mutating func setoperand(_ operand : Double) {
        accumulator = operand
        
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
