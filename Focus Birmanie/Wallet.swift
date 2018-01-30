//
//  Wallet.swift
//  Focus Birmanie
//
//  Created by Laurent Aubourg on 13/02/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit

class Wallet {
    let nc : NotificationCenter = NotificationCenter.default
    init(){
        addListener()
    }
    func earning(_ value:Float){
        let newVal = (pl?.walletValue)! + value
        pl?.walletValue = newVal
    }
    func paying(_ value:Float){
        let newVal = (pl?.walletValue)! - value
        pl?.walletValue = newVal
    }
    func addListener(){
        //  let nc : NSNotificationCenter = NSNotificationCenter.defaultCenter()
        
        nc.addObserver(self,
                       selector: #selector(repEarn),
                       name : NSNotification.Name(rawValue: notification.EARN.rawValue),
                       object : nil)
        nc.addObserver(self,
                       selector: #selector(repPaid),
                       name : NSNotification.Name(rawValue: notification.PAID.rawValue),
                       object : nil)
    }
    @objc func repEarn(note: NSNotification) {
        if  let  userInfo = note.userInfo as! Dictionary<String, AnyObject>?{
            let value  = userInfo["value"] as! Float
            earning(value)
        }
    }
    @objc func repPaid(note: NSNotification) {
        if  let  userInfo = note.userInfo as! Dictionary<String, AnyObject>?{
            let value  = userInfo["value"] as! Float
            paying(value)
        }
    }

}
