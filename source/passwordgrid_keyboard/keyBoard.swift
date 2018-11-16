//
//  keyBoard.swift
//  lisuKeyboard
//
//  Created by Chris Comeau on 2018-09-23.
//

import Foundation
import UIKit


// TODO :: There is a linker problem in lisuKeyboardLayoutout global function.
// The build error indicates that this global struct cannot be linked to
// the gloal function.

struct MODE_CHANGE_ID {
    static let unshift = 1
    static let shift = 2
    static let sym = 3
    static let num = 4
    static let del = 5
}

// Colors
struct theme {
    static let keyPressedColor : UIColor = UIColor(red:0.73, green:0.73, blue:0.73, alpha:1.0)
    
    //static let keyboardBackgroundColor : UIColor = UIColor(red:0.85, green:0.86, blue:0.86, alpha:1.0) //grey
    //static let keyboardBackgroundColor : UIColor = Colors.keyboardBackground
    //static let keyboardBackgroundColor : UIColor = UIColor(rgb:0x839a67) //dark green
    //static let keyboardBackgroundColor : UIColor = UIColor(rgb:0x839a67)
    static let keyboardBackgroundColor : UIColor = UIColor(rgb:0xD7E1BF)

//    static let keyboardBackground = UIColor(rgb:0x92a46b)
//    static let keyboardKeysBackground = UIColor(rgb:0x92a46b)
//    static let keyboardKeysText = UIColor(rgb:0x92a46b)

    //static let keyBackgroundColor : UIColor = UIColor.white
    //static let keyBackgroundColor : UIColor = Colors.keyboardKeysBackground
    //static let keyBackgroundColor : UIColor = UIColor(rgb:0xe0e6c8) //UIColor = Colors.keyboardBackground
    static let keyBackgroundColor : UIColor = UIColor(rgb:0xC0C9AA)
    
    static let keyBorderColor : UIColor = UIColor(rgb:0x6D8858) //UIColor.darkGray
    static let keyShadowColor : UIColor = UIColor(rgb:0x6D8858) //UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
    static let keyColor : UIColor = UIColor.black
    //static let keyColor : UIColor = Colors.keyboardKeysText //UIColor.darkGray
    //static let subscriptKeyColor : UIColor = UIColor.gray
    static let subscriptKeyColor : UIColor = UIColor(rgb:0x6D8858)

//    static let specialKeyBackgroundColor : UIColor = UIColor(red:0.77, green:0.80, blue:0.81, alpha:1.0)
//    static let specialKeyShadowColor : UIColor = UIColor(red:0.63, green:0.65, blue:0.66, alpha:0.6)
    
    static let specialKeyBackgroundColor : UIColor = UIColor(rgb:0xa5b387)  //keyBackgroundColor
    static let specialKeyShadowColor : UIColor = keyShadowColor
    
    static let keyboardTitleColor : UIColor = keyColor //Colors.keyboardKeysText //UIColor.lightGray
}

class Keyboard {
    // There are four pages unshift, shift, number , and symbols
    var keys: [Int:[[Key]]] = [:]
    
    var gearButton : UIButton = UIButton()
    var switchView : UISwitch = UISwitch()
    
    func setupTargets() {
        self.switchView.addTarget(self, action: #selector(switchChanged(_:)), for: UIControl.Event.valueChanged)
//        self.gearButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func buttonClicked(_ sender:UIButton) {
        /*let customURL = URL(string: "passwordgrid://")!
        
        UIApplication.canOpenURL(<#T##UIApplication#>)
        if UIApplication.shared.canOpenURL(customURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(customURL)
            } else {
                UIApplication.shared.openURL(customURL)
            }
        }*/
    }
    
    
    @objc func switchChanged(_ sender: UISwitch) {
        print("switchChanged")
        
        let defaults:UserDefaults = UserDefaults.standard
        //toggle
        let switchOn = self.switchView.isOn
        defaults.set(switchOn, forKey: "switchOn")
    }

}
