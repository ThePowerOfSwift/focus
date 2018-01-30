//
//  MaterialNode.swift
//  Focus Birmanie
//
//  Created by Georgia Leguem on 28/02/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class MaterialNode: Touchable {
 
    var entity_name:String = entityName.OBJECT_ENTITY.rawValue
  
    override init() {
        super.init()
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    user_data.setValue(texture?.name as AnyObject, forKey: "_textureImageName")
     
    }
    deinit{
    
        
        emitterNode = nil
        _gesture = nil
    }
}
