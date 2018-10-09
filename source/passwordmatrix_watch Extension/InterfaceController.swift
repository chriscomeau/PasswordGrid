//
//  InterfaceController.swift
//  passwordmatrix_watch Extension
//
//  Created by Chris Comeau on 2018-09-21.
//

import WatchKit
import Foundation
import UIKit
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    var watchSession : WCSession?

    var matrixArray : [String] = [String]()

    @IBOutlet weak var text1: WKInterfaceLabel?
    @IBOutlet weak var text2: WKInterfaceLabel?
    @IBOutlet weak var text3: WKInterfaceLabel?
    @IBOutlet weak var text4: WKInterfaceLabel?
    @IBOutlet weak var text5: WKInterfaceLabel?
    @IBOutlet weak var text6: WKInterfaceLabel?
    @IBOutlet weak var text7: WKInterfaceLabel?
    @IBOutlet weak var text8: WKInterfaceLabel?
    @IBOutlet weak var text9: WKInterfaceLabel?
    @IBOutlet weak var text10: WKInterfaceLabel?
    @IBOutlet weak var text11: WKInterfaceLabel?
    @IBOutlet weak var text12: WKInterfaceLabel?
    @IBOutlet weak var text13: WKInterfaceLabel?
    @IBOutlet weak var text14: WKInterfaceLabel?
    @IBOutlet weak var text15: WKInterfaceLabel?
    @IBOutlet weak var text16: WKInterfaceLabel?
    @IBOutlet weak var text17: WKInterfaceLabel?
    @IBOutlet weak var text18: WKInterfaceLabel?
    @IBOutlet weak var text19: WKInterfaceLabel?
    @IBOutlet weak var text20: WKInterfaceLabel?
    @IBOutlet weak var text21: WKInterfaceLabel?
    @IBOutlet weak var text22: WKInterfaceLabel?
    @IBOutlet weak var text23: WKInterfaceLabel?
    @IBOutlet weak var text24: WKInterfaceLabel?
    @IBOutlet weak var text25: WKInterfaceLabel?
    @IBOutlet weak var text26: WKInterfaceLabel?
    @IBOutlet weak var text27: WKInterfaceLabel?
    @IBOutlet weak var text28: WKInterfaceLabel?
    @IBOutlet weak var text29: WKInterfaceLabel?
    @IBOutlet weak var text30: WKInterfaceLabel?
    @IBOutlet weak var text31: WKInterfaceLabel?
    @IBOutlet weak var text32: WKInterfaceLabel?
    @IBOutlet weak var text33: WKInterfaceLabel?
    @IBOutlet weak var text34: WKInterfaceLabel?
    @IBOutlet weak var text35: WKInterfaceLabel?
    @IBOutlet weak var text36: WKInterfaceLabel?
    //
    @IBOutlet weak var label1: WKInterfaceLabel?
    @IBOutlet weak var label2: WKInterfaceLabel?
    @IBOutlet weak var label3: WKInterfaceLabel?
    @IBOutlet weak var label4: WKInterfaceLabel?
    @IBOutlet weak var label5: WKInterfaceLabel?
    @IBOutlet weak var label6: WKInterfaceLabel?
    @IBOutlet weak var label7: WKInterfaceLabel?
    @IBOutlet weak var label8: WKInterfaceLabel?
    @IBOutlet weak var label9: WKInterfaceLabel?
    @IBOutlet weak var label10: WKInterfaceLabel?
    @IBOutlet weak var label11: WKInterfaceLabel?
    @IBOutlet weak var label12: WKInterfaceLabel?
    @IBOutlet weak var label13: WKInterfaceLabel?
    @IBOutlet weak var label14: WKInterfaceLabel?
    @IBOutlet weak var label15: WKInterfaceLabel?
    @IBOutlet weak var label16: WKInterfaceLabel?
    @IBOutlet weak var label17: WKInterfaceLabel?
    @IBOutlet weak var label18: WKInterfaceLabel?
    @IBOutlet weak var label19: WKInterfaceLabel?
    @IBOutlet weak var label20: WKInterfaceLabel?
    @IBOutlet weak var label21: WKInterfaceLabel?
    @IBOutlet weak var label22: WKInterfaceLabel?
    @IBOutlet weak var label23: WKInterfaceLabel?
    @IBOutlet weak var label24: WKInterfaceLabel?
    @IBOutlet weak var label25: WKInterfaceLabel?
    @IBOutlet weak var label26: WKInterfaceLabel?
    @IBOutlet weak var label27: WKInterfaceLabel?
    @IBOutlet weak var label28: WKInterfaceLabel?
    @IBOutlet weak var label29: WKInterfaceLabel?
    @IBOutlet weak var label30: WKInterfaceLabel?
    @IBOutlet weak var label31: WKInterfaceLabel?
    @IBOutlet weak var label32: WKInterfaceLabel?
    @IBOutlet weak var label33: WKInterfaceLabel?
    @IBOutlet weak var label34: WKInterfaceLabel?
    @IBOutlet weak var label35: WKInterfaceLabel?
    @IBOutlet weak var label36: WKInterfaceLabel?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        //setupGridText()
        
        //self.setTitle("Password Grid")
        
        matrixArray = [String]()
        loadArray()
        setupGridText()
    }
    
    func loadArray() {
        //userDefaults
        let prefs = UserDefaults.standard
        //matrixArray = [String]()
        if prefs.object(forKey: "matrixArray") != nil {
            matrixArray = prefs.object(forKey: "matrixArray") as! [String]
        }

    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        print("willActivate")
        
        
        if(WCSession.isSupported()){
            watchSession = WCSession.default
            // Add self as a delegate of the session so we can handle messages
            watchSession!.delegate = self
            watchSession!.activate()
        }

        
        setupGridText()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func setupGridText() {
//        let appGroupID = "group.com.skyriser.passwordgrid"
//        let group = UserDefaults(suiteName: appGroupID)
        //let matrixArray = group?.stringArray(forKey: "matrixArray") ?? [String]()

        loadArray()

        
        let textArray = [ text1,text2,text3,text4,text5,text6,text7,text8,text9,text10,
                          text11,text12,text13,text14,text15,text16,text17,text18,text19,text20,
                          text21,text22,text23,text24,text25,text26,text27,text28,text29,text30,
                          text31,text32,text33,text34,text35,text36]
        
        
        if matrixArray.count >= textArray.count {
            
            for (i, label) in textArray.enumerated() {
                
                label?.setText(matrixArray[i])
                
            }
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith")
    }
    
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("didReceiveApplicationContext")

//        let message : String = applicationContext["message"] as! String
//        messageLabel.setText(message)
        
        
//        let appGroupID = "group.com.skyriser.passwordgrid"
//        let group = UserDefaults(suiteName: appGroupID)
        
        //let matrixArray = group?.stringArray(forKey: "matrixArray") ?? [String]()
        let tempMatrixArray:[String] = applicationContext["matrixArray"] as! [String]
        
        
        let textArray = [ text1,text2,text3,text4,text5,text6,text7,text8,text9,text10,
                          text11,text12,text13,text14,text15,text16,text17,text18,text19,text20,
                          text21,text22,text23,text24,text25,text26,text27,text28,text29,text30,
                          text31,text32,text33,text34,text35,text36]
        
        
        if tempMatrixArray.count >= textArray.count {
            matrixArray = tempMatrixArray

            //save it
            let prefs = UserDefaults.standard
            prefs.set(matrixArray, forKey:"matrixArray")
        }

        setupGridText()
    }

}
