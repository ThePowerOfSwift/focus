//
//  SceneManager.swift
//  Focus Birmanie
//
//  Created by Laurent Aubourg on 29/11/2016.
//  Copyright © 2016 appedufun. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
class item_system{}
class SceneManager{
   let _nc : NotificationCenter = NotificationCenter.default
weak   var _scene:SKScene?
    
   let _navigation:Navigation
    var _cameraManager : CameraManager?
  //  var _sequenceNode:Sequence
   weak  var leftNode:SKNode?{
        get{
            return _scene?.childNode(withName: "leftNode")
        }
       }
   weak var topNode:SKNode?{
        get{
            return _scene?.childNode(withName: "topNode")
        }
    }

    weak var rightNode:SKNode?{
        get{
            return _scene?.childNode(withName: "rightNode")
        }
    }

    weak var bottomNode:SKNode?{
        get{
            return _scene?.childNode(withName: "bottomNode")
        }
    }

    var entityManager: EntityManager!
   
   var navigation:Navigation?{
        get{
            return _navigation
        }
    }
    var cameraPosition:CGPoint{
        return _cameraManager!.cameraPosition
    }
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
            return _navigation.previousPage
        }
       
    }
    var previousSequence:Int{
        get{
            return _navigation.previousSequence
        }
        
    }
    var sequenceNumber:Int{
        get{
            return _navigation.sequenceNumber
        }
        set{
            _navigation.sequenceNumber = newValue
        }
    }
    var posCameraSequence:Dictionary<String, AnyObject>{
        get{
            return pl!.posCameraSequence()
        }
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
    // MARK: CONSTRUCTOR 
    
    init(scene p_scene:SKScene ,p_sequenceNumber:Int = 1){
        _scene = p_scene
        // creation de l'entityManger

        entityManager = EntityManager(scene: (_scene)!)
 
        let maCamera = _scene?.childNode(withName: "laCamera") as! SKCameraNode
        //creation de l'objet de navigation en lui fournissant
   
   
        _navigation = Navigation()!
      //  _navigation.pageName =  p_pageName
        _navigation.sequenceNumber = p_sequenceNumber
        
        //récupération de la position de la caméra dans le fichier plist et création du cameraManager
        let posCam = pl?.posCameraSequence()
  
        _cameraManager = CameraManager(camera: maCamera,   p_position:CGPoint(x:posCam?["x"]! as! Int,y:posCam?["y"]! as! Int))
        _scene?.camera = maCamera

         addListener()
       
      
    }
 //MARK: DEINIT
    deinit {
      
        removeListener()
       _cameraManager?.deallocate()
       _cameraManager = nil
        entityManager.dealloc()
        entityManager = nil
        var seqNode:Sequence? =  self.getNodeSequence(sequenceNumber)
        seqNode?.deallocate()
        seqNode = nil
        
    
    }
    
//MARK: CAMERA
    
    func cameraSetUp(){
       
        let point = CGPoint(x:posCameraSequence["x"]! as! Int,y:posCameraSequence["y"]! as! Int)
        _cameraManager?.positionCamera(position: point)
        initPosCamera = point
       // cameraManager.scaleCamera(to: 1, duration: 0.5)
    }
    func changePositionCamera(p_point:CGPoint){
        _cameraManager?.positionCamera(position: p_point)
    }
    func cameraContainNode(node p_node:String)->Bool{
        if p_node == "L"{
            return _cameraManager!.containNode(node: leftNode!)
        }else if p_node == "R"{
            return _cameraManager!.containNode(node: rightNode!)
        }else if p_node == "T"{
            return _cameraManager!.containNode(node: topNode!)
        }else {
            return _cameraManager!.containNode(node: bottomNode!)
        }
    }
    func moveCamera(to p_to:CGPoint,duration p_duration:TimeInterval){
        _cameraManager?.moveCamera(to: p_to, duration: p_duration)
    }
    func scaleCamera(from p_from:CGFloat=1 ,to p_to:CGFloat,duration p_duration:TimeInterval,completion:Bool = false){
        _cameraManager?.scaleCamera(from:p_from,to: p_to, duration: p_duration,completion:completion)
        
    }
//MARK: PAGES
        func initLimit(){
       // let limits = limitSequence
        let  posLeft = limitSequence["left"] as! Dictionary<String,Int>
       
        let  posTop = limitSequence["top"] as! Dictionary<String,Int>
        let  posRight = limitSequence["right"] as! Dictionary<String,Int>
        let  posBottom = limitSequence["bottom"] as! Dictionary<String,Int>
            leftNode?.isHidden = ((rightNode?.isHidden = ((topNode?.isHidden = ((bottomNode?.isHidden = true) != nil)) != nil)) != nil)
        leftNode?.position = CGPoint(x:posLeft["x"]!,y:posLeft["y"]!)
        topNode?.position = CGPoint(x:posTop["x"]!,y:posTop["y"]!)
        rightNode?.position = CGPoint(x:posRight["x"]!,y:posRight["y"]!)
        bottomNode?.position = CGPoint(x:posBottom["x"]!,y:posBottom["y"]!)
            
        
    }
//MARK: SEQUENCES
    func changeSequence(_ num_seq:Int) {
        
        sendNotification(
            notification.SCALE_CAMERA.rawValue,
            ["ratio":1 as AnyObject,"duration":0.5 as AnyObject]
        )
        
        sequenceNumber = num_seq
        
        // réinitiialisation du zoom de la sequence précédente
        if pageName != pages_name.BAG.rawValue{
            let nodeSeq = getNodeSequence(previousSequence)
            let _unscale = SKAction.scale(to: 1,duration: 0.1)
            nodeSeq.run(_unscale)
        }
    
        // création des entités de la séquence
       let elements = listElements
       for elem in elements{
        entityManager.createEntitieByName(p_name: elem["entitie"] as! String, p_param: elem)
        }
        // positionnement de la caméra
        cameraSetUp()
        
        // positionnement des Nodes de limite de la sequence
        initLimit()
        
     //   sendNotification(notification.LOAD_CONSOLE_DATA.rawValue,[:] )
        sendNotification(notification.OPEN_CONSOLE.rawValue, [:])
       }
    
    func getNodeSequence(_ num_seq:Int)->Sequence{
      
        guard let nodeSeq = _scene?.childNode(withName: "sequence\(num_seq)") as? Sequence else {
            return Sequence()
        }
        return nodeSeq
    }
    
//MARK: LISTENERS
    func removeListener(){
        _nc.removeObserver(self)
    }
    func addChild ( node:SKSpriteNode){
        _scene?.addChild(node)
    }
    func addListener(){
       
        
        _nc.addObserver(self,
                       selector: #selector(repChangeSequence),
                       name : NSNotification.Name(rawValue: notification.CHANGE_SEQUENCE.rawValue),
                       object : nil)
        _nc.addObserver(self,
                       selector: #selector(repRemoveEntity(notification:)),
                       name : NSNotification.Name(rawValue: notification.REMOVE_ENTITY.rawValue),
                       object : nil)
        _nc.addObserver(self,
                       selector: #selector(repChangePage),
                       name : NSNotification.Name(rawValue: notification.CHANGE_PAGE.rawValue),
                       object : nil)
      
        
        
    }
       @objc func repRemoveEntity(notification:NSNotification){
        guard (notification.userInfo as! Dictionary<String, AnyObject>?) != nil else{
            return
        }
    /*    guard let entity = userInfo["entity"] as? GKEntity else {
            return
        }
       pl.removeElement(Fremoveid: entity.idElem)
       
       entityManager.remove(entity: entity)*/
    }
    func cleanScene(){
        
    }
    @objc func repChangeSequence(notification:NSNotification)
    {
        entityManager.removeAllEntities()
        
       
        WAIT_SWIPE = false
     
           if  let  userInfo = notification.userInfo as! Dictionary<String, AnyObject>?{
         
            var s:Sequence? =  self.getNodeSequence(sequenceNumber)
            if (userInfo["numSequence"] as! Int != sequenceNumber){
            s?.deallocate()
            s = nil
            }
            let seqNumber:Int = Int(userInfo["numSequence"]! as! NSNumber)
         
            if self.pageName != self._scene?.name {
           
                WAIT = true
         
           }else {
                WAIT = false
          
                guard let seqNode = self.getNodeSequence(seqNumber) as? Sequence else{
                    
                
                    return
                }
                
                changeSequence(seqNumber )
                seqNode.start() 
                return
            }
          
            }
        
    }
    func removeChild(node:SKNode){
        for c in node.children{
            
            if(c.children.count < 1){
                c.removeAllChildren()
                c.removeAllActions()
                c.removeFromParent()
            }else{
                removeChild(node: c)
            }
        }
        
        
        
        
        
        
        
    }
    @objc func repChangePage(notif:NSNotification)
    {
       
      //  removeChild(node: _scene )
      /*  for c in _scene.children{
            c.removeAllActions()
            c.removeFromParent()
        }*/
       
       removeListener()
        if  let  userInfo = notif.userInfo as! Dictionary<String, AnyObject>?{
            
             let seqNumber:Int? = userInfo["numSequence"] as? NSNumber as! Int?
             let pageName = userInfo["pageName"] as! String
         
            if(pageName == pages_name.PREVIOUS_PAGE.rawValue){
                    self.pageName = previousPage
                    self.sequenceNumber = previousSequence
                }else{
                    self.pageName = pageName
                    if seqNumber != nil{
                        self.sequenceNumber = seqNumber!
               
                    }
            }
         
          
            if( self.pageName == pages_name.ACCUEIL.rawValue ){
               removeListener()
               
               _scene?.view?.presentScene(Accueil.fromFile(), transition: LONG_OPEN_DOOR_VERTICAL)
                return
            }else if( self.pageName == pages_name.AEROPORT.rawValue){
               removeListener()
                _scene?.view?.presentScene(Aeroport.fromFile(), transition: LONG_CROSS_FADE)
               return
            }else if( self.pageName == pages_name.BAG.rawValue){
                removeListener()
                sequenceNumber = 1
                _scene?.view?.presentScene(BagScene.fromFile(), transition: LONG_CROSS_FADE)
               return
            }else if( self.pageName == pages_name.GUESTHOUSE.rawValue){
               // removeListener()
                _scene?.view?.presentScene(GuestHouse.fromFile(), transition: LONG_CROSS_FADE)
               return
            }else if( self.pageName == pages_name.RANGOON.rawValue){
                // removeListener()
                _scene?.view?.presentScene(Rangoon.fromFile(), transition: LONG_CROSS_FADE)
                return
            }else if( self.pageName == pages_name.MON_ET_KAREN.rawValue){
                // removeListener()
                _scene?.view?.presentScene(MonEtKaren.fromFile(), transition: LONG_CROSS_FADE)
                return
            }else if( self.pageName == pages_name.SHAN_ET_LOIKAN.rawValue){
                // removeListener()
                _scene?.view?.presentScene(ShanEtLoikaw.fromFile(), transition: LONG_CROSS_FADE)
              return
            }else if( self.pageName == pages_name.LE_NORD.rawValue){
                // removeListener()
                _scene?.view?.presentScene(LeNord.fromFile(), transition: LONG_CROSS_FADE)
              return
            }else if( self.pageName == pages_name.ARAKAN.rawValue){
                // removeListener()
                _scene?.view?.presentScene(Arakan.fromFile(), transition: LONG_CROSS_FADE)
              return
            }else if( self.pageName == pages_name.MANDALAY.rawValue){
                // removeListener()
                _scene?.view?.presentScene(Mandalay.fromFile(), transition: LONG_CROSS_FADE)
               return
            }else if( self.pageName == pages_name.BAGAN.rawValue){
                // removeListener()
                _scene?.view?.presentScene(Bagan.fromFile(), transition: LONG_CROSS_FADE)
              return
            }else if( self.pageName == pages_name.TEA_HOUSE.rawValue){
           removeListener()
            _scene?.view?.presentScene(TeaHouse.fromFile(), transition: LONG_CROSS_FADE)
                return
            }else if( self.pageName == pages_name.MAP.rawValue){
                // removeListener()
                sequenceNumber = 1
                _scene?.view?.presentScene(MapScene.fromFile(), transition: LONG_CROSS_FADE)
               return
            }else if( self.pageName == pages_name.PDF_SCENE.rawValue){
                // removeListener()
                sequenceNumber = 1
                let pdfScene = PDFScene.fromFile()
                pdfScene.pdfParam = userInfo
                _scene?.view?.presentScene(pdfScene, transition: LONG_CROSS_FADE)
                
                return
            }else if( self.pageName == pages_name.CQC.rawValue){
                // removeListener()
                sequenceNumber = 1
                _scene?.view?.presentScene(CqcScene.fromFile(param:notif.userInfo as! Dictionary<String, AnyObject>), transition: LONG_CROSS_FADE)
                return
            }
           // addListener()
        
        }
        
    }
    

 

}
