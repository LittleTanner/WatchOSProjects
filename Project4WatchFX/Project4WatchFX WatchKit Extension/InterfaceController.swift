//
//  InterfaceController.swift
//  Project4WatchFX WatchKit Extension
//
//  Created by Kevin Tanner on 10/29/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    // MARK: - Outlets
    
    @IBOutlet weak var amountLabel: WKInterfaceLabel!
    @IBOutlet weak var amountSlider: WKInterfaceSlider!
    @IBOutlet weak var currencyPicker: WKInterfacePicker!
    
    
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
    
    @IBAction func convertTapped() {
    }
    
    @IBAction func amountChanged(_ value: Float) {
    }
    
    @IBAction func baseCurrencyChanged(_ value: Int) {
    }
}
