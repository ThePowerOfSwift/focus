//
//  ConsoleCamera.swift
//  Focus Birmanie
//
//  Created by Laurent Aubourg on 28/02/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class ConsoleCamera: SKSpriteNode {
   weak var _nc : NotificationCenter? = NotificationCenter.default
       var slideOffset : Dictionary<String,Dictionary<String,Any>> = [
        "none" : ["size": CGSize(width: 0, height: 0),
                  "marge" : CGPoint(x:10,y:80)],
        "mini" : ["size": CGSize(width: 900, height: 100),
                  "marge" : CGPoint(x:10,y:20)],
        "main" : ["size": CGSize(width: 900, height: 200
            ),
                  "marge" : CGPoint(x:10,y:10)],
        "middle" : ["size": CGSize(width: 900, height: 350),
                    "marge" : CGPoint(x:10,y:20)],
        "full" : ["size": CGSize(width: 900, height: 750),
                  "marge" : CGPoint(x:10,y:80)],
        "guide_main" : ["size": CGSize(width: 900, height: 150),
                  "marge" : CGPoint(x:10,y:20)],
        "guide_middle" : ["size": CGSize(width: 900, height: 450),
                    "marge" : CGPoint(x:10,y:20)],
        "guide_full" : ["size": CGSize(width: 900, height: 750),
                  "marge" : CGPoint(x:10,y:80)],
        "pop_up_mini" : ["size": CGSize(width: 900, height: 100),
                  "marge" : CGPoint(x:10,y:80)],
        "pop_up_main" : ["size": CGSize(width: 900, height: 150),
                  "marge" : CGPoint(x:-100,y:290)],
        "pop_up_middle" : ["size": CGSize(width: 900, height: 350),
                    "marge" : CGPoint(x:-100,y:125)]
        ]
    private var _slideLock = false
    var slideLock :Bool{
        get{
            return _slideLock
        }
        set{
         _slideLock = newValue
            if(slideLock){
          
            }
        }
    }
    var offsetValue : String {
        get{
        guard let offset: String = _param?["offset"] as? String  else{
        
            return "none"
        }
            

            texture = SKTexture(imageNamed: "\(offset).png")
            size = (slideOffset[offset]?["size"] as! CGSize)
        return offset
        }
        set{
          _param?["offset"] = newValue as AnyObject
        
        }
    }
    var animation : String {
        get{
        guard let animation: String = _param?["animation"] as? String  else{
            return consoleAnimations.DOWN_TO_UP.rawValue
        }
        return animation
        }
        set{
          _param?["animation"] = newValue as AnyObject
        }
    }
    var autoStart : Bool {
        get{
        guard let auto: Bool = _param?["autostart"] as? Bool  else{
            return false
        }
        return auto
        }
        set{
           _param?["autostart"] = newValue as AnyObject
        }
    }
    var consoleEntityManager : EntityManager?
    
    var slideNumber = 0
    var is_open = false
    var arraySlideNode:[[SKSpriteNode]] = [[]]
    var arraySlideConsole:[Dictionary<String,AnyObject>]?
    var posConsole = CGPoint(x:0,y:-450)
    var sizeConsole = CGSize(width:1024,height:0)
    var colorConsole = SKColor.white
    var _param : Dictionary<String, AnyObject>?
    
    init(node:SKNode) {
        
         soundManager.stopBackgroundMusic()
        
        
        super.init(texture: nil, color: colorConsole, size: sizeConsole)
       
        name = "consoleNode"
        
       
        
    }
  
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        zPosition = 10
        
     
    }
    //MARK: Les animations
    func moveDownToUp(p_duration:TimeInterval){
        let  moveAction = SKAction.move(to:posConsole, duration: p_duration)
        moveAction.timingMode = .easeIn
        run(moveAction){
     
            if self.is_open == false{
                self.removeChild(node:self)
            }
        }
    }
    func moveUpToDown(p_duration:TimeInterval){
        let  moveAction = SKAction.move(to:posConsole, duration: p_duration)
        moveAction.timingMode = .easeIn
        run(moveAction){
      
            if self.is_open == false{
                self.removeChild(node:self)
                
            }
        }
    }

    //MARK: METHODS
    func loadConsoleData(){
       // consoleEntityManager?.dealloc()
        initConsoleEntityManager()
    
        initArraySlideNode()
       
       setHidenPosition()

        position = posConsole
       // is_open = false
        if(!slideLock){
            slideNumber = 0
        }
        
       
          }
    func initArraySlideNode(){
        
        if ( arraySlideConsole != nil && (arraySlideConsole?.count)! > 0){
            
            arraySlideNode.removeAll()
            var arrayElem:[SKSpriteNode?] = []
            if (slideNumber < (arraySlideConsole?.count)! ) {
            let tmp = arraySlideConsole?[slideNumber]
            _param = template.build(param: tmp!)
            }
            var  elements: [Dictionary<String, AnyObject>]?
            guard  ((_param?["elements"]  as? [Dictionary<String, AnyObject>]) != nil) else{
             
                return
            }
            elements = _param?["elements"]  as? [Dictionary<String,AnyObject>]
            for elem in elements! {
                var node:SKSpriteNode
                node =  (consoleEntityManager?.createEntitieByName(p_name:  elem["entitie"] as! String, p_param: elem ))!
                arrayElem.append(node)
                
            }
            arraySlideNode.append(arrayElem as! [SKSpriteNode])
            
            
        }
    }
    func setOpenPosition(){
        let s = (slideOffset[offsetValue]?["size"] as! CGSize)
        let height = s.height
        let marge = (slideOffset[offsetValue]?["marge"] as! CGPoint)
        posConsole.y = -((scene?.size.height)!/2)
        posConsole.y += (height * 0.5) + marge.y
    }
    func setHidenPosition(){
        size = (slideOffset[offsetValue]?["size"] as! CGSize)
        let height = size.height
        //  let marge = slideOffset[offsetValue]?["marge"] as! CGPoint
        posConsole.y = -((scene?.size.height)!/2)
        posConsole.y -= ((height * 0.5) )
        
    }
    func initConsoleEntityManager(){
        if(scene == nil){
            return
        }
        arraySlideConsole = pl?.consoleData()
        consoleEntityManager = EntityManager(scene: scene!)
        consoleEntityManager?.modeConsole = true;
        consoleEntityManager?.console = self
        
    }

    func removeChild(node:SKNode?){
        for c in (node?.children)!{
            if ( c.children.count<1){
                c.removeAllActions()
                c.removeFromParent()
                
            }else{
                removeChild(node:c)
              
            }
        }
        if node != self{
        node?.removeFromParent()
        node?.removeAllActions()
        }
    }
    func addNodeElem(){
        
        for e in arraySlideNode[0]{
            if e.parent == nil{
                
              
                addChild(e)
            }
            
        }
    }

    //MARK LISTENER
    func addListener(){
       _nc?.addObserver(self,
                        selector: #selector(repLoadConsoleData),
                        name : NSNotification.Name(rawValue: notification.LOAD_CONSOLE_DATA.rawValue),
                        object : nil)
        
        
        _nc?.addObserver(self,
                        selector: #selector(repOpenConsole),
                        name : NSNotification.Name(rawValue: notification.OPEN_CONSOLE.rawValue),
                        object : nil)
        _nc?.addObserver(self,
                        selector: #selector(repCloseConsole),
                        name : NSNotification.Name(rawValue: notification.CLOSE_CONSOLE.rawValue),
                        object : nil)
         _nc?.addObserver(self,
                        selector: #selector(repWriteToConsole),
                        name : NSNotification.Name(rawValue: notification.WRITE_TO_CONSOLE.rawValue),
                        object : nil)
        _nc?.addObserver(self,
                        selector: #selector(repGetConsole),
                        name : NSNotification.Name(rawValue: notification.GET_CONSOLE.rawValue),
                        object : nil)
        _nc?.addObserver(self,
                        selector: #selector(repLoadSlideConsole),
                        name : NSNotification.Name(rawValue: notification.LOAD_SLIDE_CONSOLE.rawValue),
                        object : nil)
        
    }
   
    //MARK: HANDLERS
   
    @objc func repLoadConsoleData(notif:NSNotification){
        if(scene == nil){
            return
        }
       
        initArraySlideNode()
        loadConsoleData()
        
              }
    func openConsole(){
        
       
         loadConsoleData();
         if (slideNumber >= (arraySlideConsole?.count)! ) {
            return
        }
        _param = arraySlideConsole?[slideNumber]
        
        is_open = true
        removeChild(node: self)
      
        sizeConsole = (slideOffset[offsetValue]?["size"] as! CGSize)
        setOpenPosition()
   
        addNodeElem()
        moveConsole(p_duration:1.0)
    }
    func closeConsole(){
        
        is_open = false
        removeChild(node: self)
        setHidenPosition()
        moveConsole(p_duration:0.5)
    }
    @objc func repOpenConsole(notification:NSNotification){
        if(scene == nil){
            return
        }
        slideNumber = 0
        initConsoleEntityManager()
        initArraySlideNode()
       if autoStart == false {
        autoStart = true
        closeConsole()
        return
           }
        if is_open == false {
            openConsole()
        }else{
            closeConsole()
           openConsole()
        }
    }
     func moveConsole(p_duration:TimeInterval){
      
        switch  animation{
            
            case consoleAnimations.UP_TO_DOWN.rawValue:
            
            return
            case consoleAnimations.DOWN_TO_UP.rawValue:
                moveDownToUp(p_duration: 1.0)
                case consoleAnimations.EASY_IN.rawValue:
                    alpha = 0
                    let fadeAction = SKAction.fadeIn( withDuration: 0.2 )
                     position = posConsole
                    
                        self.run(fadeAction)
                    if self.is_open == false{
                    self.removeChild(node: self)
                }
            
            default:
          //  let moveAction:SKAction
            return
        }
        
      //   self.animation = consoleAnimations.DOWN_TO_UP.rawValue

    }
    @objc func repCloseConsole(notification:NSNotification){
        if(scene == nil){
            return
        }

        if is_open == true {
            
            is_open = false
            setHidenPosition()
            moveConsole(p_duration:1.0)
                    }
    }
    
    @objc func  repLoadSlideConsole(notif:NSNotification){
        if(scene == nil){
            return
        }

              guard (notif.userInfo?["slideNumber"] as! Int?) != nil else{
            return
        }
        
       
        slideNumber = notif.userInfo?["slideNumber"] as! Int
        slideLock = true
        openConsole()
        slideLock = false
       return
     
    }
   @objc func  repGetConsole(notif:NSNotification){
    sendNotification(notification.OBJ_CONSOLE.rawValue,["console":self as AnyObject])
    }
    @objc func  repWriteToConsole(notification:NSNotification){
      
        if(scene == nil){
            return
        }

        slideNumber = 0
        initArraySlideNode()
        autoStart = true
       
  
          guard (notification.userInfo as! Dictionary<String, AnyObject>?) != nil else{
            return
        }
        if(notification.userInfo!["offsetValue"] as? String != nil){
           offsetValue = notification.userInfo!["offsetValue"] as! String
           
           
        }
        position = posConsole
        var node = notification.userInfo!["node"] as! SKNode
        node.removeFromParent();
        is_open = true
        let height = (slideOffset[offsetValue]?["size"] as! CGSize).height
        let marge = (slideOffset[offsetValue]?["marge"] as! CGPoint)
        posConsole.y = -((scene?.size.height)!/2)
        
        posConsole.y += (height * 0.5) + marge.y
        if (children.count > 0){
            if(node != children[0]){
                removeChild(node: self)
            
            }else{
                return
            }
        }
            node.position = CGPoint(x: 0, y: 0)
            node.xScale = 1
            node.yScale = 1
            
            addChild(node)
        
      /*  if(node.parent != nil){
            
            node.move(toParent: self)
            node.position = CGPoint(x: 0, y: 0)
           
        }else{
            node.position = CGPoint(x: 0, y: 0)
            node.xScale = 1
            node.yScale = 1
      
            addChild(node)
        }*/

     moveConsole(p_duration:1.0)    
    }
    
    deinit {
   
        removeAllActions()
        consoleEntityManager?.dealloc()
        consoleEntityManager = nil
        //    _console = nil
        
    }
    func deallocate() {
        
     
        removeAllActions()
        consoleEntityManager?.dealloc()
        consoleEntityManager = nil
        _nc?.removeObserver(self)
        _nc = nil
        _param = nil
        removeChild(node: self)
        
    }

}
