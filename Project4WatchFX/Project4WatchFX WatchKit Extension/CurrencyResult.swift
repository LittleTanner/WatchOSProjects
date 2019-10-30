//
//  CurrencyResult.swift
//  Project4WatchFX WatchKit Extension
//
//  Created by Kevin Tanner on 10/30/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation

struct CurrencyResult: Codable {
    var base: String
    var rates: [String: Double]
}
