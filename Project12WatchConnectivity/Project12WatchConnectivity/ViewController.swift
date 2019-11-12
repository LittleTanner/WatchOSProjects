//
//  ViewController.swift
//  Project12WatchConnectivity
//
//  Created by Kevin Tanner on 11/12/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    // MARK: - Outlets

    @IBOutlet weak var receivedData: UITextView!
    
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let complication = UIBarButtonItem(title: "Complication", style: .plain, target: self, action: #selector(sendComplicationTapped))
        let message = UIBarButtonItem(title: "Message", style: .plain, target: self, action: #selector(sendMessageTapped))
        let appInfo = UIBarButtonItem(title: "Context", style: .plain, target: self, action: #selector(sendAppContextTapped))
        let file = UIBarButtonItem(title: "File", style: .plain, target: self, action: #selector(sendFileTapped))
        navigationItem.leftBarButtonItems = [complication, message, appInfo, file]
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    
    // MARK: - Custom Methods
    
    @objc func sendMessageTapped() {
        let session = WCSession.default
//
//        if session.activationState == .activated {
//            let data = ["text": "User info from the phone"]
//            session.transferUserInfo(data)
//        }
        
        if session.isReachable {
            let data = ["text": "A message from the phone"]
            session.sendMessage(data, replyHandler: { response in
                DispatchQueue.main.async {
                    self.receivedData.text = "Received response: \(response)"
                }
            })
        }
        
        print("Send Message Tapped")
    }
    
    @objc func sendAppContextTapped() {
        
        let session = WCSession.default
        
        if session.activationState == .activated {
            let data = ["text": "Hello from the phone"]
            
            do {
                try session.updateApplicationContext(data)
            } catch {
                print("Alert! Updating app context failed")
            }
        }
        print("Send App Context Tapped")
    }
    
    @objc func sendComplicationTapped() {
        print("Send Complication Tapped")
    }
    
    @objc func sendFileTapped() {
        let session = WCSession.default
        
        if session.activationState ==  .activated {
            // Create a URL for where the file is/will be saved
            let fm = FileManager.default
            let sourceURL = getDocumentsDirectory().appendingPathComponent("saved_file")
            
            if !fm.fileExists(atPath: sourceURL.path) {
                // The file doesn't exist - create it now
                try? "Hello, from a phone file!".write(to: sourceURL, atomically: true, encoding: String.Encoding.utf8)
            }
            
            // The file exists now; send it across the session
            session.transferFile(sourceURL, metadata: nil)
        }
        
        print("Send File Tapped")
    }

    
    // MARK: - Conforming to Delegates
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            if activationState == .activated {
                if session.isWatchAppInstalled {
                    self.receivedData.text = "Watch app is installed!"
                }
            }
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        DispatchQueue.main.async {
            if let text = userInfo["text"] as? String {
                self.receivedData.text = text
            }
        }
    }

}

