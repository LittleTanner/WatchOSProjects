//
//  InterfaceController.swift
//  Project11ColorSpin WatchKit Extension
//
//  Created by Kevin Tanner on 11/11/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation
import SpriteKit


class InterfaceController: WKInterfaceController {

    // MARK: - Outlets
    
    @IBOutlet weak var gameInterface: WKInterfaceSKScene!
    
    // MARK: - Properties
    
    var gameScene: GameScene!

    
    // MARK: - Lifecycle Methods

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        startGame(self)
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
        crownSequencer.delegate = gameScene
    }
    
    // MARK: - Actions
    
    @IBAction func startGame(_ sender: Any) {
        
        if gameScene != nil {
            guard gameScene.isPlayerAlive == false else { return }
        }
        
        gameScene = GameScene(size: CGSize(width: 154, height: 174))
        gameScene.parentInterfaceController = self
        gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let transition = SKTransition.doorway(withDuration: 1)
        gameInterface.presentScene(gameScene, transition: transition)
    }
    


}
