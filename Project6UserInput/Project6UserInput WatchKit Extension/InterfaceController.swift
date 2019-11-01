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
        // Set where we'll read and save from
        let saveURL = getDocumentsDirectory().appendingPathComponent("recording.wav")
        
        if FileManager.default.fileExists(atPath: saveURL.path) {
            // If we have a recording already, play it
            let options = [WKMediaPlayerControllerOptionsAutoplayKey: "true"]
            
            presentMediaPlayerController(with: saveURL, options: options) { (didPlayToEnd, endTime, error) in
                // do nothing here
            }
        } else {
            // We don't have a recording; make one
            let options: [String: Any] = [WKAudioRecorderControllerOptionsMaximumDurationKey: 60,
                                          WKAudioRecorderControllerOptionsActionTitleKey: "Done"]
            
            presentAudioRecorderController(withOutputURL: saveURL, preset: .narrowBandSpeech, options: options) { (success, error) in
                if success {
                    print("Save successfully!")
                } else {
                    print(error?.localizedDescription ?? "Unknown error")
                }
            }
        }
    }
    
    // MARK: - Custom Methods
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    
}
