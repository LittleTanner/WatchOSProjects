//
//  InterfaceController.swift
//  Project10iMove WatchKit Extension
//
//  Created by Kevin Tanner on 11/7/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit


class InterfaceController: WKInterfaceController {

    // MARK: - Outlets
    
    @IBOutlet weak var activityType: WKInterfacePicker!
    
    // MARK: - Properties
    
    let activities: [(String, HKWorkoutActivityType)] = [("Cycling", .cycling), ("Running", .running), ("Swimming", .swimming), ("Wheelchair", .wheelchairRunPace)]
    var selectedActivity = HKWorkoutActivityType.cycling
    
    // MARK: - Lifecycle Methods

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        var items = [WKPickerItem]()
        
        for activity in activities {
            let item = WKPickerItem()
            item.title = activity.0
            items.append(item)
        }
        
        activityType.setItems(items)
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
    
    @IBAction func activityTypeChanged(_ value: Int) {
        selectedActivity = activities[value].1
    }
    
    @IBAction func startWorkoutTapped() {
        guard HKHealthStore.isHealthDataAvailable() else { return }
        
        WKInterfaceController.reloadRootPageControllers(withNames: ["WorkoutInterfaceController"], contexts: [selectedActivity], orientation: .horizontal, pageIndex: 0)
    }
    

}
