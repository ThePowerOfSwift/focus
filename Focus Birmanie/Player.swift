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

class Player {
    var _bag:Bag
    var _wallet:Wallet
     let nc : NotificationCenter = NotificationCenter.default
    init(){
        _bag = Bag()
        _wallet = Wallet()
        addListener()
       // earning(0)
    }
    func earning(_ value:Float){
        _wallet.earning(value)
    }
    func paying(_ value:Float){
        _wallet.paying(value)
    }
    func addToBag(){
      
        _bag.add(nodeData: (pl?.touchedNodeData)!)
    }
    func removeFromBag(){
        
    }
    func listBagContent()->[Dictionary<String,AnyObject>]{
      return _bag.list()
    }
    func isInBag(id:String)->Bool{
     
        for item: Dictionary<String,AnyObject> in _bag.list() {
            
       
            if (item["id"] as! String == id){
                return true
            }
        }
        return false
    }
    func listBagContentNameElements()->[String]{
        var array = [String]()
        for item: Dictionary<String,AnyObject> in _bag.list() {
          array.append(item["name"] as! String)
        }
        return array
    }
    //MARK: LISTENERS
    func removeListener(){
        nc.removeObserver(self)
    }
    func addListener(){
        
      
        nc.addObserver(self,
                       selector: #selector(repDealAndMove),
                       name : NSNotification.Name(rawValue: type_action.DEAL_AND_MOVE.rawValue),
                       object : nil)
    }
    @objc func repDealAndMove(note: NSNotification)
    {
        guard let  userInfo = note.userInfo as! Dictionary<String, AnyObject>? else{
            return
        }
        if let csee = userInfo["csee"] as! Int?{
                  pl?.CseePlayer += csee
            }
        if let money = userInfo["money"] as! Int?{
            paying(Float(money))
        }
        if let pageName = userInfo["pageName"] as! String?{
            var param:Dictionary<String,AnyObject> = [
                "pageName":pageName as AnyObject,
                
                ]
            if let numSequence = userInfo["numSequence"] as! Int?{
               param["numSequence"] = numSequence as AnyObject?
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification.CHANGE_PAGE.rawValue) , object: nil, userInfo:  param)
        }else if let numSequence = userInfo["numSequence"] as! Int?{
            let param:Dictionary<String,AnyObject> = [
                "numSequence":numSequence as AnyObject,
                                ]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification.CHANGE_SEQUENCE.rawValue) , object: nil, userInfo:  param)
        }
    }
}
