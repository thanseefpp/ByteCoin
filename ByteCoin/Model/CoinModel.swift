//
//  CoinModel.swift
//  ByteCoin
//
//  Created by THANSEEF on 20/02/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel{
    let priceRate : Double
//    let firstCurrency : String
//    let secondCurrency : String
//    let realTime : String
    
    
    var priceinString : String {
        String(format: "%.1f", priceRate)
    }
}
