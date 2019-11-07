//
//  WorkoutInterfaceController.swift
//  Project10iMove WatchKit Extension
//
//  Created by Kevin Tanner on 11/7/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit

class WorkoutInterfaceController: WKInterfaceController {

    // MARK: - Outlets
    
    @IBOutlet weak var quantityLabel: WKInterfaceLabel!
    @IBOutlet weak var unitLabel: WKInterfaceLabel!
    @IBOutlet weak var stopButton: WKInterfaceButton!
    @IBOutlet weak var resumeButton: WKInterfaceButton!
    @IBOutlet weak var endButton: WKInterfaceButton!
    
    // MARK: - Properties
    
    var healthStore: HKHealthStore?
    var distanceType = HKQuantityTypeIdentifier.distanceCycling

    
    // MARK: - Lifecycle Methods

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let activity = context as? HKWorkoutActivityType else { return }
        
        switch activity {
        case .cycling:
            distanceType = .distanceCycling
        case .running:
            distanceType = .distanceWalkingRunning
        case .swimming:
            distanceType = .distanceSwimming
        default:
            distanceType = .distanceWheelchair
        }
        
        // Configure the values we want to write
        let sampleTypes: Set<HKSampleType> = [.workoutType(),
        HKSampleType.quantityType(forIdentifier: .heartRate)!,
        HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKSampleType.quantityType(forIdentifier: .distanceCycling)!,
        HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKSampleType.quantityType(forIdentifier: .distanceSwimming)!,
        HKSampleType.quantityType(forIdentifier: .distanceWheelchair)!
        ]
        
        // Create our health store
        healthStore = HKHealthStore()
        
        // User it to request authorization for our types
        healthStore?.requestAuthorization(toShare: sampleTypes, read: sampleTypes) { success, error in
            if success {
                // start workout!
            }
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
    
    @IBAction func changeDisplayMode() {
    }
    
    @IBAction func stopWorkout() {
    }
    
    @IBAction func resumeWorkout() {
    }
    
    @IBAction func endWorkout() {
    }
    

}
