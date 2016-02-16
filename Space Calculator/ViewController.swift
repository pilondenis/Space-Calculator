//
//  ViewController.swift
//  Space Calculator
//
//  Created by Joseph Pilon on 2/15/16.
//  Copyright © 2016 Joseph Pilon. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    // MARK: Properties
    var btnSound: AVAudioPlayer!
    var results = ""
    var operation = ""
    var runningNumber = ""
    var leftNum = ""
    var rightNum = ""
    var currentOperation: Operation = Operation.Empty
    
    // MARK: Outlets
    @IBOutlet weak var outputLbl: UILabel!
    @IBOutlet weak var clearBtn: UIButton!
    
    
    // MARK: Actions
    @IBAction func bumberPressed(btn: UIButton!) {
        playSound()
        
        if runningNumber == "0" {
            runningNumber = "\(btn.tag)"
        } else {
            runningNumber += "\(btn.tag)"
        }
        outputLbl.text = runningNumber
        
        
        changeClearBtn("clear")
    }
    
    @IBAction func onDividePress(sender: UIButton) {
        changeClearBtn("clear")
        processOpperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton) {
        changeClearBtn("clear")
        processOpperation(Operation.Multiply)
    }
    
    @IBAction func onSubstractP(sender: UIButton) {
        changeClearBtn("clear")
        processOpperation(Operation.Substract)
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
        changeClearBtn("clear")
        processOpperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        changeClearBtn("all-clear")
        processOpperation(Operation.Empty)
        leftNum = "0"
        rightNum = "0"
        runningNumber = ""
    }
    
    @IBAction func onClearPressed(sender: UIButton) {
        if runningNumber != "" {
            runningNumber = "0"
        } else if currentOperation != Operation.Empty {
            currentOperation = Operation.Empty
            runningNumber = "0"
        } else {
            leftNum = ""
            rightNum = ""
            currentOperation = Operation.Empty
            runningNumber = "0"
        }
        outputLbl.text = runningNumber
        changeClearBtn("all-clear")
    }
    
    // MARK: Functions
    func processOpperation (op: Operation) {
        playSound()
        if runningNumber != "" {
            if currentOperation != Operation.Empty {
                rightNum = runningNumber
                runningNumber = ""
                switch currentOperation {
                    case Operation.Multiply:
                        results = "\(Double(leftNum)! * Double(rightNum)!)"
                    case Operation.Divide:
                        results = "\(Double(leftNum)! / Double(rightNum)!)"
                    case Operation.Substract:
                        results = "\(Double(leftNum)! - Double(rightNum)!)"
                    case Operation.Add:
                        results = "\(Double(leftNum)! + Double(rightNum)!)"
                    default:
                        return
                }
                leftNum = results
                outputLbl.text = results
                currentOperation = op
            } else if leftNum != "" && currentOperation != Operation.Empty {
                currentOperation = op
            } else {
                // First time operation is pressed
                leftNum = runningNumber
                runningNumber = ""
                currentOperation = op
            }
        }
        
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        } else {
            btnSound.play()
        }
    }
    
    func changeClearBtn(name: String) {
        let whichImage = name + ".png"
        clearBtn.setImage(UIImage(named: whichImage), forState: .Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLbl.text = "\(results)"
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

