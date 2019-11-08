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

enum DisplayMode {
    case distance
    case energy
    case heartRate
}

class WorkoutInterfaceController: WKInterfaceController, HKWorkoutSessionDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var quantityLabel: WKInterfaceLabel!
    @IBOutlet weak var unitLabel: WKInterfaceLabel!
    @IBOutlet weak var stopButton: WKInterfaceButton!
    @IBOutlet weak var resumeButton: WKInterfaceButton!
    @IBOutlet weak var endButton: WKInterfaceButton!
    
    // MARK: - Properties
    
    var healthStore: HKHealthStore?
    var distanceType = HKQuantityTypeIdentifier.distanceCycling
    var workoutStartDate = Date()
    var activeDateQueries = [HKQuery]()
    var workoutSession: HKWorkoutSession?
    
    var displayMode = DisplayMode.distance
    var totalEnergyBurned = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: 0)
    var totalDistance = HKQuantity(unit: HKUnit.meter(), doubleValue: 0)
    var lastHeartRate = 0.0
    let countPerMinuteUnit = HKUnit(from: "count/min")
    var workoutIsActive = true
    var workoutEndDate = Date()
    
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
                self.startWorkout(type: activity)
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
        switch displayMode {
        case .distance:
            displayMode = .energy
        case .energy:
            displayMode = .heartRate
        case .heartRate:
            displayMode = .distance
        }
        
        updateLabels()
    }
    
    @IBAction func stopWorkout() {
        guard let workoutSession = workoutSession else { return }
        stopButton.setHidden(true)
        resumeButton.setHidden(false)
        endButton.setHidden(false)
        
        healthStore?.pause(workoutSession)
    }
    
    @IBAction func resumeWorkout() {
        guard let workoutSession = workoutSession else { return }
        stopButton.setHidden(false)
        resumeButton.setHidden(true)
        endButton.setHidden(true)
        
        healthStore?.resumeWorkoutSession(workoutSession)
    }
    
    @IBAction func endWorkout() {
        guard let workoutSession = workoutSession else { return }
        workoutEndDate = Date()
        
        healthStore?.end(workoutSession)
    }
    
    
    // MARK: - Custom Methods
    
    func startQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        // We only want data points after our workout start date
        let datePredicate = HKQuery.predicateForSamples(withStart: workoutStartDate, end: nil, options: .strictStartDate)
        
        // We only want data points that come from our current device
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        
        // Combine the two predicates into one
        let queryPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [datePredicate, devicePredicate])
        
        // Write code to receive results from our query
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = { query, samples, deletedObjects, queryAnchor, error in
            // Safely typecast to a quantity sample so we can read values
            guard let samples = samples as? [HKQuantitySample] else { return }
            
            self.process(samples, type: quantityTypeIdentifier)
        }
        
        // Create the query out of our type (e.g. heart rate), predicate, and result handling code
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: queryPredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        // Tell HealthKit to re-run the code everytime new data is available
        query.updateHandler = updateHandler
        
        // Start the query running
        healthStore?.execute(query)
        
        // Stash it away so we can stop it later
        activeDateQueries.append(query)
    }

    func startQueries() {
        startQuery(quantityTypeIdentifier: distanceType)
        startQuery(quantityTypeIdentifier: .activeEnergyBurned)
        startQuery(quantityTypeIdentifier: .heartRate)
        WKInterfaceDevice.current().play(.start)
        
        if distanceType == .distanceSwimming {
            WKExtension.shared().enableWaterLock()
        }
    }
    
    func cleanUpQueries() {
        for query in activeDateQueries {
            healthStore?.stop(query)
        }
        
        activeDateQueries.removeAll()
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        switch toState {
        case .running:
            if fromState == .notStarted {
                startQueries()
            } else {
                workoutIsActive = true
            }
        case .paused:
            workoutIsActive = false
        case .ended:
            workoutIsActive = false
            cleanUpQueries()
            save(workoutSession)
        default:
            break
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
    
    func startWorkout(type: HKWorkoutActivityType) {
        // 1: Create a workout configuration
        let config = HKWorkoutConfiguration()
        config.activityType = type
        config.locationType = .outdoor
        
        // 2: Create a workout session from that
        if let session = try? HKWorkoutSession(configuration: config) {
            workoutSession = session
            
            // 3: Start the workout now
            healthStore?.start(session)
            
            // 4: Reset our start date
            workoutStartDate = Date()
            
            // 5: register to recieve status updates
            session.delegate = self
        }
    }
    
    func save(_ workoutSession: HKWorkoutSession) {
        let config = workoutSession.workoutConfiguration
        let workout = HKWorkout(activityType: config.activityType, start: workoutStartDate, end: workoutEndDate, workoutEvents: nil, totalEnergyBurned: totalEnergyBurned, totalDistance: totalDistance, metadata: [HKMetadataKeyIndoorWorkout: false])
        
        healthStore?.save(workout) { (success, error) in
            if success {
                DispatchQueue.main.async {
                    WKInterfaceController.reloadRootPageControllers(withNames: ["InterfaceController"], contexts: nil, orientation: .horizontal, pageIndex: 0)
                }
            }
        }
    }
    
    func updateLabels() {
        switch displayMode {
        case .distance:
            let meters = totalDistance.doubleValue(for: HKUnit.meter())
            let kilometers = meters / 1000
            let formattedKilometers = String(format: "%.2f", kilometers)
            quantityLabel.setText(formattedKilometers)
            unitLabel.setText("KILOMETERS")
        case .energy:
            let kilocalories = totalEnergyBurned.doubleValue(for: HKUnit.kilocalorie())
            let formatterKilocalories = String(format: "%.0f", kilocalories)
            quantityLabel.setText(formatterKilocalories)
            unitLabel.setText("CALORIES")
        case .heartRate:
            let heartRate = String(Int(lastHeartRate))
            quantityLabel.setText(heartRate)
            unitLabel.setText("BEATS / MINUTE")
        }
    }
    
    func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        // Ignore updates while we are paused
        guard workoutIsActive else { return }
        
        // Loop over all the samples we've been sent
        for sample in samples {
            // This is a calorie count
            if type == .activeEnergyBurned {
                // Find out how many calories were burned
                let newEnergy = sample.quantity.doubleValue(for: HKUnit.kilocalorie())
                
                // Get our current total calorie burn
                let currentEnergy = totalEnergyBurned.doubleValue(for: HKUnit.kilocalorie())
                
                // Add the two together and store it
                totalEnergyBurned = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: currentEnergy + newEnergy)
                
                // Print out the new total for debugging purposes
                print("Total energy: \(totalEnergyBurned)")
            } else if type == .heartRate {
                // We got a heart rate - just update the property
                lastHeartRate = sample.quantity.doubleValue(for: countPerMinuteUnit)
                print("Last heart rate: \(lastHeartRate)")
            } else if type == distanceType {
                // We got a distance traveled value
                let newDistance = sample.quantity.doubleValue(for: HKUnit.meter())
                let currentDistance = totalDistance.doubleValue(for: HKUnit.meter())
                totalDistance = HKQuantity(unit: HKUnit.meter(), doubleValue: currentDistance + newDistance)
                print("Total distance: \(totalDistance)")
            }
        }
        
        // Update our user interface
        updateLabels()
    }
}
