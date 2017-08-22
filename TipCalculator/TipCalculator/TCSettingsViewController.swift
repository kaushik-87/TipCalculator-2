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
    @IBOutlet weak var scrollView:UIScrollView!
    
    var activeField:UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        self.scrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc func tap(gesture: UITapGestureRecognizer) {
       self.maxTipVal.resignFirstResponder()
       self.minTipVal.resignFirstResponder()
       self.defaultTipVal.resignFirstResponder()
       self.maxNoOfSharesVal.resignFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotifications()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        deregisterFromKeyboardNotifications()
    }
    
    func saveSettings() -> Void{
        
        self.maxTipVal.resignFirstResponder()
        self.minTipVal.resignFirstResponder()
        self.defaultTipVal.resignFirstResponder()
        self.maxNoOfSharesVal.resignFirstResponder()
        
        
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
    
    
    // Below methods are handling the keyboard show / hide notifications
    // Handling the scroll view position based on the position of the textfield.
    
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
//        var info = notification.userInfo!
//        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        self.scrollView.contentInset =  UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
    
    
}

