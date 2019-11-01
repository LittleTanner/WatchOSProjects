//
//  InterfaceController.swift
//  Project6UserInput WatchKit Extension
//
//  Created by Kevin Tanner on 11/1/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

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
    
    @IBAction func dictateTapped() {
        presentTextInputController(withSuggestions: nil, allowedInputMode: .plain) { result in
            guard let result = result?.first as? String else { return }
            print(result)
        }
    }
    
    @IBAction func multiInputTapped() {
        presentTextInputController(withSuggestions: ["Hacking with Swift","Hacking with MacOS", "Server-Side Swift"], allowedInputMode: .allowEmoji) { result in
            guard let result = result?.first as? String else { return }
            print(result)
        }
    }
    
    @IBAction func recordingTapped() {
    }
    
}
