//
//  GameScene.swift
//  Project11ColorSpin WatchKit Extension
//
//  Created by Kevin Tanner on 11/11/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import SpriteKit
import WatchKit

class GameScene: SKScene, WKCrownDelegate {

    // MARK: - Properties
    
    var player = SKNode()
    
    
    // MARK: - Lifecycle Methods

    override func sceneDidLoad() {
        backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        
        let red = createPlayer(color: "Red")
        red.position = CGPoint(x: -8, y: 8)
        
        let blue = createPlayer(color: "Blue")
        blue.position = CGPoint(x: 8, y: 8)
        
        let green = createPlayer(color: "Green")
        green.position = CGPoint(x: -8, y: -8)
        
        let yellow = createPlayer(color: "Yellow")
        yellow.position = CGPoint(x: 8, y: -8)
        
        addChild(player)
    }
    
    
    // MARK: - Custom Methods
    
    func createPlayer(color: String) -> SKSpriteNode {
        let component = SKSpriteNode(imageNamed: "player\(color)")
        
        component.name = color
        player.addChild(component)
       
        return component
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        player.zRotation -= CGFloat(rotationalDelta) * 20
    }

}
