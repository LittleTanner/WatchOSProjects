//
//  InterfaceController.swift
//  Project2RockPaperScissors WatchKit Extension
//
//  Created by Kevin Tanner on 10/24/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    // MARK: - Outlets
    @IBOutlet weak var question: WKInterfaceImage!
    
    @IBOutlet weak var answers: WKInterfaceGroup!
    @IBOutlet weak var rock: WKInterfaceButton!
    @IBOutlet weak var paper: WKInterfaceButton!
    @IBOutlet weak var scissors: WKInterfaceButton!
    
    @IBOutlet weak var levelCounter: WKInterfaceLabel!
    @IBOutlet weak var timer: WKInterfaceTimer!
    
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
    
    // MARK: - Actions

    @IBAction func rockTapped() {
    }
    
    @IBAction func paperTapped() {
    }
    
    @IBAction func scissorsTapped() {
    }
    
}
