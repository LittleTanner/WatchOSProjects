//
//  WorkoutInterfaceController.swift
//  Project10iMove WatchKit Extension
//
//  Created by Kevin Tanner on 11/7/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation


class WorkoutInterfaceController: WKInterfaceController {

    // MARK: - Outlets
    
    @IBOutlet weak var quantityLabel: WKInterfaceLabel!
    @IBOutlet weak var unitLabel: WKInterfaceLabel!
    @IBOutlet weak var stopButton: WKInterfaceButton!
    @IBOutlet weak var resumeButton: WKInterfaceButton!
    @IBOutlet weak var endButton: WKInterfaceButton!
    
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
    
    @IBAction func changeDisplayMode() {
    }
    
    @IBAction func stopWorkout() {
    }
    
    @IBAction func resumeWorkout() {
    }
    
    @IBAction func endWorkout() {
    }
    

}
