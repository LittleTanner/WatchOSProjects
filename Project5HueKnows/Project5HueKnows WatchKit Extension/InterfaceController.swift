//
//  InterfaceController.swift
//  Project5HueKnows WatchKit Extension
//
//  Created by Kevin Tanner on 10/31/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    // MARK: - Outlets
    
    @IBOutlet weak var tlButton: WKInterfaceButton!
    @IBOutlet weak var trButton: WKInterfaceButton!
    @IBOutlet weak var blButton: WKInterfaceButton!
    @IBOutlet weak var brButton: WKInterfaceButton!
    
    
    
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
    
    @IBAction func tlButtonTapped() {
    }
    
    @IBAction func trButtonTapped() {
    }
    
    @IBAction func blButtonTapped() {
    }
    
    @IBAction func brButtonTapped() {
    }
    
    // MARK: - Custom Methods
    



}
