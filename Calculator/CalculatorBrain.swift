//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Ashish Mishra on 2/4/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    var operation : String!
    var operand1: Double!
    
    func performOperation( operand2: Double) ->Double {
        var result : Double!
        switch operation {
        case "÷":result = operand1 / operand2
        case "×":result = operand1*operand2
        case "+":result = operand1+operand2
        case "−":result = operand1 - operand2
        case "√":result = sqrt(operand2)
        case "sin": result = sin(operand2)
        case "cos":result = cos(operand2)
        case "tan":result = tan(operand2)
        case "ln":result = log(operand2)
        default:break
        }
        return result;
    }
    
    func saveOperand( operation:String, operand: Double) {
        self.operation = operation;
        self.operand1 = operand;
    }
    
}
