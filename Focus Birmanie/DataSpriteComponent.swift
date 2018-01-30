//
//  AnimationCompnent.swift
//  MonsterWars
//
//  Created by Laurent Aubourg on 26/09/2016.
//

import SpriteKit
import  GameplayKit
import UIKit
extension GKComponent {
    
    func otherComponents() -> [GKComponent?] {
        guard ((entity) != nil) else{
            return []
        }
        return (entity?.components)!
    }
}
class DataSpriteComponent:GKComponent{
    
    var  _param:Dictionary<String, AnyObject>?
    var  param:Dictionary<String, AnyObject>{
        get{
        return (_param)!
        }
        set{
            _param = newValue
        }
    }
     var nbSlides = 0
     var currentSlider = 0
     var currentSlide = 0
    private   let _nc : NotificationCenter = NotificationCenter.default
    
  
    init(p_param : Dictionary<String, AnyObject>){
        
        super.init()
        print(otherComponents())
        param = p_param
        
    }
    func posititonSprite()-> CGPoint{
       
            guard let pos  = Parser.valueOf(variableName: "position", contentBy: param) as? CGPoint else{
                return CGPoint.zero
        }
          return pos
    }
    func sizeSprite()-> CGSize{
        
        guard let size  = Parser.valueOf(variableName: "size", contentBy: param) as? CGSize else{
            return CGSize(width : 10, height:10)
        }
        return size
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


