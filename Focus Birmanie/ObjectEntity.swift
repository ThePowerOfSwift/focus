//
//  ObjectEntity.swift
//  Focus Birmanie
//
//  Created by Georgia Leguem on 01/03/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//


import Foundation

import SpriteKit
import  GameplayKit

class ObjectEntity:GKEntity {
    
    var _param : Dictionary<String, AnyObject>?
    var node : SKSpriteNode?
   
    var idElem:String{
        get {
            return _param!["id"] as! String
        }
    }
    var spriteComponent: InSceneComponent?
    var consoleComponent: ConsoleComponent?
    var touchableComponent:TouchableSpriteComponent?
  
    
    init(param : Dictionary<String, AnyObject>, node p_node:SKSpriteNode ){
        node = p_node
        spriteComponent = InSceneComponent(node : p_node)
        super.init()
        
        if(param.count>0){
            _param = param
       
             node?.user_data["paramNode"] = param
            let id:String = (node?.user_data["id"])! as! String
            if(!(player?.isInBag(id:id))!){
                node?.isHidden = false
                consoleComponent = ConsoleComponent(param: initWindow())
                addComponent(consoleComponent!)
                
            }else{
             node?.isHidden = true
            }
        }
         touchableComponent = TouchableSpriteComponent(){
            p in
            self.handleTouch(param: p)
            
        }
        
        addComponent((touchableComponent)!)
        addComponent(spriteComponent!)
        spriteComponent?.addToNodeKey()
    }
    func addWindow(param:Dictionary<String, AnyObject>){
        _param = param;
         let id:String = (node?.user_data["id"])! as! String

        if(!(player?.isInBag(id:id))!){
            
            let consoleComponent = ConsoleComponent(param: initWindow())
            addComponent(consoleComponent)
        }
    }
    func initWindow()->Dictionary<String, AnyObject>{
        let window = _param?["window"] as! Dictionary<String, AnyObject>
        let windowName = window["type"] as? String
        let windowTitre = window["titre"] as? String
        let sizeWindow = window["size"]
        let windowTxt = window["text"] as? String
        if (windowName != nil){
            var paramWindow = pl?.window(windowName: windowName!)
            paramWindow?["size"] = sizeWindow
            paramWindow?["titre"] = windowTitre as AnyObject?
            paramWindow?["txt"] = windowTxt as AnyObject?
            paramWindow?["leading"] = window["leading"]
            let posDic = node?.position.dictionaryRepresentation as AnyObject?
            
            paramWindow?["parent_position"] = posDic
            if haveButton(p_window: (window)){
                paramWindow?["buttons"] = window["buttons"]
            }
            return paramWindow!
            
        }
        return[:]
    }
    func haveButton(p_window: Dictionary<String, AnyObject>)->Bool{
        if p_window["buttons"] != nil{
            return true
        }
        return false
    }
    func position()->CGPoint{
        let spc =  self.component(ofType : SpriteComponent.self)
        return   spc!.node!.position
        
    }
    func handleTouch(param: Dictionary<String , AnyObject>) {
     
    //    sendNotification(type_action.CLOSE_WINDOW.rawValue, [:])
               //spriteComponent.node.run(SoundManager.sharedInstance.popMaterial)
      soundManager.playSoundEffect("pop.mp3") // --
       let node = spriteComponent?.node
        _param?["CSEE"] = spriteComponent?.node?.user_data["CSEE"] as AnyObject
        _param?["texture"] = spriteComponent?.node?.user_data["_textureImageName"] as AnyObject
       // _param?["node"] = node
        pl?.touchedNodeData = _param!
       // let emitterComponent = EmitterComponent(spriteComponent.node,file: "magic")
        
        //addComponent(emitterComponent)
        
        
     //   let scene = spriteComponent.node.scene
        
       // let camera = scene?.camera
        if  let consoleComponent = component(ofType: ConsoleComponent.self){
            
            consoleComponent.createWindow(in: node!)
            
        
        }
        
    }
    override func deallocate(){
        print ("ObjectEntities dealloc")
        
        removeChild(node: node!)
       
        consoleComponent?.deallocate()
        touchableComponent?.deallocate()
        touchableComponent = nil
        spriteComponent?.deallocate()
        removeComponent(ofType: InSceneComponent.self)
        removeComponent(ofType: ConsoleComponent.self)
        consoleComponent = nil
        spriteComponent = nil
        removeComponent(ofType: TouchableSpriteComponent.self)
        node = nil
        _param = nil
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

