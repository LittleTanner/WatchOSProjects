//
//  InterfaceController.swift
//  Project8SafeCrack WatchKit Extension
//
//  Created by Kevin Tanner on 11/6/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController, WKCrownDelegate {

    // MARK: - Outlets

    @IBOutlet weak var numbersLabel: WKInterfaceLabel!
    @IBOutlet weak var safeValue: WKInterfaceSlider!
    @IBOutlet weak var nextButton: WKInterfaceButton!
    @IBOutlet weak var timer: WKInterfaceTimer!
    
    // MARK: - Properties
    
    var currentSafeValue: Float = 50
    var targetSafeValue = 0
    var allSafeNumbers = [Int]()
    var correctValues = [String]()

    
    // MARK: - Lifecycle Methods

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        startNewGame()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func didAppear() {
        crownSequencer.focus()
        crownSequencer.delegate = self
    }
    
    // MARK: - Actions

    @IBAction func nextTapped() {
        guard Int(currentSafeValue) == targetSafeValue else { return }
        
        correctValues.append(String(targetSafeValue))
        
        numbersLabel.setText(correctValues.joined(separator: ", "))
        
        if correctValues.count == 3 {
            timer.stop()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let playAgain = WKAlertAction(title: "Play again", style: .default) { self.startNewGame() }
                self.presentAlert(withTitle: "You win!", message: nil, preferredStyle: .alert, actions: [playAgain])
            }
        } else {
            pickNumber()
        }
    }
    
    // MARK: - Custom Methods
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        currentSafeValue += Float(rotationalDelta)
        currentSafeValue = min(max(0, currentSafeValue), 100)
        safeValue.setValue(currentSafeValue)
        nextButton.setTitle("Enter \(Int(currentSafeValue))")
        
        if Int(currentSafeValue) == targetSafeValue {
            // This is the right number - tap their wrist
            WKInterfaceDevice.current().play(.click)

            // Now update the UI to show this is good
            safeValue.setColor(UIColor.green)
            numbersLabel.setTextColor(UIColor.green)
            nextButton.setEnabled(true)
        } else {
            
            // Wrong number; make the UI Show this is bad
            numberIsWrong()
        }
    }
    
    func startNewGame() {
        // Reset and start the timer
        timer.setDate(Date())
        timer.start()
        
        // Create an array of random numbers from 0 to 100
        allSafeNumbers = Array(0...100)
        allSafeNumbers.shuffle()
        
        // Reset the current Value
        currentSafeValue = 50
        safeValue.setValue(50)
        
        // Remove all their previous answers and reset the text
        correctValues.removeAll()
        numbersLabel.setText("Safe Crack")
        
        // Pick the first number to guess
        pickNumber()
    }
    
    func pickNumber() {
        targetSafeValue = allSafeNumbers.removeFirst()
        print(targetSafeValue)
        numberIsWrong()
    }

    func numberIsWrong() {
        safeValue.setColor(UIColor.red)
        numbersLabel.setTextColor(UIColor.white)
        nextButton.setEnabled(false)
    }
    
}
