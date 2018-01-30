//
//  GameScene.swift
//  Focus Birmanie
//
//  Created by Laurent Aubourg on 26/09/2016.
//  Copyright © 2016 appedufun. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScenes:SKScene, SKPhysicsContactDelegate {
    
   
   // var nc : NotificationCenter? = NotificationCenter.default
    var lastUpdateTimeInterval: TimeInterval = 0
    var gameOver:Bool? = false
    var entityManager: EntityManager!
    var sceneManager:SceneManager?
    var param:Dictionary<String, AnyObject>? = nil
    var pageName: String{
        get{
            return (pl?.pageName)!
        }
        
        set{
           
            pl?.pageName = newValue
        }
    }
    var pinchGesture: UIPinchGestureRecognizer? = UIPinchGestureRecognizer()
    var tapGesture:UITapGestureRecognizer? = UITapGestureRecognizer()
    var swipeUp:UISwipeGestureRecognizer? = UISwipeGestureRecognizer()
    var swipeDown:UISwipeGestureRecognizer? = UISwipeGestureRecognizer()
    var swipeRight:UISwipeGestureRecognizer? = UISwipeGestureRecognizer()
    var swipeLeft:UISwipeGestureRecognizer? = UISwipeGestureRecognizer()
    var nodesWithGesture:Array<SKSpriteNode>? = []

//MARK: *** DID_MOVE ***
    override func didMove(to view: SKView) {
      
        nodesWithGesture = []
        
       WAIT = false
       WAIT_SWIPE = false
        for item in children {
            if(item.isKind(of: Touchable.self)){
                nodesWithGesture?.append(item as! SKSpriteNode)
                makeGestureArray(node: item as! Touchable)
            }
        }

        sceneManager = SceneManager(scene: self, p_sequenceNumber: (pl?.sequenceNumber)!)
        for item in (camera?.children)! {
            if(item.isKind(of: Touchable.self)){
                nodesWithGesture?.append(item as! SKSpriteNode)
                makeGestureArray(node: item as! Touchable)
            }
        }
       entityManager = sceneManager?.entityManager
       sendNotification(notification.CHANGE_SEQUENCE.rawValue,["numSequence":pl?.sequenceNumber as AnyObject])
        addListener()
        addGesture()
        if (pages_name.ACCUEIL.rawValue == scene?.name){
         
      
            if ((pl?.CseeBag)! >= MIN_CSE_FOR_GO){
                sendNotification(notification.LOAD_SLIDE_CONSOLE.rawValue, ["slideNumber":1 as AnyObject])
                
                
            }
        }
        }
  
//MARK: *** DEALLOCATE METHODS***
    
    func deallocate(){
        print("\(name) --- GameScene --- deallocate ---")
        entityManager.dealloc()
        entityManager = nil
        sceneManager = nil
        pinchGesture = nil
        tapGesture = nil
        swipeUp = nil
        swipeDown = nil
        swipeLeft = nil
        swipeRight = nil
        nodesWithGesture = nil
        gameOver = nil
        removeChild()
        removeFromParent()
      
        
    }
    func removeChild(){
        for c in children{
            c.removeAllChildren()
            c.removeAllActions()
            
            c.removeFromParent()
        }
    }
    func addGesture(){
        
        pinchGesture?.addTarget(self, action: #selector(GameScenes.didSceneViewPinch(_:)))
        view?.addGestureRecognizer(pinchGesture!)
        view?.addGestureRecognizer(tapGesture!)
        tapGesture?.addTarget(self, action:#selector(GameScenes.didSceneViewTap(_:)))
        swipeDown?.direction = UISwipeGestureRecognizerDirection.down
        swipeDown?.addTarget(self, action: #selector(GameScenes.didSceneViewSwipe(_:)))
        view?.addGestureRecognizer(swipeDown!)
        swipeUp?.direction = UISwipeGestureRecognizerDirection.up
        swipeUp?.addTarget(self, action: #selector(GameScenes.didSceneViewSwipe(_:)))
        view?.addGestureRecognizer(swipeUp!)
        swipeLeft?.direction = UISwipeGestureRecognizerDirection.left
        swipeLeft?.addTarget(self, action: #selector(GameScenes.didSceneViewSwipe(_:)))
        view?.addGestureRecognizer(swipeLeft!)
        swipeRight?.direction = UISwipeGestureRecognizerDirection.right
        swipeRight?.addTarget(self, action: #selector(GameScenes.didSceneViewSwipe(_:)))
        view?.addGestureRecognizer(swipeRight!)
            }
    func makeGestureArray(node:Touchable){
        let c = node.children
        if c.count > 0{
        for item in c {
            if(item.isKind(of: Touchable.self)){
                nodesWithGesture?.append(item as! SKSpriteNode)
              makeGestureArray(node: item as! Touchable)
             }
            }
        }
    }
    
    
    override func willMove(from view: SKView){
        
       
      //  previousScene = self
     self.deallocate()
     removeAllActions()
     removeAllChildren()
  //   removeFromParent()
     print ("willMove")
    }
    func closeAllWindow(){
    
        for item in entityManager.entities!{
            if let consoleComponent = item.component(ofType: ConsoleComponent.self){
              consoleComponent.close()
                }
            }
            }
    func appIsInScaleMode()->Bool{
        if(SCALE_MODE){
            let  anim = SKAction.scaleX(by: 0.8, y: 0.8, duration: TimeInterval(0.5))
            camera?.run(anim)
            return true
        }
        if(UNSCALE_MODE && (self.scene?.camera?.xScale)! < CGFloat(1)){
            let  anim = SKAction.scaleX(by: 1.2, y: 1.2, duration: TimeInterval(0.5))
            camera?.run(anim)
            return true
        }
 return false
    }
    //MARK: TOUCH
    func is_touchable( node : SKNode)->Bool{
         if(node.isKind(of: Touchable.self)){
            return true
        }
        return false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        self.view?.isMultipleTouchEnabled = true;
    closeAllWindow()
        for t in touches{
            print(t)}
        guard let touch = touches.first else {
            debugPrint("Ops, no touch found...")
            return
        }
       
        let positionInScene = touch.location(in: self)
        var touchedNode:SKNode? = self.atPoint(positionInScene)
        if  ( touchedNode?.parent == nil){
            return
        }else{

        // ignorer les zones de texte
            if (touchedNode?.parent?.isKind(of: SKMultilineLabel.self))!{
                let n = touchedNode?.parent?.parent
            touchedNode? = n!
            }else   if (touchedNode?.isKind(of: SKLabelNode.self))!{
                let n = touchedNode?.parent
            touchedNode = n!
        }
        
            if (touchedNode?.name == nil){
                touchedNode?.name = "noName"
        }
            if(is_touchable(node: touchedNode!)){
                touchedNode?.touchesBegan(touches, with: event)
            
        }else if(appIsInScaleMode()){
            return
        }
            if((touchedNode?.user_data["entity"]) != nil ){
         
                let entity = touchedNode?.user_data["entity"] as! GKEntity
                let param = ["touchedNode": touchedNode,"step": "begin" as  AnyObject ] as [String : Any]
                entity.component(ofType: TouchableSpriteComponent.self)?.callFunction(param: param as Dictionary<String, AnyObject>)
            
            }else if ((touchedNode?.name?.contains("sequence")))!{
          //  closeAllWindow()
           sendNotification(notification.CLOSE_CONSOLE.rawValue, [:])
           
        }
        
        }
    }
    
 //MARK: Move
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if WAIT_SWIPE == true {
            return
        }
        
        let touch = touches.first
        var posY = Int((sceneManager?.cameraPosition.y)!)
        var posX = Int((sceneManager?.cameraPosition.x)!)
        let location = touch?.location(in: self)
        let previousLocation = touch?.previousLocation(in: self)
        let deltaX = (location?.x)! - (previousLocation?.x)!
        let duration: CGFloat = 0.1
       // let deltaY = (location?.y)! - (previousLocation?.y)!
        if (deltaX > 0){
          
          posX -= 300
        
        }else{
          
          posX += 300
        }
      
 
        if (!(sceneManager?.cameraContainNode(node:"L"))! &&
            !(sceneManager?.cameraContainNode(node:"R"))!
            ){
            let posCam = sceneManager?.cameraPosition
            let point = CGPoint(x:(posCam?.x)!-deltaX,y:(posCam?.y)!)
          //  sceneManager?.changePositionCamera(p_point: point)
            sceneManager?.moveCamera(to: CGPoint(x: CGFloat(posX),y: CGFloat(posY)), duration: TimeInterval(duration))
        }
        if (!(sceneManager?.cameraContainNode(node:"B"))! &&
            !(sceneManager?.cameraContainNode(node:"T"))!
            ){
            let posCam = sceneManager?.cameraPosition
          //  let point = CGPoint(x:(posCam?.x)!,y:(posCam?.y)!-deltaY)
            let point = CGPoint(x:(posCam?.x)!,y:(posCam?.y)!)
            sceneManager?.changePositionCamera(p_point: point)
        }
    }
    //MARK: LISTENER
    func addListener(){
        

    }
    //MARK: Gestures
   
    
    @objc func didSceneViewTap(_ sender:UITapGestureRecognizer) {
        guard (((nodesWithGesture?.count)! > 0) ) else{
            return
        }
        if sender.state == .ended {
            
            let touchPoint = sender.location(in: sender.view)
            let touchLocation = convertPoint(fromView: touchPoint)
            for  dic in nodesWithGesture! {
               
                let testNode = dic as! Touchable
                
                if( isPointInNode(point: touchLocation, node: testNode)){
                    
                    testNode.tapHandler(sender)
                    return
                }
            }
        }
        

    }
    @objc func didSceneViewSwipe(_ sender:UISwipeGestureRecognizer) {
            
        if sender.direction == UISwipeGestureRecognizerDirection.down{
         sendNotification(notification.CLOSE_CONSOLE.rawValue, [:])
        }else if sender.direction == UISwipeGestureRecognizerDirection.up{
          sendNotification(notification.OPEN_CONSOLE.rawValue, [:])
        }
            let touchPoint = sender.location(in: sender.view)
            let touchLocation = convertPoint(fromView: touchPoint)
            for  dic in nodesWithGesture! {
                
                let testNode = dic as! Touchable
                
                if( isPointInNode(point: touchLocation, node: testNode)){
                   
                    testNode.swipeHandler(sender)
               
            }
        }

    }
   
    @objc func didSceneViewPinch(_ sender:UIPinchGestureRecognizer) {
        guard (((nodesWithGesture?.count)! > 0) ) else{
            return
        }
        
        
        if sender.state == .began {
            
            let touchPoint = sender.location(in: sender.view)
            let touchLocation = convertPoint(fromView: touchPoint)
            for  dic in nodesWithGesture! {
            
               let testNode = dic as! Touchable
              
                if( isPointInNode(point: touchLocation, node: testNode)){
                    
                    testNode.pinch(sender.scale)
                    }
                }
            }

    }
    func isPointInNode(point: CGPoint, node: SKNode) -> Bool {
        // Get all nodes intersecting <point>
     
       let listNodes = self.nodes(at: point)
           
        
        // Return true on first one that matches <node>
        for n in listNodes {
            if n == node {
                return true
            }
            
        }
        
        // If here, <point> not inside <node> so return false
        return false
    }
    // MARK: Update
    override func update(_ currentTime: TimeInterval) {
   
    if(WAIT != true){
    
    var posY = Int((sceneManager?.cameraPosition.y)!)
    var posX = Int((sceneManager?.cameraPosition.x)!)

    if (sceneManager?.cameraContainNode(node:"L"))!{
    posX += 50
    sceneManager?.moveCamera(to: CGPoint(x: CGFloat(posX),y: CGFloat(posY)), duration: 0.55)
    
    }else if (sceneManager?.cameraContainNode(node:"R"))!{
    posX -= 50
    sceneManager?.moveCamera(to: CGPoint(x: CGFloat(posX),y: CGFloat(posY)), duration: 0.55)
    
    }else if (sceneManager?.cameraContainNode(node:"T"))!{
   
    
    posY -= 10
    sceneManager?.moveCamera(to: CGPoint(x: CGFloat(posX),y: CGFloat(posY)), duration: 0.1)
    }else if (sceneManager?.cameraContainNode(node:"B"))!{
    posY += 10
    sceneManager?.moveCamera(to: CGPoint(x: CGFloat(posX),y: CGFloat(posY)), duration: 0.1)
    }
    }else{
        //   print ("update Wait is true ")
        }
    
    }
 
}
