//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Levchuk Misha on 30.03.17.
//  Copyright © 2017 Levchuk Misha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var myCurrency: [String] = []
    var myValues: [Double] = []
    var activeCurrency: Double = 0
    
    var currency = [(name: String, value: Double)]()
    
    
    
    //Objects 
    
    @IBOutlet weak var inputValue: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var outputValue: UILabel!
    
    //Creating PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myCurrency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = myValues[row]
    }
    
    //Button
    
    @IBAction func convert(_ sender: AnyObject) {
        if inputValue.text != "" {
            outputValue.text = String(Double(inputValue.text!)! * activeCurrency)
        }
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string:"http://api.fixer.io/latest")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if error != nil {
                print("ERROR")
            } else {
                if let content = data {
                    do {
                        let myJSON = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let rates = myJSON ["rates"] as? NSDictionary {
                            for (key, value) in rates {
                                self.myCurrency.append((key as? String)!)
                                self.myValues.append((value as? Double)!)
                            }
                            print(self.myCurrency)
                            print(self.myValues)
                        }
                    } catch {
                        
                    }
                }
            }
            self.pickerView.reloadAllComponents()
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

