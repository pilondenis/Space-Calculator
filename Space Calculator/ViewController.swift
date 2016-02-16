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
    
    
    // MARK: Actions
    @IBAction func bumberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePress(sender: UIButton) {
        processOpperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOpperation(Operation.Multiply)
    }
    
    @IBAction func onSubstractP(sender: UIButton) {
        processOpperation(Operation.Substract)
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
        processOpperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        processOpperation(Operation.Empty)
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

