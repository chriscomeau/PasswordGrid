//
//  TodayViewController.swift
//  passwordmatrix_today
//
//  Created by Chris Comeau on 2018-09-20.
//

import UIKit
import NotificationCenter
import Foundation

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var text1: UILabel?
    @IBOutlet weak var text2: UILabel?
    @IBOutlet weak var text3: UILabel?
    @IBOutlet weak var text4: UILabel?
    @IBOutlet weak var text5: UILabel?
    @IBOutlet weak var text6: UILabel?
    @IBOutlet weak var text7: UILabel?
    @IBOutlet weak var text8: UILabel?
    @IBOutlet weak var text9: UILabel?
    @IBOutlet weak var text10: UILabel?
    @IBOutlet weak var text11: UILabel?
    @IBOutlet weak var text12: UILabel?
    @IBOutlet weak var text13: UILabel?
    @IBOutlet weak var text14: UILabel?
    @IBOutlet weak var text15: UILabel?
    @IBOutlet weak var text16: UILabel?
    @IBOutlet weak var text17: UILabel?
    @IBOutlet weak var text18: UILabel?
    @IBOutlet weak var text19: UILabel?
    @IBOutlet weak var text20: UILabel?
    @IBOutlet weak var text21: UILabel?
    @IBOutlet weak var text22: UILabel?
    @IBOutlet weak var text23: UILabel?
    @IBOutlet weak var text24: UILabel?
    @IBOutlet weak var text25: UILabel?
    @IBOutlet weak var text26: UILabel?
    @IBOutlet weak var text27: UILabel?
    @IBOutlet weak var text28: UILabel?
    @IBOutlet weak var text29: UILabel?
    @IBOutlet weak var text30: UILabel?
    @IBOutlet weak var text31: UILabel?
    @IBOutlet weak var text32: UILabel?
    @IBOutlet weak var text33: UILabel?
    @IBOutlet weak var text34: UILabel?
    @IBOutlet weak var text35: UILabel?
    @IBOutlet weak var text36: UILabel?
    //
    @IBOutlet weak var label1: UILabel?
    @IBOutlet weak var label2: UILabel?
    @IBOutlet weak var label3: UILabel?
    @IBOutlet weak var label4: UILabel?
    @IBOutlet weak var label5: UILabel?
    @IBOutlet weak var label6: UILabel?
    @IBOutlet weak var label7: UILabel?
    @IBOutlet weak var label8: UILabel?
    @IBOutlet weak var label9: UILabel?
    @IBOutlet weak var label10: UILabel?
    @IBOutlet weak var label11: UILabel?
    @IBOutlet weak var label12: UILabel?
    @IBOutlet weak var label13: UILabel?
    @IBOutlet weak var label14: UILabel?
    @IBOutlet weak var label15: UILabel?
    @IBOutlet weak var label16: UILabel?
    @IBOutlet weak var label17: UILabel?
    @IBOutlet weak var label18: UILabel?
    @IBOutlet weak var label19: UILabel?
    @IBOutlet weak var label20: UILabel?
    @IBOutlet weak var label21: UILabel?
    @IBOutlet weak var label22: UILabel?
    @IBOutlet weak var label23: UILabel?
    @IBOutlet weak var label24: UILabel?
    @IBOutlet weak var label25: UILabel?
    @IBOutlet weak var label26: UILabel?
    @IBOutlet weak var label27: UILabel?
    @IBOutlet weak var label28: UILabel?
    @IBOutlet weak var label29: UILabel?
    @IBOutlet weak var label30: UILabel?
    @IBOutlet weak var label31: UILabel?
    @IBOutlet weak var label32: UILabel?
    @IBOutlet weak var label33: UILabel?
    @IBOutlet weak var label34: UILabel?
    @IBOutlet weak var label35: UILabel?
    @IBOutlet weak var label36: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        //setupGridLayout()
        setupGridText()

    }
    
    override func viewDidLayoutSubviews() {
        setupGridLayout()

    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        //setupGridLayout()
        setupGridText()

        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        self.updatePreferredContentSize()
        
        //setupGridLayout()
        setupGridText()

         if activeDisplayMode == .expanded {
         
         } else if activeDisplayMode == .compact {
         
         }
    }
    

    func updatePreferredContentSize() {
        if self.extensionContext?.widgetActiveDisplayMode == .expanded {
         preferredContentSize = CGSize(width:CGFloat(0), height:200)
        }
        else {
            preferredContentSize = CGSize(width:CGFloat(0), height:0)
        }
        
        setupGridLayout()
    }

    
    @IBAction func actionApp(_ sender: UIButton) {
        var urlString1: String = "passwordgrid://"
        
        let urlString2: NSString = urlString1 as NSString
        urlString1 =  urlString2.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let appURL = NSURL(string: urlString1)
        
        self.extensionContext?.open(appURL! as URL, completionHandler: nil)
    }
    
    func setupGridLayout() {
        
        let labelArray = [ label1,label2,label3,label4,label5,label6,label7,label8,label9,label10,
                           label11,label12,label13,label14,label15,label16,label17,label18,label19,label20,
                           label21,label22,label23,label24,label25,label26,label27,label28,label29,label30,
                           label31,label32,label33,label34,label35,label36]
        
        let fontSize:CGFloat = 15.0 //17
        let yStart:Float = 7
        let perRow:Float = 4
        let yOffset:Float = 20
        var font = UIFont(name: "Menlo-Bold", size: fontSize)!
        let alphaDisabled1:CGFloat = 0.6
        let alphaDisabled2:CGFloat = 0.4

        for (i, label) in labelArray.enumerated() {
            
            //font
            label?.font = font
            
            let row = Float(floor(Float(i) / perRow))
            
            //frame
            if var frame = label?.frame {
                frame.origin.y = CGFloat(yStart + (row * yOffset))
                label?.frame = frame
            }
            
            //alpha compact
            if self.extensionContext?.widgetActiveDisplayMode == .compact  && row == 3{
                label?.alpha = alphaDisabled1
            }
            else if self.extensionContext?.widgetActiveDisplayMode == .compact  && row >= 4{
                label?.alpha = alphaDisabled2
            }
            else {
                label?.alpha = 1.0
            }
            
        }
        
        
        let textArray = [ text1,text2,text3,text4,text5,text6,text7,text8,text9,text10,
                          text11,text12,text13,text14,text15,text16,text17,text18,text19,text20,
                          text21,text22,text23,text24,text25,text26,text27,text28,text29,text30,
                          text31,text32,text33,text34,text35,text36]
        
        
        
        font = UIFont(name: "Menlo-Regular", size: fontSize)!
        
        for (i, label) in textArray.enumerated() {
            
            
            //font
            label?.font = font
            
            let row = Float(floor(Float(i) / perRow))
            
            //frame
            if var frame = label?.frame {
                frame.origin.y = CGFloat(yStart + (row * yOffset))
                label?.frame = frame
            }
            
            //alpha compact
            if self.extensionContext?.widgetActiveDisplayMode == .compact  && row == 3{
                label?.alpha = alphaDisabled1
            }
            else if self.extensionContext?.widgetActiveDisplayMode == .compact  && row >= 4{
                label?.alpha = alphaDisabled2
            }
            else {
                label?.alpha = 1.0
            }

        }
    }
    
    func setupGridText() {
        let appGroupID = "group.com.skyriser.passwordgrid"
        let group = UserDefaults(suiteName: appGroupID)
        
        
        let textArray = [ text1,text2,text3,text4,text5,text6,text7,text8,text9,text10,
                          text11,text12,text13,text14,text15,text16,text17,text18,text19,text20,
                          text21,text22,text23,text24,text25,text26,text27,text28,text29,text30,
                          text31,text32,text33,text34,text35,text36]

        let matrixArray = group?.stringArray(forKey: "matrixArray") ?? [String]()
        
        if matrixArray.count >= textArray.count {

            for (i, label) in textArray.enumerated() {


                label?.text = matrixArray[i]
                
            }
        }
    }
    
}
