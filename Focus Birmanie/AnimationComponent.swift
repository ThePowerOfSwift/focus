//
//  AnimationCompnent.swift
//  MonsterWars
//
//  Created by Laurent Aubourg on 26/09/2016.
//

import SpriteKit
import  GameplayKit
import UIKit

class AnimationComponent:GKComponent{
    
    var node:SKSpriteNode?
    var param : Dictionary<String, AnyObject>?
    
    init(p_param : Dictionary<String, AnyObject>, _ _node : SKSpriteNode){
        
        super.init()
        node = _node
        param = p_param
        
        afficher()
    }
    func afficher(){
       /* let texture = SKTexture(imageNamed: "player")
        let action = SKAction.animate(with: [texture], timePerFrame: TimeInterval(0.5)) ;
        node?.run(action)*/
    }
    func masquer(){
        
       
        let texture = SKTexture(imageNamed: "trans")
        let action = SKAction.animate(with: [texture], timePerFrame: TimeInterval(0.5)) ;
        node?.run(action)
    }
    func zoom(_ scaleValue:CGFloat){
       let  listLabel = (((node?.children)!)[0] as! SKMultilineLabel).labels
        for lab in listLabel {
           
            let growAction = SKAction.scale(by: 1.5, duration: 0.4)
            let shrinkAction = SKAction.scale(by: 0.8333, duration: 0.4)
                let reset = SKAction.scale(by: 1, duration: 0.5)
            let growAndShrink = SKAction.sequence([growAction, shrinkAction])
        
            lab.run(SKAction.repeat(growAndShrink, count: 2)){
                
                    lab.run(reset)
                }
            
        }
    }
    func resetZoom(){
           }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
