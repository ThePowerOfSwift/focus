//
// TextEntity.swift
//  Focus Birmanie
//
//  Created by Georgia Leguem on 19/10/2016.
//  Copyright © 2016 appedufun. All rights reserved.
//

import Foundation

import SpriteKit
import  GameplayKit

class TextEntity:GKEntity {
    
   var _param : Dictionary<String, AnyObject>?
  var spriteComponent: SpriteComponent?
  var textComponent : TextComponent?
    
    init(param : Dictionary<String, AnyObject>){
    //    spriteComponent = SpriteComponent(texture : SKTexture(imageNamed : "trans"))
        super.init()
        if(param.count>0){
            
            _param = template.build(param: param)
            spriteComponent = SpriteComponent(texture : SKTexture(imageNamed : Parser.valueOf(variableName: "texture", contentBy: _param!)  as! String ))
            
            initNode()
            textComponent = TextComponent(p_param: _param!, (spriteComponent?.node!)!)
            addComponent(spriteComponent!)
            guard textComponent != nil else{
                return
            }
            addComponent(textComponent!)
            spriteComponent?.addToNodeKey()
            
        }
    }
    func initNode(){
        
        let node = spriteComponent?.node
        initPosition()
        
        node?.size = Parser.valueOf(variableName: "size", contentBy: _param!) as! CGSize
        node?.zPosition = CGFloat(Parser.valueOf(variableName: "zPosition", contentBy: _param!) as! Int)
        node?.name = Parser.valueOf(variableName: "name", contentBy: _param!) as? String
           


    }
    
    func initPosition(){
        if((_param) != nil){
            spriteComponent?.node?.position = Parser.valueOf(variableName: "position", contentBy: _param!) as! CGPoint
      
        }
    }
    
    func position()->CGPoint{
        let spc =  self.component(ofType : SpriteComponent.self)
        return   spc!.node!.position
        
    }
    override  public func deallocate() {
        print ("textEntity dealloc")
        removeChild(node:  (spriteComponent?.node!)!)
        _param = nil
        textComponent = nil
        spriteComponent = nil
    }
    deinit{
        
        print ("textEntity deinit")
       
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
