//
//  lisuKeyboardLayout.swift
//  lisuKeyboard
//
//  Created by Chris Comeau on 2018-09-23.
//

import Foundation
import UIKit


struct page {
    var keyboard : [[String]] = []
}

func getPassKey(matrixArray:[String], key:String) -> String  {
    //return "??"
    
    //[matrixArray objectAtIndex:(index-97)]
    //[matrixArray objectAtIndex:(index-48+26)]
    if matrixArray.count == 0 {
        return "??"
    }
    
    let newKey = key.lowercased()
    let c:Character = newKey.first!
    let index = c.ascii!
   // return "AA"
    
    switch newKey {
    case "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
         "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z":
        return matrixArray[Int(index-97)]
        
    case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0":
        return matrixArray[Int(index-48+26)]
    default:
            return "??"
    }
    
    //return matrixArray[0]
}


func lisuKeyboardLayout(controller: UIInputViewController, totalWidth: CGFloat, totalHeight: CGFloat, isPortrait: Bool, isIPad: Bool) -> Keyboard {
    
    struct MODE_CHANGE_ID {
        static let unshift = 1
        static let shift = 2
        static let sym = 3
        static let num = 4
        static let del = 5
        //static let sub = 6
    }
    
    let keyboard = Keyboard()
    
    
    let viewWidth = totalWidth
    let viewHeight = isIPad ? totalHeight : totalHeight / 1.15
    var barHeight = isIPad ? 0 : totalHeight * 0.15
  
    // Ipad and iOS lower than 10 doesn't have the top bar.
    if #available(iOSApplicationExtension 9.0, *){
    } else {
      barHeight = 0.0
    }
    
    // NEED AN EXTRA BAR ON THE TOP FOR THE POPUP. ONLY FOR iPHONES
    let topBar = UIView()

    //top border
    let border = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    topBar.addSubview(border)
    //border.backgroundColor = UIColor(rgb:0x6D8858)
    border.backgroundColor = UIColor(rgb:0xC0C9AA)
    border.heightAnchor.constraint(equalToConstant: 1).isActive = true
    border.widthAnchor.constraint(equalTo: topBar.widthAnchor, multiplier: 1.0).isActive = true
    border.heightAnchor.constraint(equalToConstant: barHeight).isActive = true

    border.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 0).isActive = true
    border.topAnchor.constraint(equalTo: topBar.topAnchor, constant: 0).isActive = true
    border.translatesAutoresizingMaskIntoConstraints = false

    // Send feedback button to the topBar.
    let feedbackButton = UILabel()
    feedbackButton.text = " " //Password Grid"
    feedbackButton.textColor = Colors.keyboardKeysText //theme.keyboardTitleColor
    topBar.addSubview(feedbackButton)

    feedbackButton.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
    feedbackButton.leftAnchor.constraint(equalTo: topBar.leftAnchor, constant: 10.0).isActive = true
    feedbackButton.translatesAutoresizingMaskIntoConstraints = false

    //images
    let image = UIImage(named: "logo")
    let imageView = UIImageView(image: image!)
    imageView.contentMode = UIView.ContentMode.scaleAspectFit

    topBar.addSubview(imageView)
    imageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 183).isActive = true
    imageView.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 10).isActive = true
    imageView.topAnchor.constraint(equalTo: topBar.topAnchor, constant: 14).isActive = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    //switch
    
    let defaults:UserDefaults = UserDefaults.standard
    defaults.register(defaults: [
        "switchOn": true,
        ])
    let switchOn = defaults.bool(forKey: "switchOn" )
    
    let switchColor = UIColor(rgb:0x72b227)
    keyboard.switchView = UISwitch()
    //keyboard.switchView.isOn = switchOn
    keyboard.switchView.setOn(switchOn, animated: false)
    keyboard.switchView.onTintColor = switchColor

    //keyboard.switchView(keyboard, action: #selector(switchChanged), for: UIControlEvents.valueChanged)
    //keyboard.switchView.addTarget(keyboard, action: #selector(switchChanged(_:)), for: UIControlEvents.valueChanged)

    topBar.addSubview(keyboard.switchView)
  
//    keyboard.switchView.heightAnchor.constraint(equalToConstant: 18).isActive = true
//    keyboard.switchView.widthAnchor.constraint(equalToConstant: 183).isActive = true
    keyboard.switchView.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 205).isActive = true
    keyboard.switchView.topAnchor.constraint(equalTo: topBar.topAnchor, constant: 6).isActive = true
    keyboard.switchView.translatesAutoresizingMaskIntoConstraints = false


    //gear button
//    keyboard.gearButton = UIButton()
//    keyboard.gearButton.setImage(UIImage(named: "gear"), for: .normal)
//    keyboard.gearButton.tintColor = switchColor
//    //topBar.addSubview(keyboard.gearButton)
//    keyboard.gearButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
//    keyboard.gearButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
//    keyboard.gearButton.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -10).isActive = true
//    keyboard.gearButton.topAnchor.constraint(equalTo: topBar.topAnchor, constant: 14).isActive = true
//    keyboard.gearButton.translatesAutoresizingMaskIntoConstraints = false

    keyboard.setupTargets()
    
    //top
    controller.view.addSubview(topBar)
    topBar.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
    topBar.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
    topBar.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
    topBar.translatesAutoresizingMaskIntoConstraints = false
    topBar.backgroundColor = theme.keyboardBackgroundColor
    
    
//    topBar.layer.borderWidth = 2
//    topBar.layer.borderColor = UIColor.blue.cgColor
//
    // Just to save myself from typos
    struct specialKey {
        static let shift = "shift"
        static let backspace = "backspace"
        static let num = "123"
        static let change = "keyboardchange"
        static let space = "space"
        static let sym = "Sym"
        static let enter = "return"
        static let ABC = "ABC"
    }
    
    //group
    let appGroupID = "group.com.skyriser.passwordgrid"
    let group = UserDefaults(suiteName: appGroupID)
    let matrixArray = group?.stringArray(forKey: "matrixArray") ?? [String]()
    

    
    // NOTE :: You cannot just simply replace the following chart.
    // Needs more work to be programmatic. More like a reference.
    
    var keyboardLayout : [Int: page] = [:]
    // Unshift
    var unshiftPage = page()
    unshiftPage.keyboard = [["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
                                ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
                                ["shift","z", "x", "c", "v", "b", "n", "m","backspace"],
                                ["123","keyboardchange", "space",".", "return"]
    ]
    keyboardLayout[MODE_CHANGE_ID.unshift] = unshiftPage
    // Shift
    var shiftPage = page()
    
        shiftPage.keyboard = [["Q", "W", "E", "R", "T", "Y", "Y", "I", "O", "P"],
             ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
             ["unshift","Z", "X", "C", "V", "B", "N", "M","backspace"],
             ["123","keyboardchange", "space","?", "return"]

    ]
    
    keyboardLayout[MODE_CHANGE_ID.shift] = shiftPage
    
    
    // subscript
    /*var subPage = page()
    subPage.keyboard = [["??", "??", "??", "??", "??", "??", "??", "??", "??", "??"],
                         ["??", "??", "??", "??", "??", "??", "??", "??", "??"],
                         ["unshift","??", "??", "??", "??", "??", "??", "??","backspace"],
                         ["123","keyboardchange", "space","?", "return"]
                            ]
*/
    /*if(matrixArray.count > 0)
    {
        (subPage.keyboard[0])[0] = matrixArray[0]
        (subPage.keyboard[0])[1] = matrixArray[1]
        (subPage.keyboard[0])[2] = matrixArray[2]
        (subPage.keyboard[0])[3] = matrixArray[3]
        (subPage.keyboard[0])[4] = matrixArray[4]
        (subPage.keyboard[0])[5] = matrixArray[5]
        (subPage.keyboard[0])[6] = matrixArray[6]
        (subPage.keyboard[0])[7] = matrixArray[7]
        (subPage.keyboard[0])[8] = matrixArray[8]
        (subPage.keyboard[0])[9] = matrixArray[9]
        
        (subPage.keyboard[1])[0] = matrixArray[10]
        (subPage.keyboard[1])[1] = matrixArray[11]
        (subPage.keyboard[1])[2] = matrixArray[12]
        (subPage.keyboard[1])[3] = matrixArray[13]
        (subPage.keyboard[1])[4] = matrixArray[14]
        (subPage.keyboard[1])[5] = matrixArray[15]
        (subPage.keyboard[1])[6] = matrixArray[16]
        (subPage.keyboard[1])[7] = matrixArray[17]
        (subPage.keyboard[1])[8] = matrixArray[18]
        
        //(subPage.keyboard[2])[0] = matrixArray[0]
        (subPage.keyboard[2])[1] = matrixArray[19]
        (subPage.keyboard[2])[2] = matrixArray[20]
        (subPage.keyboard[2])[3] = matrixArray[21]
        (subPage.keyboard[2])[4] = matrixArray[22]
        (subPage.keyboard[2])[5] = matrixArray[23]
        (subPage.keyboard[2])[6] = matrixArray[24]
        (subPage.keyboard[2])[7] = matrixArray[25]
        (subPage.keyboard[2])[8] = matrixArray[26]
        //(subPage.keyboard[2])[9] = matrixArray[0]
    }*/
    
    
    //keyboardLayout[MODE_CHANGE_ID.sub] = subPage


    keyboardLayout[MODE_CHANGE_ID.shift] = shiftPage
    // 123
    var numPage = page()
    numPage.keyboard = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                        ["/", "\"", "ꓹꓼ", "(", ")", "$", "&", "@","!"],
                        ["sym","#", "+", "=", "-", "+", "<", ">","backspace"],
                        ["ABC","keyboardchange", "space",",", "return"]
    ]
    keyboardLayout[MODE_CHANGE_ID.num] = numPage
    // Sym
    var symPage = page()
    symPage.keyboard = [["[", "]", "{", "}", "#", "%", "^", "*", "+", "="],
                        ["~", "`", "{", "}", "_", "-", "=", "|", "§"],
                        ["123", "|", "~", "<", ">", "€", "£", "¥", "backspace"],
                        ["ABC","keyboardchange", "space", "•", "return"]
    ]
    keyboardLayout[MODE_CHANGE_ID.sym] = symPage
    
    

    
    
    
    // Padding for the buttons
    let GAP_RATIO: CGFloat = 0.015
    var GAP_WIDTH: CGFloat = GAP_RATIO * viewWidth // 1.2% of the whole width
    
    if !isPortrait {
        GAP_WIDTH = GAP_RATIO * 0.66 * viewWidth
    }
    
    var GAP_HEIGHT: CGFloat = GAP_WIDTH * 1.75
    
    if !isPortrait {
        GAP_HEIGHT = GAP_WIDTH
    }
    
    let GAP_SIZE = CGSize(width: GAP_WIDTH, height: GAP_HEIGHT)
    
    let MAX_NUM_GAP_HOR: CGFloat = 11 // Max horizontal key is ten, so there are eleven gaps.
    let MAX_NUM_GAP_VER: CGFloat = 5 // There are five rows. So, five gaps
    
    // Determine button width
    // So many magic numbers... :<<<
    let characterSize = CGSize(width: (viewWidth-(GAP_WIDTH * MAX_NUM_GAP_HOR))/10, height: (viewHeight - (GAP_HEIGHT * MAX_NUM_GAP_VER))/4)
    let shiftDeleteSize = CGSize(width: (viewWidth - characterSize.width * 7 - GAP_WIDTH * 10)/2, height: characterSize.height ) // There are seven keys between shift and delete.
    let spacebarSize = CGSize(width: (characterSize.width * 5 + GAP_WIDTH * 4), height: characterSize.height)
    
    // Icons
    let changeKeyboardIcon = "globe.png"
    let enterIcon = "\u{000023CE}"
    let backspaceIcon = "\u{0000232B}"
    let shiftIcon = "\u{00021E7}"
    
    // Keyboard with associated pages
    //let keyboard = Keyboard()
    
    keyboard.keys[MODE_CHANGE_ID.unshift] = []
    keyboard.keys[MODE_CHANGE_ID.shift] = []
    keyboard.keys[MODE_CHANGE_ID.num] = []
    keyboard.keys[MODE_CHANGE_ID.sym] = []
    //keyboard.keys[MODE_CHANGE_ID.sub] = []

    let specialFont = UIFont.systemFont(ofSize: Constants.keyFontSize)
    let normalFont = UIFont(name: "Menlo-Regular", size: Constants.keyFontSize)

    
    // Reusable Keys
    let charKey = Key(type: .character, keyValue: "", width: characterSize.width, height: characterSize.height, parentView: controller.view, gapSize: GAP_SIZE)
    
    let backspaceKey = Key(type: .backspace, keyValue: backspaceIcon, width: shiftDeleteSize.width, height: shiftDeleteSize.height, parentView: controller.view, tag: MODE_CHANGE_ID.del, gapSize: GAP_SIZE)
    backspaceKey.button.titleLabel?.font = normalFont

    let enterKey = Key(type: .enter, keyValue: enterIcon, width: shiftDeleteSize.width, height: characterSize.height, parentView: controller.view, gapSize: GAP_SIZE)
    enterKey.button.titleLabel?.font = normalFont

    let changeKeyboardKey = Key(type: .keyboardChange, keyImage: changeKeyboardIcon, width: characterSize.width, height: characterSize.height, parentView: controller.view, gapSize: GAP_SIZE)
    
    // Mode change buttons
    let unshiftKey = Key(type: .modeChange, keyValue: specialKey.ABC, width: shiftDeleteSize.width, height: shiftDeleteSize.height, parentView: controller.view, tag: MODE_CHANGE_ID.unshift, gapSize: GAP_SIZE)
    let shiftKey = Key(type: .modeChange, keyValue: shiftIcon, width: shiftDeleteSize.width, height: shiftDeleteSize.height, parentView: controller.view, tag: MODE_CHANGE_ID.shift, gapSize: GAP_SIZE)
    shiftKey.button.titleLabel?.font = normalFont

    let symKey = Key(type: .modeChange, keyValue: specialKey.sym, width: characterSize.width, height: characterSize.height, parentView: controller.view, tag: MODE_CHANGE_ID.sym, gapSize: GAP_SIZE)
    let numKey = Key(type: .modeChange, keyValue: specialKey.num, width: shiftDeleteSize.width, height: characterSize.height, parentView: controller.view, tag: MODE_CHANGE_ID.num, gapSize: GAP_SIZE)

    
    //============================================//
    // UNSHIFT PAGE
    //============================================//
    // First Row
    var firstRow = keyboardLayout[MODE_CHANGE_ID.unshift]?.keyboard[0]
    //var subscriptFirstRow = keyboardLayout[MODE_CHANGE_ID.sub]?.keyboard[0]
    
    var firstRowKeys : [Key] = []
    // Create keys
    for i in 0..<firstRow!.count {
        let currKey = charKey.copy(keyValue: firstRow?[i])
        currKey.button.isFirstRow = true
        currKey.button.titleLabel?.font = normalFont
        
        // Add preview subscript to the unshift page.
        //currKey.addSubscript(subScript: (subscriptFirstRow?[i])!, isIPad: isIPad)
        //currKey.addSubscript(subScript: "??", isIPad: isIPad)
        currKey.addSubscript(subScript: getPassKey(matrixArray: matrixArray, key: currKey.keyValue!), isIPad: isIPad)

        firstRowKeys.append(currKey)
    }
    // Add constraints for first row
    for (i,_) in firstRowKeys.enumerated() {
        firstRowKeys[i].button.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        // Top left
        if i == 0 {
            firstRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: GAP_WIDTH).isActive = true
        } else {
            firstRowKeys[i].button.leftAnchor.constraint(equalTo: firstRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    // Second Row
    var secondRow = keyboardLayout[MODE_CHANGE_ID.unshift]?.keyboard[1]
   // var subscriptSecondRow = keyboardLayout[MODE_CHANGE_ID.sub]?.keyboard[1]
    
    var secondRowKeys : [Key] = []
    // Create keys
    for i in 0..<secondRow!.count {
        let currKey = charKey.copy(keyValue: secondRow?[i])
        // Add preview subscript to the unshift page.
        //currKey.addSubscript(subScript: (subscriptSecondRow?[i])!, isIPad: isIPad)
        //currKey.addSubscript(subScript: "??", isIPad: isIPad)
        currKey.addSubscript(subScript: getPassKey(matrixArray: matrixArray, key: currKey.keyValue!), isIPad: isIPad)

        currKey.button.titleLabel?.font = normalFont

        secondRowKeys.append(currKey)
    }
    // Add Padding before Second Row
    // Padding left
    let secondRowGapCount = secondRowKeys.count - 1
    let paddingLeft = (viewWidth - characterSize.width * CGFloat((secondRow?.count)!) - GAP_WIDTH * CGFloat(secondRowGapCount))/2
    // Add constraints for second row
    for (i,_) in secondRowKeys.enumerated() {
        secondRowKeys[i].button.topAnchor.constraint(equalTo: firstRowKeys[0].button.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        
        // Leftmostkey
        if i == 0 {
            secondRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: paddingLeft).isActive = true
        } else {
            secondRowKeys[i].button.leftAnchor.constraint(equalTo: secondRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    // Third Row
    var thirdRow = keyboardLayout[MODE_CHANGE_ID.unshift]?.keyboard[2]
    //var subscriptThirdRow = keyboardLayout[MODE_CHANGE_ID.sub]?.keyboard[2]
    
    var thirdRowKeys : [Key] = []
    // Create keys
    for i in 0..<thirdRow!.count {
        var currKey = Key()
        currKey.button.titleLabel?.font = normalFont

        if thirdRow?[i] == specialKey.shift {
            // Shift
            currKey = shiftKey.copy()
            //currKey.button.titleLabel?.font = normalFont

        } else if thirdRow?[i] == specialKey.backspace {
            // Backspace
            currKey = backspaceKey.copy()
            //currKey.button.titleLabel?.font = normalFont
        }else {
            currKey = charKey.copy(keyValue: thirdRow?[i])
            currKey.button.titleLabel?.font = specialFont

            // Add preview subscript to the unshift page.
            //currKey.addSubscript(subScript: (subscriptThirdRow?[i])!, isIPad: isIPad)
            //currKey.addSubscript(subScript: "??", isIPad: isIPad)
            currKey.addSubscript(subScript: getPassKey(matrixArray: matrixArray, key: currKey.keyValue!), isIPad: isIPad)

        }
        
        
        thirdRowKeys.append(currKey)
    }
    // Add constraints for third row
    for (i,_) in thirdRowKeys.enumerated() {
        thirdRowKeys[i].button.topAnchor.constraint(equalTo: secondRowKeys[0].button.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        // Left
        if i == 0 {
            thirdRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: GAP_WIDTH).isActive = true
        } else {
            thirdRowKeys[i].button.leftAnchor.constraint(equalTo: thirdRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    // Last Row
    var lastRowKeys : [Key] = []
    // Change to number button
    lastRowKeys.append(numKey.copy())
    // Change keyboard button
    lastRowKeys.append(changeKeyboardKey.copy())
    // Spacebar button
    lastRowKeys.append(charKey.copy(type: .space, keyValue: " ", width: spacebarSize.width))
    // Period button
    lastRowKeys.append(charKey.copy(keyValue: "."))
    // Return button
    lastRowKeys.append(enterKey.copy())
    // Add constraints for Last row
    for (i,_) in lastRowKeys.enumerated() {
        lastRowKeys[i].button.topAnchor.constraint(equalTo: thirdRowKeys[0].button.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        //lastRowKeys[i].button.titleLabel?.font = normalFont

        // Top left
        if i == 0 {
            lastRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: GAP_WIDTH).isActive = true
        } else {
            lastRowKeys[i].button.leftAnchor.constraint(equalTo: lastRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    // Add the keys to the keybaord with their associated state
    keyboard.keys[MODE_CHANGE_ID.unshift] = []
    keyboard.keys[MODE_CHANGE_ID.unshift]?.append(firstRowKeys)
    keyboard.keys[MODE_CHANGE_ID.unshift]?.append(secondRowKeys)
    keyboard.keys[MODE_CHANGE_ID.unshift]?.append(thirdRowKeys)
    keyboard.keys[MODE_CHANGE_ID.unshift]?.append(lastRowKeys)
 
    
    //============================================//
    // SHIFTPAGE
    //============================================//
    // Shift Page
    firstRow = keyboardLayout[MODE_CHANGE_ID.shift]?.keyboard[0]
    firstRowKeys = []
    // First Row
    for (i, currChar) in firstRow!.enumerated() {
        let currKey = charKey.copy(keyValue: currChar)
        currKey.button.isFirstRow = true
        
        ///currKey.addSubscript(subScript: (subscriptFirstRow?[i])!, isIPad: isIPad)
        //currKey.addSubscript(subScript: "??", isIPad: isIPad)
        currKey.addSubscript(subScript: getPassKey(matrixArray: matrixArray, key: currKey.keyValue!), isIPad: isIPad)


        firstRowKeys.append(currKey)
    }
    // Add constraints for first row
    for (i,_) in firstRowKeys.enumerated() {
        firstRowKeys[i].button.topAnchor.constraint(equalTo:  topBar.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        
        // Top left
        if i == 0 {
            firstRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: GAP_WIDTH).isActive = true
        } else {
            firstRowKeys[i].button.leftAnchor.constraint(equalTo: firstRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    // Second Row
    secondRow = keyboardLayout[MODE_CHANGE_ID.shift]?.keyboard[1]
    secondRowKeys = []
    // Add Padding before Second Row
    for (i, currChar) in secondRow!.enumerated() {

        let currKey = charKey.copy(keyValue: currChar)
        
        //currKey.addSubscript(subScript: (subscriptSecondRow?[i])!, isIPad: isIPad)
        //currKey.addSubscript(subScript: "??", isIPad: isIPad)
        currKey.addSubscript(subScript: getPassKey(matrixArray: matrixArray, key: currKey.keyValue!), isIPad: isIPad)

        secondRowKeys.append(currKey)
    }
    // Add constraints for second row
    for (i,_) in secondRowKeys.enumerated() {
        secondRowKeys[i].button.topAnchor.constraint(equalTo: firstRowKeys[0].button.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        
        // Top left
        if i == 0 {
            secondRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: paddingLeft).isActive = true
        } else {
            secondRowKeys[i].button.leftAnchor.constraint(equalTo: secondRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    // Third Row
    thirdRow = keyboardLayout[MODE_CHANGE_ID.shift]?.keyboard[2]
    thirdRowKeys = []
    // Shift key
    thirdRowKeys.append(unshiftKey.copy())
    // Keys between shift and backspace
    for i in 1...(thirdRow!.count - 2) {
        let currKey = charKey.copy(keyValue: thirdRow?[i])
        
        //currKey.addSubscript(subScript: (subscriptThirdRow?[i])!, isIPad: isIPad)
        //currKey.addSubscript(subScript: "??", isIPad: isIPad)
        currKey.addSubscript(subScript: getPassKey(matrixArray: matrixArray, key: currKey.keyValue!), isIPad: isIPad)

        thirdRowKeys.append(currKey)
    }
    // Backspace key
    thirdRowKeys.append(backspaceKey.copy())
    // Add constraints for third row
    for (i,_) in thirdRowKeys.enumerated() {
        thirdRowKeys[i].button.topAnchor.constraint(equalTo: secondRowKeys[0].button.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        
        // Left
        if i == 0 {
            thirdRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: GAP_WIDTH).isActive = true
        } else {
            thirdRowKeys[i].button.leftAnchor.constraint(equalTo: thirdRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    // Last Row
    lastRowKeys = []
    // Change to number button
    lastRowKeys.append(numKey.copy())
    // Change keyboard button
    lastRowKeys.append(changeKeyboardKey.copy())
    // Spacebar button
    lastRowKeys.append(charKey.copy(type: .space, keyValue: " ", width: spacebarSize.width))
    // Period button
    lastRowKeys.append(charKey.copy(keyValue: "?"))
    // Return button
    lastRowKeys.append(enterKey.copy())
    
    // Add constraints for third row
    for (i,_) in lastRowKeys.enumerated() {
        lastRowKeys[i].button.topAnchor.constraint(equalTo: thirdRowKeys[0].button.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        
        // Top left
        if i == 0 {
            lastRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: GAP_WIDTH).isActive = true
        } else {
            lastRowKeys[i].button.leftAnchor.constraint(equalTo: lastRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    keyboard.keys[MODE_CHANGE_ID.shift]?.append(firstRowKeys)
    keyboard.keys[MODE_CHANGE_ID.shift]?.append(secondRowKeys)
    keyboard.keys[MODE_CHANGE_ID.shift]?.append(thirdRowKeys)
    keyboard.keys[MODE_CHANGE_ID.shift]?.append(lastRowKeys)
    
    //============================================//
    // 123 PAGE
    //============================================//
    firstRow = keyboardLayout[MODE_CHANGE_ID.num]?.keyboard[0]
    firstRowKeys = []
//    // First Row
    for (i, currChar) in firstRow!.enumerated() {
        let currKey = charKey.copy(keyValue: currChar)
        currKey.button.isFirstRow = true
        
        //currKey.addSubscript(subScript: (subscriptSecondRow?[i])!, isIPad: isIPad)
        //currKey.addSubscript(subScript: "??", isIPad: isIPad)
        currKey.addSubscript(subScript: getPassKey(matrixArray: matrixArray, key: currKey.keyValue!), isIPad: isIPad)

        firstRowKeys.append(currKey)
    }
    // Add constraints for first row
    for (i,_) in firstRowKeys.enumerated() {
        firstRowKeys[i].button.topAnchor.constraint(equalTo:  topBar.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        
        // Top left
        if i == 0 {
            firstRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: GAP_WIDTH).isActive = true
        } else {
            firstRowKeys[i].button.leftAnchor.constraint(equalTo: firstRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    // Second Row
    secondRow = keyboardLayout[MODE_CHANGE_ID.num]?.keyboard[1]
    secondRowKeys = []
    // Add Padding before Second Row
    for currChar in secondRow! {
        let currKey = charKey.copy(keyValue: currChar)
        secondRowKeys.append(currKey)
    }
    // Add constraints for second row
    for (i,_) in secondRowKeys.enumerated() {
        secondRowKeys[i].button.topAnchor.constraint(equalTo: firstRowKeys[0].button.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        
        // Second row padding
        if i == 0 {
            secondRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: paddingLeft).isActive = true
        } else {
            secondRowKeys[i].button.leftAnchor.constraint(equalTo: secondRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
//    
//    // Third Row
    thirdRow = keyboardLayout[MODE_CHANGE_ID.num]?.keyboard[2]
    thirdRowKeys = []
    // Sym key
    thirdRowKeys.append(symKey.copy(width:shiftDeleteSize.width, height:shiftDeleteSize.height))
    // Keys between sym and backspace
    for i in 1...(thirdRow!.count - 2) {
        let currKey = charKey.copy(keyValue: thirdRow?[i])
        thirdRowKeys.append(currKey)
    }
    // Backspace key
    thirdRowKeys.append(backspaceKey.copy())
    // Add constraints for third row
    for (i,_) in thirdRowKeys.enumerated() {
        thirdRowKeys[i].button.topAnchor.constraint(equalTo: secondRowKeys[0].button.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        
        // Left
        if i == 0 {
            thirdRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: GAP_WIDTH).isActive = true
        } else {
            thirdRowKeys[i].button.leftAnchor.constraint(equalTo: thirdRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    // Last Row
    lastRowKeys = []
    // Change to number button
    lastRowKeys.append(unshiftKey.copy())
    // Change keyboard button
    lastRowKeys.append(changeKeyboardKey.copy())
    // Spacebar button
    lastRowKeys.append(charKey.copy(type: .space, keyValue: " ", width: spacebarSize.width))
    // Comma button
    lastRowKeys.append(charKey.copy(keyValue: ","))
    // Return button
    lastRowKeys.append(enterKey.copy())
    
    // Add constraints for third row
    for (i,_) in lastRowKeys.enumerated() {
        lastRowKeys[i].button.topAnchor.constraint(equalTo: thirdRowKeys[0].button.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        
        // Top left
        if i == 0 {
            lastRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: GAP_WIDTH).isActive = true
        } else {
            lastRowKeys[i].button.leftAnchor.constraint(equalTo: lastRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    keyboard.keys[MODE_CHANGE_ID.num]?.append(firstRowKeys)
    keyboard.keys[MODE_CHANGE_ID.num]?.append(secondRowKeys)
    keyboard.keys[MODE_CHANGE_ID.num]?.append(thirdRowKeys)
    keyboard.keys[MODE_CHANGE_ID.num]?.append(lastRowKeys)
    
    
    //============================================//
    // SYM PAGE
    //============================================//
    firstRow = keyboardLayout[MODE_CHANGE_ID.sym]?.keyboard[0]
    firstRowKeys = []
    //    // First Row
    for currChar in firstRow! {
        let currKey = charKey.copy(keyValue: currChar)
        currKey.button.isFirstRow = true
        firstRowKeys.append(currKey)
    }
    // Add constraints for first row
    for (i,_) in firstRowKeys.enumerated() {
        firstRowKeys[i].button.topAnchor.constraint(equalTo:  topBar.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        
        // Top left
        if i == 0 {
            firstRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: GAP_WIDTH).isActive = true
        } else {
            firstRowKeys[i].button.leftAnchor.constraint(equalTo: firstRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    // Second Row
    secondRow = keyboardLayout[MODE_CHANGE_ID.sym]?.keyboard[1]
    secondRowKeys = []
    // Add Padding before Second Row
    for currChar in secondRow! {
        let currKey = charKey.copy(keyValue: currChar)
        secondRowKeys.append(currKey)
    }
    // Add constraints for second row
    for (i,_) in secondRowKeys.enumerated() {
        secondRowKeys[i].button.topAnchor.constraint(equalTo: firstRowKeys[0].button.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        
        // Top left
        if i == 0 {
            secondRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: paddingLeft).isActive = true
        } else {
            secondRowKeys[i].button.leftAnchor.constraint(equalTo: secondRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    // Third Row
    thirdRow = keyboardLayout[MODE_CHANGE_ID.sym]?.keyboard[2]
    thirdRowKeys = []
    // SYM key
    thirdRowKeys.append(numKey.copy(width:shiftDeleteSize.width, height: shiftDeleteSize.height))
    // Keys between sym and backspace
    for i in 1...(thirdRow!.count - 2) {
        let currKey = charKey.copy(keyValue: thirdRow?[i])
        thirdRowKeys.append(currKey)
    }
    // Backspace key
    thirdRowKeys.append(backspaceKey.copy())
    // Add constraints for third row.
    for (i,_) in thirdRowKeys.enumerated() {
        thirdRowKeys[i].button.topAnchor.constraint(equalTo: secondRowKeys[0].button.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        
        // Left
        if i == 0 {
            thirdRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: GAP_WIDTH).isActive = true
        } else {
            thirdRowKeys[i].button.leftAnchor.constraint(equalTo: thirdRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    // Last Row
    lastRowKeys = []
    // Change to number button
    lastRowKeys.append(unshiftKey.copy())
    // Change keyboard button
    lastRowKeys.append(changeKeyboardKey.copy())
    // Spacebar button
    lastRowKeys.append(charKey.copy(type: .space, keyValue: " ", width: spacebarSize.width))
    // BulletPoint button
    lastRowKeys.append(charKey.copy(keyValue: "•"))
    // Return button
    lastRowKeys.append(enterKey.copy())
    // Add constraints for Last row
    for (i,_) in lastRowKeys.enumerated() {
        lastRowKeys[i].button.topAnchor.constraint(equalTo: thirdRowKeys[0].button.bottomAnchor, constant: GAP_HEIGHT).isActive = true
        
        // Top left
        if i == 0 {
            lastRowKeys[i].button.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: GAP_WIDTH).isActive = true
        } else {
            lastRowKeys[i].button.leftAnchor.constraint(equalTo: lastRowKeys[i-1].button.rightAnchor, constant: GAP_WIDTH).isActive = true
        }
    }
    
    keyboard.keys[MODE_CHANGE_ID.sym]?.append(firstRowKeys)
    keyboard.keys[MODE_CHANGE_ID.sym]?.append(secondRowKeys)
    keyboard.keys[MODE_CHANGE_ID.sym]?.append(thirdRowKeys)
    keyboard.keys[MODE_CHANGE_ID.sym]?.append(lastRowKeys)
        
    return keyboard
}
