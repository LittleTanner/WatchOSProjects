//
//  DetailInterfaceController.swift
//  Project1NoteDictate WatchKit Extension
//
//  Created by Kevin Tanner on 10/24/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation


class DetailInterfaceController: WKInterfaceController {

    @IBOutlet weak var textLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        if let contextDictionary = context as? [String: String] {
            textLabel.setText(contextDictionary["note"] ?? "")
            
            let index = contextDictionary["index"] ?? "1"
            setTitle("Notes \(index)")
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
