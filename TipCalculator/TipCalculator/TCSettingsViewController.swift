//
//  SecondViewController.swift
//  TipCalculator
//
//  Created by Dev on 7/23/17.
//  Copyright © 2017 Kaushik. All rights reserved.
//

import UIKit

class TCSettingsViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var minTipVal:UITextField!
    @IBOutlet weak var maxTipVal:UITextField!
    @IBOutlet weak var defaultTipVal:UITextField!
    @IBOutlet weak var maxNoOfSharesVal:UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userDefaults = UserDefaults.standard
        let minVal = userDefaults.float(forKey: "minVal")
        let maxVal = userDefaults.float(forKey: "maxVal")
        let defaultVal = userDefaults.float(forKey: "defaultVal")
        let maxShare = userDefaults.integer(forKey: "maxShare")
        
        self.minTipVal.text = String(minVal)
        self.maxTipVal.text = String(maxVal)
        self.defaultTipVal.text = String(defaultVal)
        self.maxNoOfSharesVal.text = String(maxShare)
    }
    
    func saveSettings() -> Void{
        let minValue = NSNumber(value: Float(minTipVal.text!)!)
        let maxValue = NSNumber(value: Float(maxTipVal.text!)!)
        let defautValue = NSNumber(value: Float(defaultTipVal.text!)!)
        let maxNoOfSharedValue = NSNumber(value: Int(maxNoOfSharesVal.text!)!)
        
        if (maxValue.floatValue < minValue.floatValue) {
            // show error
            
            return
        }
        if(defautValue.floatValue > maxValue.floatValue || defautValue.floatValue < minValue.floatValue )
        {
            // show error
            
            return
        }
        
        if (maxNoOfSharedValue.floatValue <= 1 || maxNoOfSharedValue.floatValue > 100)
        {
            // show error
            
            return
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(minValue, forKey: "minVal")
        userDefaults.set(maxValue, forKey: "maxVal")
        userDefaults.set(defautValue, forKey: "defaultVal")
        userDefaults.set(maxNoOfSharedValue, forKey: "maxShare")
        userDefaults.synchronize()
    }
    
    
    @IBAction func savAction (sender: UIButton)
    {
        saveSettings()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        self.maxTipVal.resignFirstResponder()
        self.minTipVal.resignFirstResponder()
        self.defaultTipVal.resignFirstResponder()
        self.maxNoOfSharesVal.resignFirstResponder()
    }
    
}

