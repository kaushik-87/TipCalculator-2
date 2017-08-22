//
//  TCSlider.swift
//  TipCalculator
//
//  Created by Kaushik on 8/21/17.
//  Copyright © 2017 Dev. All rights reserved.
//

import UIKit

class TCSlider: UISlider {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var trackHeight: CGFloat = 8
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width:bounds.width, height:trackHeight))
        
        
    }

}
