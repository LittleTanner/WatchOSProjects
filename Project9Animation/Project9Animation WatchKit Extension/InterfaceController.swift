//
//  InterfaceController.swift
//  Project9Animation WatchKit Extension
//
//  Created by Kevin Tanner on 11/6/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    // MARK: - Outlets

    @IBOutlet weak var image: WKInterfaceImage!
    
    // MARK: - Properties
    
    var animation = 1
    
    
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
    
    @IBAction func animateTapped() {
        animate(withDuration: 1) {
            switch self.animation {
            case 1:
                self.image.setAlpha(0.5)
            case 2:
                self.image.setVerticalAlignment(.top)
                self.image.setHorizontalAlignment(.right)
            case 3:
                self.image.setRelativeWidth(0.1, withAdjustment: 0)
                self.image.setRelativeHeight(0.1, withAdjustment: 0)
            case 4:
                self.image.setWidth(25)
                self.image.setHeight(25)
            case 5:
                self.image.setTintColor(UIColor.red)
            case 6:
                self.image.setTintColor(nil)
                self.image.setAlpha(1)
                self.image.setVerticalAlignment(.center)
                self.image.setHorizontalAlignment(.center)
                self.image.sizeToFitWidth()
                self.image.sizeToFitHeight()
            default:
                self.animation = 1
                self.animateTapped()
                return
            }
            
            self.animation += 1
        }
    }
    


}
