//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit


protocol CoinFieldDelegate {
    func didUpdateField(price: String, currency: String)
    func didgetAnyError(error:Error)
}


struct CoinManager{
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "324B057A-640F-4720-BAA6-5FCD9D8E7EC4"
    
    //created a variable to call the protocl methods.
    var delegate : CoinFieldDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCointPrice(for currency:String){
        let url = ("\(baseURL)/\(currency)?apikey=\(apiKey)")
        performRequest(with: url,currency: currency)
    }
    
    func performRequest(with UrlString : String,currency:String){ //performing network request and checking the api is working?
        if let url = URL(string: UrlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didgetAnyError(error: error!)
                    return
                }
                if let safeData = data {
                    if let bitCoinPrice = self.jsonParse(json: safeData){
                        let priceInStrig = String(format: "%.2f", bitCoinPrice)
                        self.delegate?.didUpdateField(price: priceInStrig, currency: currency)
                    }
                    //                    print(bitCoinPrice!)
                }
                //                let dataString = String(data: data!, encoding: .utf8)
                //                print(dataString!)
            }
            //            if let data = try? Data(contentsOf: url){
            //                jsonParse(json: data)
            //            }
            task.resume()
        }
    }
    
    func jsonParse(json:Data) -> Double?{
        let decorder = JSONDecoder()
        do {
            let decodedData = try decorder.decode(CoinData.self, from: json)
            let currencyPrice = decodedData.rate
            return currencyPrice
        }
        catch {
            //errors.
            delegate?.didgetAnyError(error: error)
            return nil
        }
        
    }
    
    
}

