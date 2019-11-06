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

    
    // MARK: - Lifecycle Methods

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
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
    }
    
    // MARK: - Custom Methods
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        currentSafeValue += Float(rotationalDelta)
        currentSafeValue = min(max(0, currentSafeValue), 100)
        safeValue.setValue(currentSafeValue)
        nextButton.setTitle("Enter \(Int(currentSafeValue))")
    }

    
}
