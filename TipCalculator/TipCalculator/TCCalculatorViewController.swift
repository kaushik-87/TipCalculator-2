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
    
    var rotationAngle : CGFloat!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        rotationAngle = -50 * (.pi / 100)
        splitByPicker.transform = CGAffineTransform(rotationAngle:rotationAngle)
        splitByPicker.frame = CGRect(x:0, y:0, width:splitBillView.frame.width, height:splitBillView.frame.height)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func segmentSelection(sender: UISegmentedControl)
    {
        if (sender.selectedSegmentIndex == 0)
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
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        var rotationAngle : CGFloat!
        rotationAngle = 50 * (.pi / 100)
        
        if (view != nil) {
            let label = UILabel(frame: CGRect(x: 0, y: 10, width: 70, height: 70))
            label.text = String(row)
            label.textAlignment = NSTextAlignment.center
            label.textColor = UIColor.white
            label.transform = CGAffineTransform(rotationAngle: rotationAngle)
            view?.addSubview(label)
            return view!
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: 110, height: 110))
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.transform = CGAffineTransform(rotationAngle: rotationAngle)
        label.text = String(row)
        view.addSubview(label)
        return view
    }
    
    
    

}

