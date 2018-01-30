//
//  SpriteComponent.swift
//  FocusBirmanie
//
//  Created by Laurent Aubourg on 26/09/2016.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import SpriteKit
import  GameplayKit

class SpriteComponent:GKComponent{
    var node:SKSpriteNode?
    
    init(texture : SKTexture){
        
        node = SKSpriteNode(texture: texture, color: SKColor.white, size: CGSize(width: 100, height: 100))
            super.init()
       
    }
    
    func addToNodeKey() {
        self.node?.user_data = NSMutableDictionary()
        self.node?.user_data.setObject(self.entity!, forKey: "entity" as NSCopying)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit  {
       print("SpriteComponent deinit name : \(String(describing: node?.name))")
        removeChild(node: node!)
        node = nil
        
    }
}
