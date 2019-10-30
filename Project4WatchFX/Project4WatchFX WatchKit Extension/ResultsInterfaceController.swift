//
//  ResultsInterfaceController.swift
//  Project4WatchFX WatchKit Extension
//
//  Created by Kevin Tanner on 10/30/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation


class ResultsInterfaceController: WKInterfaceController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var table: WKInterfaceTable!
    @IBOutlet weak var status: WKInterfaceLabel!
    @IBOutlet weak var done: WKInterfaceButton!
    
    // MARK: - Properties
    
    var fetchedCurrencies = [(symbol: String, rate: Double)]()
    var amountToConvert = 0.0
    let appID = "8eb365740067451482177eb66947a386"


    // MARK: - Lifecycle Methods

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        guard let settings = context as? [String: String] else { return }
        guard let amount = settings["amount"] else { return }
        guard let baseCurrency = settings["base"] else { return }
        
        amountToConvert = Double(amount) ?? 50
        setTitle("\(amount) \(baseCurrency)")
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.fetchData(for: baseCurrency)
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
    
    @IBAction func doneTapped() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["Home", "Currencies"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
    

    // MARK: - Custom Methods
    
    func fetchData(for baseCurrency: String) {
        if let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=\(appID)&base=\(baseCurrency)") {
            let urlRequest = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    self.parse(data)
                } else {
                    DispatchQueue.main.async {
                        self.status.setText("Fetch failed")
                        self.done.setHidden(false)
                    }
                }
            }.resume()
        }
    }
    
    func parse(_ contents: Data) {
        
    }
    
    func updateTable() {
        
    }

    
}
