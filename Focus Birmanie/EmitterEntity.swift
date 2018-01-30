//
//  EmitterEntity.swift
//  Focus Birmanie
//
//  Created by Georgia Leguem on 14/02/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//


import Foundation
import  GameplayKit

class EmitterEntity:GKEntity {
    
    var _param : Dictionary<String, AnyObject>?
    var emitterFile = "fire"
    var node : SKSpriteNode?
    
    var idElem:String{
        get {
            return _param!["id"] as! String
        }
    }
    var spriteComponent: InSceneComponent
    
     init(param : Dictionary<String, AnyObject>, node p_node:SKSpriteNode ){
        node = p_node
         spriteComponent = InSceneComponent(node : p_node)
        super.init()
  
            _param = param;
       if ((node?.user_data["file"]) != nil)  {
        emitterFile = node?.user_data["file"] as! String
        }
        
            let emitterComponent = EmitterComponent(spriteComponent.node!,file: emitterFile)
            
        
            addComponent(spriteComponent)
         addComponent(emitterComponent)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initNode(){
        
        let node = spriteComponent.node
        initPosition()
 
        node?.size = Parser.valueOf(variableName: "size", contentBy: _param!) as! CGSize
        node?.zPosition = CGFloat(Parser.valueOf(variableName: "zPosition", contentBy: _param!) as! Int)
        node?.name = Parser.valueOf(variableName: "name", contentBy: _param!) as? String
        
    }
    override func deallocate(){
        print ("EmmiterEntities dealloc")
    }
    func initPosition(){
        if((_param) != nil){
            spriteComponent.node?.position = Parser.valueOf(variableName: "position", contentBy: _param!) as! CGPoint
           
        }
    }
}
