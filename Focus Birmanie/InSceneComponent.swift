//
//  InSceneComponent.swift
//  //
//  Created by Laurent Aubourg on 26/09/2016.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import SpriteKit
import  GameplayKit

class InSceneComponent:GKComponent{
   var node:SKSpriteNode?
    
    init(node p_node:SKSpriteNode){
      
        node = p_node
       // node.zPosition = 100
       

        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addToNodeKey() {
        
        if (node?.isKind(of: Touchable.self))!{
           node?.user_data.setValue(self.entity! as! AnyObject , forKey: "entity" as String)
        }
      
    }
    override public func deallocate() {
        print("deallocate InSceneComponent")
        print (node)
        removeChild(node: node!)
        node = nil
     
    }
}
