//
//  ResultsInterfaceController.swift
//  Project4WatchFX WatchKit Extension
//
//  Created by Kevin Tanner on 10/30/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation


class ResultsInterfaceController: WKInterfaceController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var table: WKInterfaceTable!
    @IBOutlet weak var status: WKInterfaceLabel!
    @IBOutlet weak var done: WKInterfaceButton!
    
    // MARK: - Properties
    
    var fetchedCurrencies = [(symbol: String, rate: Double)]()
    var amountToConvert = 0.0
    let appID = "8eb365740067451482177eb66947a386"


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
    
    @IBAction func doneTapped() {
    }
    

}
