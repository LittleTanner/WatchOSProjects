//
//  InterfaceController.swift
//  Project12WatchConnectivity WatchKit Extension
//
//  Created by Kevin Tanner on 11/12/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    // MARK: - Outlets

    @IBOutlet weak var receivedData: WKInterfaceLabel!
    
    
    
    // MARK: - Lifecycle Methods

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
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
    
    // MARK: - Actions
    
    @IBAction func sendDataTapped() {
        let session = WCSession.default
        
        if session.activationState == .activated {
            let data = ["text": "Hello from the watch"]
            session.transferUserInfo(data)
        }
    }
    
    
    // MARK: - Conforming to Delegates
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("Message Receieved")
        DispatchQueue.main.async {
            if let text = userInfo["text"] as? String {
                self.receivedData.setText(text)
            }
        }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let text = message["text"] as? String {
                self.receivedData.setText(text)
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.main.async {
            if let text = message["text"] as? String {
                // Use our message data locally
                self.receivedData.setText(text)
                
                // Send back our reply
                replyHandler(["response": "Be excellent to each other"])
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Application state received!")
        print(applicationContext)
    }

    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        print("File received!")
        
        // Create a URL representing where to save the file
        let fm = FileManager.default
        let destURL = getDocumentsDirectory().appendingPathComponent("saved_file")
        
        do {
            if fm.fileExists(atPath: destURL.path) {
                // The file already exists - delete it!
                try fm.removeItem(at: destURL)
            }
            
            // Copy the file from its temporary location
            try fm.copyItem(at: file.fileURL, to: destURL)
            
            // Load the file and print it out
            let contents = try String(contentsOf: destURL)
            print(contents)
        } catch {
            // Something went wrong!
            print("File copy failed.")
        }
    }

}
