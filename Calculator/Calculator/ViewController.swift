//
//  ViewController.swift
//  Calculator
//
//  Created by nisharg patel on 2017-06-26.
//  Copyright © 2017 nisharg patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    @IBOutlet weak var history: UILabel!

    @IBOutlet weak var display: UILabel!
    
    var isUserTyping:Bool = false
    
    
    @IBAction func digit(_ sender: UIButton) {
        let digit = sender.currentTitle
        if isUserTyping {
            let displaytext = display.text!
            display.text = displaytext + digit!
            history.text = displaytext + digit!
        }else {
            display.text = digit
            history.text = digit
            isUserTyping = true
        }
    }
    
    var displayValue:Double{
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    var brain = calculatorBrain()
    
    @IBAction func operand(_ sender: UIButton) {
        if isUserTyping{
            brain.setoperand(displayValue)
            isUserTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
    
        
    }
    
    
    
}

