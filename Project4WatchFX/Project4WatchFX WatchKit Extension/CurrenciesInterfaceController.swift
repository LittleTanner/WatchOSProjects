//
//  CurrenciesInterfaceController.swift
//  Project4WatchFX WatchKit Extension
//
//  Created by Kevin Tanner on 10/29/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation


class CurrenciesInterfaceController: WKInterfaceController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    // MARK: - Properties
    
    let selectedColor = UIColor(red: 0, green: 0.55, blue: 0.25, alpha: 1)
    let deselectedColor = UIColor(red: 0.3, green: 0, blue: 0, alpha: 1)


    // MARK: - Lifecycle Methods

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        // Set up as many rows as we have currencies
        table.setNumberOfRows(InterfaceController.currencies.count, withRowType: "Row")
        
        // Load the list of selected currencies, or use the default list
        let defaults = UserDefaults.standard
        let selectedCurrencies = defaults.array(forKey: InterfaceController.selectedCurrenciesKey) as? [String] ?? InterfaceController.defaultCurrencies
        
        // Loop over all the currencies, configuring the table rows
        for (index, currency) in InterfaceController.currencies.enumerated() {
            guard let row = table.rowController(at: index) as? CurrencyRow else { return }
            row.textLabel.setText(currency)
            
            // Color the row's group depending on whether it's selected
            if selectedCurrencies.contains(currency) {
                row.group.setBackgroundColor(selectedColor)
            } else {
                row.group.setBackgroundColor(deselectedColor)
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
    
    // MARK: - Custom Methods
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        // 1: Grab the row controller and safely typecast
        guard let row = table.rowController(at: rowIndex) as? CurrencyRow else { return }
        
        // 2: Pull out the current list of selected currencies, or use the default list
        let defaults = UserDefaults.standard
        var selectedCurrencies = defaults.array(forKey: InterfaceController.selectedCurrenciesKey) as? [String] ?? InterfaceController.defaultCurrencies
        
        // 3: Find the name of the tapped currency
        let selectedCurrency = InterfaceController.currencies[rowIndex]
        
        // 4: If that currency was found in our selected currencies, remove it
        if let index = selectedCurrencies.firstIndex(of: selectedCurrency) {
            selectedCurrencies.remove(at: index)
            row.group.setBackgroundColor(deselectedColor)
        } else {
            // 5: Otherwise add it
            selectedCurrencies.append(selectedCurrency)
            row.group.setBackgroundColor(selectedColor)
        }
        
        // 6: Save the new selected currencies
        defaults.set(selectedCurrencies, forKey: InterfaceController.selectedCurrenciesKey)
    }
}
