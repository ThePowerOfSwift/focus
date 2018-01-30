//
//  Bag.swift
//  Focus Birmanie
//
//  Created by Georgia Leguem on 24/11/2016.
//  Copyright © 2016 appedufun. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Bag {
  
    let nc : NotificationCenter = NotificationCenter.default
    
    init(){
    addListener()
    }
    func add(nodeData: Dictionary<String,AnyObject>){
        var listElements = list()
        listElements.append(nodeData)
        pl?.bagData = listElements
        calculateCsee()
        sendNotification(notification.BAG_CHANGED.rawValue, [:])
       
        if ((pl?.CseeBag)! >= MIN_CSE_FOR_GO){
            sendNotification(notification.LOAD_SLIDE_CONSOLE.rawValue, ["slideNumber":1 as AnyObject])
            
        }else{
             sendNotification(notification.CLOSE_CONSOLE.rawValue, [:]) 
        }
    }
    func remove(id :String){
        var listElements = list()
        var count = -1
        for item in listElements{
            count += 1
            if item["id"] as! String == id{

              listElements.remove(at: count)
              pl?.bagData = listElements
              calculateCsee()
              sendNotification(notification.BAG_CHANGED.rawValue, [:])
              sendNotification(notification.CHANGE_SEQUENCE.rawValue,["numSequence":pl?.sequenceNumber as AnyObject])
            }
            
        }
    }
    func calculateCsee(){
        var valueCsee: Int = 0
        for item in list() {
           valueCsee += Parser.valueOf(variableName: "CSEE", contentBy: item) as! Int
         }
        pl?.CseeBag = valueCsee
    }
    func list()->[Dictionary<String,AnyObject>]{
        return pl!.bagData
    }
    func addListener(){
             
        nc.addObserver(self,
                       selector: #selector(repRemoveFromBag),
                       name : NSNotification.Name(rawValue: notification.REMOVE_FROM_BAG.rawValue),
                       object : nil)
    }
     @objc func repRemoveFromBag(note: NSNotification) {
        if  let  userInfo = note.userInfo as! Dictionary<String, AnyObject>?{
            let id  = userInfo["id"] as! String
            remove(id: id)
        }
    }
    deinit{
      
    }
}
