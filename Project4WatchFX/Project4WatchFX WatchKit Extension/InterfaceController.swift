//
//  InterfaceController.swift
//  Project4WatchFX WatchKit Extension
//
//  Created by Kevin Tanner on 10/29/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    // MARK: - Outlets
    
    @IBOutlet weak var amountLabel: WKInterfaceLabel!
    @IBOutlet weak var amountSlider: WKInterfaceSlider!
    @IBOutlet weak var currencyPicker: WKInterfacePicker!
    
    // MARK: - Properties
    
    static let currencies = ["USD", "AUD", "CAD", "CHF", "CNY", "EUR", "GBP", "HKD", "JPY", "SGD"]
    static let defaultCurrencies = ["USD", "EUR"]
    
    var currentCurrency = "USD"
    var currentAmount = 500
    
    static let selectedCurrenciesKey = "SelectedCurrencies"
    
    // MARK: - Lifecycle Methods

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        var items = [WKPickerItem]()
        
        for currency in InterfaceController.currencies {
            let item = WKPickerItem()
            item.title = currency
            items.append(item)
        }
        
        currencyPicker.setItems(items)
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
    
    @IBAction func convertTapped() {
        let context = ["amount": String(currentAmount), "base": currentCurrency]
        
        WKInterfaceController.reloadRootPageControllers(withNames: ["Results"], contexts: [context], orientation: .horizontal, pageIndex: 0)
    }
    
    @IBAction func amountChanged(_ value: Float) {
        currentAmount = Int(value)
        
        amountLabel.setText(String(currentAmount))
    }
    
    @IBAction func baseCurrencyChanged(_ value: Int) {
        currentCurrency = InterfaceController.currencies[value]
    }
}
