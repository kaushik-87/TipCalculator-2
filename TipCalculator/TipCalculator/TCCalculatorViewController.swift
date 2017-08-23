//
//  FirstViewController.swift
//  TipCalculator
//
//  Created by Dev on 7/23/17.
//  Copyright © 2017 Kaushik. All rights reserved.
//

import UIKit

class TCCalculatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    
    @IBOutlet weak var tipPercentageView:UIView!
    @IBOutlet weak var splitBillView:UIView!
    @IBOutlet weak var segmentControl:UISegmentedControl!
    @IBOutlet weak var totalAmount:UILabel!
    @IBOutlet weak var detailedLabel:UILabel!
    @IBOutlet weak var splitByPicker:UIPickerView!
    @IBOutlet weak var tipPercentageSlider:UISlider!
    @IBOutlet weak var tipView:UIView!
    
    @IBOutlet weak var tipVal:UILabel!
    @IBOutlet weak var tipPercentage:UILabel!
    @IBOutlet weak var totalVal:UILabel!
    
    var value = "0"
    var maxNumberOfShare = 20;
    
    var rotationAngle : CGFloat!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        rotationAngle = -50 * (.pi / 100)
        splitByPicker.transform = CGAffineTransform(rotationAngle:rotationAngle)
        splitByPicker.frame = CGRect(x:0, y:0, width:splitBillView.frame.width, height:splitBillView.frame.height)
        totalAmount.text = localizedCurrencyInString(value: NSNumber(value: Float(value)!));
        NotificationCenter.default.addObserver(self, selector: #selector(updateUIFromPrefernce), name: NSNotification.Name(rawValue: "ResetUI"), object: nil)
//        self.tipView.frame.size = CGSize(width: self.tipView.frame.width, height: 0)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateUIFromPrefernce() -> Void{
        let userDefaults = UserDefaults.standard
        let minVal = userDefaults.float(forKey: "minVal")
        let maxVal = userDefaults.float(forKey: "maxVal")
        let defaultVal = userDefaults.float(forKey: "defaultVal")
        let billAmount = userDefaults.string(forKey: "billAmount")
        let splitBy = userDefaults.integer(forKey: "splitBy")
        
        self.totalAmount.text = localizedCurrencyInString(value: NSNumber(value: Float(billAmount!)!))
        value = billAmount!
        self.tipPercentageSlider.minimumValue = minVal
        self.tipPercentageSlider.maximumValue = maxVal
        self.tipPercentageSlider.value = defaultVal
        maxNumberOfShare = userDefaults.integer(forKey: "maxShare")
        self.splitByPicker.reloadAllComponents()
        self.splitByPicker.selectRow(splitBy-1, inComponent: 0, animated: true)
        tipPercentage.text = "Tip - \(String(format: "%0.2f",self.tipPercentageSlider.value)) %"
        calculateTipAndTotalAmount()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateViewElements()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUIFromPrefernce()
    }

    func updateViewElements() -> Void {
        updateTipViewFor(selectedIndex: self.segmentControl.selectedSegmentIndex)
        calculateTipAndTotalAmount()
    }
    
    
    func updateTipViewFor(selectedIndex:Int) -> Void {
        if (selectedIndex == 0)
        {
            print("First")
            self.splitBillView.isHidden = true
            self.tipPercentageView.isHidden = false
        }else
        {
            print("Second")
            self.splitBillView.isHidden = false
            self.tipPercentageView.isHidden = true
        }
    }
    
    @IBAction func tipValue(sender: UISlider)
    {
        let userDefaults = UserDefaults.standard
        userDefaults.set(sender.value, forKey: "defaultVal")
        userDefaults.synchronize()
        tipPercentage.text = "Tip - \(String(format: "%0.2f",sender.value)) %"
        calculateTipAndTotalAmount()
    }

    @IBAction func segmentSelection(sender: UISegmentedControl)
    {
        updateTipViewFor(selectedIndex: sender.selectedSegmentIndex)
    }
    
    @IBAction func buttonAction (sender: UIButton)
    {
        switch sender.tag {
        case 0:
            value.append("0")
            break
        case 1:
            value.append("1")
            break
        case 2:
            value.append("2")
        case 3:
            value.append("3")
        case 4:
            value.append("4")
        case 5:
            value.append("5")
        case 6:
            value.append("6")
        case 7:
            value.append("7")
        case 8:
            value.append("8")
        case 9:
            value.append("9")
        case 10:
            if (value.contains("."))
            {
                break

            }
            if (value == "$")
            {
                value.append("0")
                value.append(".")
                break
            }
            value.append(".")
        case 11:
            value = "0"
            totalVal.text = ""
            
            break
        default:
            break
            
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey:"billAmount")
        userDefaults.synchronize()
        
        totalAmount.text = localizedCurrencyInString(value: NSNumber(value: Float(value)!))
        
        calculateTipAndTotalAmount()
    }
    
    func localizedCurrencyInString(value:NSNumber) -> String {
        
        return currencyNumberFormatter().string(from: value)!
    }
    
    // Number formatter used for displaying the values
    func currencyNumberFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter;
    }
    func calculateTipAndTotalAmount() -> Void {
        var billAmount:Float = 0.0
        var divideBy = 1
        if(value.characters.count>1)
        {
            let index = value.index(value.startIndex, offsetBy: 1)
            billAmount =  Float(value.substring(from: index))!
        }
        
        divideBy = splitByPicker.selectedRow(inComponent: 0)+1
        totalVal.text = localizedCurrencyInString(value: NSNumber(value: Float(calculateTipAmount(billAmount: billAmount, tipInPercentage: Float(self.tipPercentageSlider.value), dividedBy: divideBy).1)))
            //String(format: "%0.2f",calculateTipAmount(billAmount: billAmount, tipInPercentage: Float(self.tipPercentageSlider.value), dividedBy: divideBy).1)
        tipVal.text = localizedCurrencyInString(value: NSNumber(value: Float(calculateTipAmount(billAmount: billAmount, tipInPercentage: Float(self.tipPercentageSlider.value), dividedBy: divideBy).0)))
            //String(format: "%0.2f",calculateTipAmount(billAmount: billAmount, tipInPercentage: Float(self.tipPercentageSlider.value), dividedBy: divideBy).0)

    }

    
    
    func calculateTipAmount(billAmount:Float, tipInPercentage: Float, dividedBy:Int) -> (Float, Float) {
        var totalAmount:Float = 0.0
        var tipAmount:Float = 0.0
        if dividedBy>0 {
            tipAmount = (billAmount * tipInPercentage) / 100.0
            tipVal.text = String(format: "%@ %",String(tipAmount))
            totalAmount = billAmount + tipAmount
            totalAmount = totalAmount / Float(dividedBy)
        }
        return (tipAmount, totalAmount)
    }
    
    
    // UIPicker delegate/ datasource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxNumberOfShare
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        let title = row + 1;
        print(title)
        return String(title)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(row+1, forKey:"splitBy")
        userDefaults.synchronize()
        calculateTipAndTotalAmount()
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        var rotationAngle : CGFloat!
        let title = row + 1;
        rotationAngle = 50 * (.pi / 100)
        
        if (view != nil) {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            label.text = String(title)
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 25)
            label.textColor = UIColor.white
            label.transform = CGAffineTransform(rotationAngle: rotationAngle)
            view?.addSubview(label)
            return view!
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = NSTextAlignment.center
        label.transform = CGAffineTransform(rotationAngle: rotationAngle)
        label.text = String(title)
        view.addSubview(label)
        return view
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 75
    }
    
    
 }

