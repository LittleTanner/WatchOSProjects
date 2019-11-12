//
//  ViewController.swift
//  Project12WatchConnectivity
//
//  Created by Kevin Tanner on 11/12/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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


}

