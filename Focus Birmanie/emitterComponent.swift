//
//  SpriteComponent.swift
//  MonsterWars
//
//  Created by Georgia Leguem on 26/09/2016.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import SpriteKit
import  GameplayKit

class EmitterComponent:GKComponent{
    
    let node:SKSpriteNode?
    
    let emitterNode:SKEmitterNode?
    init(_ _node : SKSpriteNode,file: String = "fire"){
        node=_node
          emitterNode = SKEmitterNode(fileNamed: file)!
        emitterNode?.name = "emitter"
        let halfWidthNode = (node?.frame.size.width)!
        let halfHeightNode = (node?.frame.size.height)! 
        emitterNode?.position.y = 0
        emitterNode?.particleSize = CGSize(width: halfWidthNode, height:halfHeightNode)
        
        super.init()
       
        let addEmitterAction = SKAction.run({self.node?.addChild(self.emitterNode!)})
       //  let emitterDuration = 1000
        let emitterDuration = CGFloat((emitterNode?.numParticlesToEmit)!) * (emitterNode?.particleLifetime)!

        let wait = SKAction.wait(forDuration: TimeInterval(emitterDuration/2))
 
        let remove = SKAction.run({self.emitterNode?.removeFromParent();
          
        })
        if emitterDuration == 0{
       node?.run(addEmitterAction)
        }else{
        let sequence = SKAction.sequence([addEmitterAction, wait, remove])
        
            node?.run(sequence){
           
            }
        }
    }
    
    func afficherEmitter(){
        if (emitterNode?.isHidden)!{
         emitterNode?.isHidden = false
        }else{
            masquerEmitter()
        }
    }
    func masquerEmitter(){
      
        emitterNode?.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
