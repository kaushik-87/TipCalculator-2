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
    @IBOutlet weak var totalVal:UILabel!
    
    var value = ""
    
    var rotationAngle : CGFloat!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        rotationAngle = -50 * (.pi / 100)
        splitByPicker.transform = CGAffineTransform(rotationAngle:rotationAngle)
        splitByPicker.frame = CGRect(x:0, y:0, width:splitBillView.frame.width, height:splitBillView.frame.height)
        value = "$"
        totalAmount.text = value
        updateViewElements()
//        self.tipView.frame.size = CGSize(width: self.tipView.frame.width, height: 0)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func updateViewElements() -> Void {
        updateTipViewFor(selectedIndex: self.segmentControl.selectedSegmentIndex)
        tipVal.text = String(format: "%@ %",String(self.tipPercentageSlider.value))
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
        tipVal.text = String(format: "%@ %",String(sender.value))
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
            value = "$"
            totalVal.text = ""
            
            break
        default:
            break
            
        }
        totalAmount.text = value
        calculateTipAndTotalAmount()
    }
    
    func calculateTipAndTotalAmount() -> Void {
        var billAmount:Float = 0.0
        if(value.characters.count>1)
        {
            let index = value.index(value.startIndex, offsetBy: 1)
            billAmount =  Float(value.substring(from: index))!
        }
        totalVal.text = String(calculateTipAmount(billAmount: billAmount, tipInPercentage: Float(self.tipPercentageSlider.value), dividedBy: 1))
    }
    
    func calculateTipAmount(billAmount:Float, tipInPercentage: Float, dividedBy:Int) -> Float {
        var totalAmount:Float = 0.0
        var tipAmount:Float = 0.0
        if dividedBy>0 {
            tipAmount = (billAmount * tipInPercentage) / 100.0
            totalAmount = billAmount + tipAmount
            totalAmount = totalAmount / Float(dividedBy)
        }
        return totalAmount
    }
    
    // UIPicker delegate/ datasource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 20
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return String(row)
    }
    
    
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
//    {
//        return 47
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        var rotationAngle : CGFloat!
        rotationAngle = 50 * (.pi / 100)
        
        if (view != nil) {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 47, height: 47))
            label.text = String(row)
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 25)
            label.textColor = UIColor.white
            label.transform = CGAffineTransform(rotationAngle: rotationAngle)
            view?.addSubview(label)
            return view!
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 47, height: 47))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 47, height: 47))
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = NSTextAlignment.center
        label.transform = CGAffineTransform(rotationAngle: rotationAngle)
        label.text = String(row)
        view.addSubview(label)
        return view
    }
    
    
    

}

