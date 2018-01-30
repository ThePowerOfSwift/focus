//
//  PlistData.swift
//  Focus Birmanie
//
//  Created by Georgia Leguem on 19/10/2016.
//  Copyright © 2016 appedufun. All rights reserved.
//

import Foundation
import CoreLocation
class PlistData{
    var plistSrc:[String:AnyObject] = [:]  //our data
    var _numSequence : Int?
    var _namePage:String = ""
    var _dynamicData:Dictionary<String, AnyObject>
    var _touchedNodeData:Dictionary<String, AnyObject>?
    var sequenceNumber:Int{
        get{

            return _dynamicData["numSequence"] as! Int
        }
        set{
            
            _numSequence = newValue
          
            _dynamicData["numSequence"] = newValue as AnyObject?

        }
    }
    var playerData:Dictionary<String, AnyObject>{
        get{
           let dynamicData = _dynamicData as Dictionary<String, AnyObject>
            return dynamicData["player"] as! Dictionary<String, AnyObject>
        }
        set{
         
            _dynamicData["player"] = newValue as AnyObject?
          
        }
    }
    var _common:Dictionary<String, AnyObject>{
        get{
            let dynamicData = _dynamicData as Dictionary<String, AnyObject>
            return dynamicData["common"] as! Dictionary<String, AnyObject>
        }
        set  {
          
            _dynamicData["common"] = newValue as Dictionary<String, AnyObject> as AnyObject
        }

    }
    var menu:Dictionary<String, AnyObject>{
        get{
            let common = _common
            return common["menu"] as! Dictionary<String, AnyObject>
        }
       
    }
    var cqc:[Dictionary<String, AnyObject>]{
        get{
            let common = _common
            return common["cqc"] as! [Dictionary<String, AnyObject>]
        }
        set{
           _common["cqc"] = newValue as AnyObject?
        }
        
    }
    
    var walletValue: Float{
        get{
             return (playerData["money"] as? Float)!
            
        }
        set{
            
            let money = (playerData["money"] as! Int)
            let diff:Int = Int(newValue) - money
            playerData["money"] = newValue as AnyObject?

            sendNotification(notification.WALLET_CHANGE.rawValue,["diff":diff as AnyObject])
        }
    }
    var bagData:[Dictionary<String, AnyObject>]{
        get{
           
            return _dynamicData["bag"] as! [Dictionary<String, AnyObject>]
        }
        set{
    
     
            _dynamicData["bag"] = newValue as AnyObject?
          
        }
    }
    var CseeBag:Int{
        get{
            
            return playerData["CSEE_bag"] as! Int
        }
        set{
            let diff:Int = newValue - (playerData["CSEE_bag"] as! Int)
            
            playerData["CSEE_bag"] = newValue as AnyObject?
           
            sendNotification(
                notification.MAJ_CSEE.rawValue,
                ["diff":diff as AnyObject]
            )
        }
    }
    var CseePlayer:Int{
        get{
            
            return playerData["CSEE_player"] as! Int
        }
        set{
            
            let diff:Int = newValue - (playerData["CSEE_player"] as! Int)

            playerData["CSEE_player"] = newValue as AnyObject?
         
            sendNotification(
                notification.MAJ_CSEE.rawValue,
                ["diff":diff as AnyObject]
            )
        }
    }
    var touchedNodeData:Dictionary<String, AnyObject>{
        get{
            return _touchedNodeData!
        }
        set{
            _touchedNodeData = newValue
            _dynamicData["touchedNodeData"] = newValue as AnyObject?
            
        }
    }
    
    var pageName:String{
        get{
            return _dynamicData["pageName"] as! String
        }
        set{
        
            _namePage = newValue
            _dynamicData["pageName"] = newValue as AnyObject?
           
        }
    }
    var history:[Dictionary<String,AnyObject>]{
        get{
            return _dynamicData["history"] as! [Dictionary<String,AnyObject>]
        }
        set{
            _dynamicData["history"] = newValue as [Dictionary<String,AnyObject>] as AnyObject?
            }
    }
    var previousPage:String{
        get{
            let indexHistory: Int
            
              indexHistory = history.count - 1
            
            if(indexHistory >= 1){
            let prev = history[indexHistory - 1]
            return prev["pageName"] as! String
            }else{
            return history[0]["pageName"] as! String
            }
        }
        
    }
    var previousSequence:Int{
        get{
            let indexHistory:Int
            
                 indexHistory = history.count - 1
           
                
                if(indexHistory >= 1){
                    let prev = history[indexHistory - 1]
                    return prev["sequenceNumber"] as! Int
                }else{
                    return history[0]["sequenceNumber"] as! Int
                }
               }
            }
    var pages: Dictionary<String, AnyObject>?
    
    var contentPage:Dictionary<String, AnyObject>{
        get{
        return  pages?[_namePage] as! Dictionary<String, AnyObject>
        }
        
    }
    init(){
      
       _dynamicData = PlistManager.sharedInstance.getValueForKey(key:"dynamicData") as! Dictionary<String, AnyObject>
         _numSequence = _dynamicData["numSequence"] as? Int
       pages =  PlistManager.sharedInstance.getValueForKey(key: "Pages") as! Dictionary<String, AnyObject>?
        }
    func saveDynamicData(key:String ,data: Dictionary<String, AnyObject>){
   
    PlistManager.sharedInstance.saveValue(value:data as AnyObject, forKey:key)
    }
    func getSequences(page : Dictionary<String, AnyObject>)->Dictionary<String, AnyObject>{
        let sequences = page["sequences"] as! Dictionary<String, AnyObject>
        guard sequences["sequence" + String(sequenceNumber) ] != nil else{
        return sequences["sequence1"] as! Dictionary<String, AnyObject>
        }
       return sequences["sequence" + String(sequenceNumber) ] as! Dictionary<String, AnyObject>
    }
    func removeElement(id:String){
        var index = -1
        var count = 0
    var elements = listElements()
        for item in elements{
            if item["id"] as! String == id{
               index = count
            break
            }
        count += 1
        }
        if(index>=0){
            elements.remove(at: index)
        }
       }
    func coordinate()->Dictionary<String, AnyObject>{
        if pages != nil {
            pl?.sequenceNumber = previousSequence
             let content = pages?[previousPage] as! Dictionary<String, AnyObject>
            
            guard let coordinates = getSequences(page: content)["coordinates"]  else{
                pl?.sequenceNumber = 1
                 return _dynamicData["coordinates"] as! Dictionary<String, AnyObject>
                }
            _dynamicData["coordinates"] = coordinates
            pl?.sequenceNumber = 1
            return coordinates as! Dictionary<String, AnyObject>
            }
        
        return [:]
    }
    func initCoordinate(_ coord:CLLocationCoordinate2D){
        let lattitude = coord.latitude as AnyObject
        let longitude = coord.longitude as AnyObject
        let coordinates = ["longitude":longitude,"lattitude":lattitude]
        _dynamicData["coordinates"] = coordinates as AnyObject
    }
    func listElements()->[Dictionary<String, AnyObject>]{
        if pages != nil {
            
            var sequence = getSequences(page : contentPage)
            let elements = sequence["elements"] as! [Dictionary<String, AnyObject>]
     
           
            return elements
        
    }
        return [[:]]
    }
    func consoleData()->[Dictionary<String, AnyObject>]{
        if pages != nil {
            
            var sequence = getSequences(page : contentPage)
            guard  let consoleData = sequence["console"] as? Dictionary<String, AnyObject>  else{
                return [[:]]
            }
            
            
            return consoleData["slides"] as! [Dictionary<String, AnyObject>]
            
        }else{
        return [[:]]
        }
    }
    func PdfData()->Dictionary<String, AnyObject>{
        pl?.sequenceNumber = previousSequence
        let content = pages?[previousPage] as! Dictionary<String, AnyObject>
        let defaultData = ["namePdf":"guide" as AnyObject,
                           "mode":"singlePage" as AnyObject,
                           "pageNumber": 0 as AnyObject
        ]
        if pages != nil {
            
            var sequence = getSequences(page : content)

            guard  let _guideData = sequence["guide"] as? Dictionary<String, AnyObject>  else{
                sendNotification(notification.CLOSE_RAW_PDF.rawValue,[:])
                return ([:])
                //  return defaultData
            }
            
            
            return _guideData
            
        }else{
              return defaultData
        }
    }
     func slidersAnimations()->[String]{
        var sequence = getSequences(page : contentPage)
        guard  let slidersData = sequence["sliders"] as? Dictionary<String, AnyObject>  else{
            return [""]
        }
        guard  let sliderAnimations = slidersData["animations"]  as? [String] else{
            return [""]
        }
        
        return sliderAnimations
    }
    func slidersData()->[[Dictionary<String, AnyObject>]]{
        if pages != nil {
            
            var sequence = getSequences(page : contentPage)
            guard  let slidersData = sequence["sliders"] as? [[Dictionary<String, AnyObject>]]  else{
                return [[[:]]]
            }
            
      /*      guard  let sliderList = slidersData["list"]  as? [[Dictionary<String, AnyObject>]] else{
                return [[[:]]]
            }*/
            
            return slidersData
            
        }else{
            return [[[:]]]
        }
    }
    func posCameraSequence()->Dictionary<String, AnyObject>{
       
        var posCam: Dictionary<String, AnyObject> = [:]
        if pages != nil {
         
            let s = getSequences(page : pages?[_namePage] as! Dictionary<String, AnyObject>)
             posCam = s["camera"] as! Dictionary<String, AnyObject>
                    }
        return posCam 

    }
    func limitSequence()->Dictionary<String, AnyObject>{
        if pages != nil {
            let sequence = getSequences(page : pages?[_namePage] as! Dictionary<String, AnyObject>)
            return sequence["limit"] as! Dictionary<String, AnyObject>
            
        }
        return [:]
    }
    func window(windowName:String)->Dictionary<String, AnyObject>{
        
         if let windows = PlistManager.sharedInstance.getValueForKey(key: "window") {
            let window = windows[windowName] as! Dictionary<String, AnyObject>
        return window
        }
       return [:] 
    }
   
}
