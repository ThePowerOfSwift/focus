//
//  MaterialEntitie.swift
//  Focus Birmanie
//
//  Created by Georgia Leguem on 19/10/2016.
//  Copyright © 2016 appedufun. All rights reserved.
//

import Foundation

import SpriteKit
import  GameplayKit

class ImageEntity:GKEntity {
    
    var _param : Dictionary<String, AnyObject>?
    var spriteComponent: SpriteComponent

    
    init(param : Dictionary<String, AnyObject>){
        spriteComponent = SpriteComponent(texture : SKTexture(imageNamed : "trans"))
        
        super.init()
        if(param.count>0){
            _param = template.build (param: param)
            spriteComponent = SpriteComponent(texture : SKTexture(imageNamed : _param?["texture"] as! String ))
           // spriteComponent.node?.zPosition = 100
            initNode()
            let touchableComponent = TouchableSpriteComponent(){p in
                self.handleTouch(param: p)
                
            }
            addComponent(touchableComponent)
            addComponent(spriteComponent)
            spriteComponent.addToNodeKey()
        }
        
    }
    func initNode(){
        let node = spriteComponent.node
        initPosition()
        
        node?.size = Parser.valueOf(variableName: "size", contentBy: _param!) as! CGSize
        node?.zPosition = CGFloat(Parser.valueOf(variableName: "zPosition", contentBy: _param!) as! Int)
        node?.name = Parser.valueOf(variableName: "name", contentBy: _param!) as? String
  
    }
    
    func initPosition(){
        
        spriteComponent.node?.position = Parser.valueOf(variableName: "position", contentBy: _param!) as! CGPoint
        
    }
    
    func position()->CGPoint{
        
        return   self.component(ofType : SpriteComponent.self)!.node!.position
        
    }
    func handleTouch(param: Dictionary<String , AnyObject>) {
              
    }
    
    override func deallocate(){
        print ("ImageEntities dealloc")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
