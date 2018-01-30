//
//  listeEntity.swift
//  Focus Birmanie
//
//  Created by Laurent Aubourg on 06/01/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//

import Foundation
import  GameplayKit

class MessageEntity:GKEntity {
    
    var _param : Dictionary<String, AnyObject>?
    var spriteComponent: SpriteComponent
       
    init(param : Dictionary<String, AnyObject>){
        spriteComponent = SpriteComponent(texture : SKTexture(imageNamed : "trans"))
        super.init()
        if(param.count>0){
            _param = param;
            spriteComponent = SpriteComponent(texture : SKTexture(imageNamed : Parser.valueOf(variableName: "texture", contentBy: _param!)  as! String ))
            
            initNode()
            let textComponent = TextComponent(p_param: param, spriteComponent.node!)
           
            let animateComponent = AnimationComponent(p_param: param, textComponent.node!)
        /*    let touchableComponent = TouchableSpriteComponent(){p in
                self.handleTouch(param: p)
                
            }*/
           
          //  addComponent(touchableComponent)
            addComponent(spriteComponent)
            addComponent(textComponent)
            addComponent(animateComponent)
            spriteComponent.addToNodeKey()
            animateComponent.zoom(2.5)
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
        if((_param) != nil){
            spriteComponent.node?.position = Parser.valueOf(variableName: "position", contentBy: _param!) as! CGPoint
            
        }
    }
    
    func position()->CGPoint{
        let spc =  self.component(ofType : SpriteComponent.self)
        return   spc!.node!.position
        
    }
    func handleTouch(param: Dictionary<String , AnyObject>) {
 
   
    }
    override func deallocate(){
        print ("MessageEntities dealloc")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
