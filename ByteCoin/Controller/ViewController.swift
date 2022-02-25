//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var coinManager = CoinManager()
    @IBOutlet weak var bicoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self // here referring our picker to the protocol.
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // columns we want in our picker
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count // it's taking the count of our array.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]//taking tha values of array.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCointPrice(for: selectedCurrency)
    }

}


//MARK: - expanding with my new protocol

extension ViewController : CoinFieldDelegate{
    
    func didUpdateField(price: String, currency: String) {
        
        DispatchQueue.main.async {
            self.bicoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    func didgetAnyError(error: Error) {
        print(error)
    }
}
