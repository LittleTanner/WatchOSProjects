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
        
    }
    
    @objc func sendAppContextTapped() {
        
    }
    
    @objc func sendComplicationTapped() {
        
    }
    
    @objc func sendFileTapped() {
        
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


}

