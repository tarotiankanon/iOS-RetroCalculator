//
//  ViewController.swift
//  RetroCalc
//
//  Created by Taro on 11/14/2558 BE.
//  Copyright © 2558 virtuoso. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = ""
    }

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber: String = ""
    var leftValStr: String = ""
    var rightValStr: String = ""
    var currentOperation: Operation = Operation.Empty
    
    var result: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // The path of the file in String
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        // AudioPlayer require this URL
        let soundUrl = NSURL(fileURLWithPath: path!)
        // Get sound assigned to a button
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            // Get the sound ready
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func dividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func multiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func subtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func addPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func equalPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func clearPressed(sender: AnyObject) {
        playSound()
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = Operation.Empty
        result = ""
        outputLbl.text = ""
    }
    
    func processOperation(operation: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                switch currentOperation {
                case Operation.Divide:
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                case Operation.Multiply:
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                case Operation.Subtract:
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                case Operation.Add:
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                default: break
                }
            }
            
            leftValStr = result
            outputLbl.text = result
            
            currentOperation = operation
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
}

