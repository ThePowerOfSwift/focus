  //
//  ButtonComponent.swift
//  FocusBirmanie
//
//  Created by Laurent Aubourg on 26/09/2016.
//

import SpriteKit
import  GameplayKit

class ButtonComponent:GKComponent{
    
  
    var _param: Dictionary<String, AnyObject>
    var _action: type_action
    
    
    init(param p_param: Dictionary<String, AnyObject>) {
        let actionString = p_param["action"]
        _action = type_action(rawValue: actionString as! String)!
        
       _param = p_param
        super.init()
        
    }

    func touched(){
        pl?.touchedNodeData = _param

        sendNotification(_action.rawValue,_param)
        
    }
           required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit  {
        print("ButtonComponent deinit :")
 
        
    }
}
