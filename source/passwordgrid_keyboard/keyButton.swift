//
//  keyButton.swift
//  lisuKeyboard
//
//  Created by Chris Comeau on 2018-09-23.
//

import UIKit

// Writing subclass for UIButton is not reccommended by Apple.
// But, i believe this is the best solution for the problem.

class keyButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // This is a hack added in order to fix buttons not being trigger if pressed
    // proximity of the button.
    
    var extraX : CGFloat = 0
    var extraY : CGFloat = 0
    
    var isFirstRow : Bool = false
    
    //var matrixIndex : Int = 0
    var subString : String = "??"
    
    func setInset(gapX : CGFloat, gapY : CGFloat){
        self.extraX = gapX / 2
        self.extraY = gapY / 2
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        //super.point(inside: point, with: event)
        if !self.isHidden {
            let area : CGRect = self.bounds.insetBy(dx: -extraX, dy: -extraY)
            return area.contains(point)
        }
        return false
    }
}
