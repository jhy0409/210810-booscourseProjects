//
//  TestUISlider.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/12.
//

import UIKit

class TestUISlider: UISlider {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        let width = self.frame.size.width
        let tapPoint = touch.location(in: self)
        let floatPercent = tapPoint.x/width // ex) 0.5... 0.8
        let newValue = self.maximumValue * Float(floatPercent)
        if newValue != self.value {
            self.value = newValue
        }
        return true
    }

}
