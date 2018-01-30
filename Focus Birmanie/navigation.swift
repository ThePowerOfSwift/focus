//
//  navigation.swift
//  Focus Birmanie
//
//  Created by laurent Aubourg on 04/11/2016.
//  Copyright © 2016 appedufun. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Navigation{
    
    
    var history:[Dictionary<String, AnyObject>] = [[:]]
    var indexHistory : Int = 0
  //  var _pageName=""
    var _numSequence = 1
    
    var isConnect: Bool = false
    let nc : NotificationCenter = NotificationCenter.default
    
    
    let scaleOut:SKAction?
    let scaleIn:SKAction?
    let scale:SKAction?
    let sequenceScale:SKAction?
   
    var appState = state(rawValue: state.IN_PAGE.rawValue)
    var pageName: String{
        get{
        return (pl?.pageName)!
        }
        
    set{
    
        pl?.pageName = newValue
        }
    }
    var previousPage:String{
        get{
            return pl!.previousPage
        }
        
    }
    var previousSequence:Int{
        get{
            return pl!.previousSequence
        }
      
    }
    var sequenceNumber:Int{
        get{
            return pl!.sequenceNumber
        }
        set{
           
            _numSequence = newValue
            pl?.sequenceNumber = newValue
            updateHistory()
           
        }
    }
    var bagIsEmpty:Bool = true
//MARK: METHOD
    init?(){
        
        scaleOut = SKAction.scale(to: 0.9, duration: 0.5)
        scaleIn = SKAction.scale(to: 1.9, duration: 0.2)
        scale = SKAction.scale(to: 1, duration: 0.1)
        sequenceScale = SKAction.sequence([scaleOut!,
                                           scaleIn!,
                                           scale!]);
        //startReachabilityNotifier()
        addListener()
        }

    func purgeHistory(){
        history = (pl?.history)!
        indexHistory = history.count - 1
        let nbItem = indexHistory - 5
        
        if(nbItem > 0){
         for i in 0 ... nbItem {
                pl?.history.remove(at: i)
                }
        }
       
    }
    func updateHistory(){
        purgeHistory()
        if (pageName != pages_name.BAG.rawValue && pageName != pages_name.TEA_HOUSE.rawValue && pageName != pages_name.MAP.rawValue && pageName != pages_name.PDF_SCENE.rawValue
            && pageName != pages_name.CQC.rawValue){
        history = (pl?.history)!
        indexHistory = history.count - 1
        
        var last = ["pageName":pageName as AnyObject, "sequenceNumber":_numSequence as AnyObject] as [String : AnyObject]
        
        if ( indexHistory > 0){
            last = history[indexHistory - 1]
        }
        let lastPageName = last["pageName"] as! String
        let lastSequenceNumber = last["sequenceNumber"] as! Int
      
        if ((lastPageName != pageName) ) {
           writeHistory()
        }else if (lastSequenceNumber != _numSequence){
           writeHistory()
       
        }else if(indexHistory == 0){
            writeHistory()
             }
        }
    }
    func writeHistory(){
        history[indexHistory]["sequenceNumber"] = _numSequence as AnyObject
        history[indexHistory]["pageName"] = pageName as AnyObject
        
        history.append( [:])
        pl?.history = history
    }
    var listElements:[Dictionary<String, AnyObject>]{
        get{
            return pl!.listElements()
        }
    }
    var limitSequence:Dictionary<String, AnyObject>{
        get{
        return pl!.limitSequence()
        }
    }
    func startReachabilityNotifier(){
        do{
          //  try reachability.startNotifier()
        }catch{
            
        }
   
    }

      //MARK: LISTENERS
    func addListener(){
       
       
      /*  nc.addObserver(self,
                       selector: #selector(self.reachabilityChanged),
                       name: ReachabilityChangedNotification,
                       object: reachability)*/
        nc.addObserver(self,
                       selector: #selector(repMajCsee),
                       name : NSNotification.Name(rawValue: notification.MAJ_CSEE.rawValue),
                       object : nil)
        nc.addObserver(self,
                       selector: #selector(repBagIsEmpty),
                       name: NSNotification.Name(rawValue: notification.BAG_IS_EMPTY.rawValue),
                       object: nil)
        nc.addObserver(self,
                       selector: #selector(repAddToBag),
                       name: NSNotification.Name(rawValue: notification.ADD_TO_BAG.rawValue),
                       object: nil)
        nc.addObserver(self,
                       selector: #selector(self.changeState),
                       name: NSNotification.Name(rawValue: notification.CHANGE_STATE.rawValue),
                       object: nil
        )
       
    }
    @objc func repBagIsEmpty(notification:NSNotification){
      //  btnBag?.alpha = 0
    }
    @objc func repAddToBag(notification:NSNotification){
      //  btnBag?.alpha = 1
        
    }
    @objc func changeState(notification:NSNotification){
        if  let  userInfo = notification.userInfo as! Dictionary<String, AnyObject>?{
            appState = userInfo["state"] as! state?
        }
    }
    @objc func repMajCsee(){
     //   if(bonus_lab != nil){
      //  bonus_lab?.text = "CSEE :\((pl?.CseeBag)! + (pl?.CseePlayer)!)"
        
      
     //   }
    }
    @objc func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                isConnect = true
            } else {
                isConnect = true
            }
        } else {
            isConnect = false
        }
    }
    deinit{
           }

}
