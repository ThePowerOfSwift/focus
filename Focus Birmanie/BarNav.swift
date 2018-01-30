//
//  barNav.swift
//  Focus Birmanie
//
//  Created by Georgia Leguem on 07/09/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class barNav: SKSpriteNode {
    let nc : NotificationCenter = NotificationCenter.default
    private var backGround: SKShapeNode?
   
    
    init() {
        
        let spriteColor = SKColor.green
        let spriteSize = CGSize(width: 10.0, height: 10.0)
    
        super.init(texture: nil, color: spriteColor, size: spriteSize)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        backGround = SKShapeNode()
        
    }
    func addListener(){
       
    }
   
}
