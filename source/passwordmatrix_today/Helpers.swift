//
//  Helpers.swift
//  passwordmatrix
//
//  Created by Chris Comeau on 2018-09-23.
//

import Foundation
import UIKit

//https://stackoverflow.com/questions/29835242/whats-the-simplest-way-to-convert-from-a-single-character-string-to-an-ascii-va
extension StringProtocol {
    var ascii: [UInt32] {
        return unicodeScalars.compactMap { $0.isASCII ? $0.value : nil }
    }
}
extension Character {
    var ascii: UInt32? {
        return String(self).ascii.first
    }
}


enum Colors {
    static let globalTintColor = UIColor(rgb:0x92a46b)
    
    static let keyboardKeysBackground = UIColor(rgb:0xe0e6c8)
    static let keyboardBackground = UIColor(rgb:0x839a67)
    static let keyboardKeysText = UIColor(rgb:0x000000)
}

enum Constants {
    static let keyFontSize : CGFloat = 16.0
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
