//
//  ViewController.swift
//  Abacus
//
//  Created by Kay Remus Barth on 17/09/2017.
//  Copyright © 2017 Kay Remus Barth. All rights reserved.
//
import UIKit
class ViewController: UIViewController {
    private var abacusModel = AbacusModel()
    @IBOutlet weak var accu: UILabel!
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTyping = false
    var userUseDotInput = false
    var operand: Double {
        get {
            return Double(display.text!)!
        }
        set {
            let temp = String(newValue)
            if temp.hasSuffix(".0") {
                return display.text = String(Int(newValue))
            } else {
            return display.text = String(newValue)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        switch digit {
        case ".":
            if !userUseDotInput {
                display.text?.append(digit)
                userUseDotInput = true
            }
        case "0":
            if display.text! != "0" {
                display.text?.append(digit)
            }
        default:
            if userIsInTheMiddleOfTyping {
                display.text?.append(digit)
            } else {
                display.text = digit
            }
        }
        userIsInTheMiddleOfTyping = true
        abacusModel.setOperand(operand)
    }
    @IBAction func performOperation(_ sender: UIButton) {
        if let operation = sender.titleLabel?.text {
            switch operation {
            case "C":
                //operand = 0
                abacusModel.accumulator = nil
                display.text = "0"
            default:
                abacusModel.performOperation(operation)
                if abacusModel.result != nil {
                    operand = abacusModel.result!
                }
            }
        }
        userUseDotInput = false
        userIsInTheMiddleOfTyping = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

