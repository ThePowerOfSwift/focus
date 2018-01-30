//
//  Sac.swift
//  Focus Birmanie
//
//  Created by Laurent Aubourg on 05/04/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//
//


import Foundation
import GameplayKit
import SpriteKit
import UIKit



class Slider_btn:Tapable {
    
  
    
    override init (){
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func tapHandler(_ s:UITapGestureRecognizer){
        guard((user_data["sliderNum"]) != nil) else{
            sendNotification(type_action.LAUNCH_SLIDER.rawValue, ["sliderNum":0 as AnyObject])
            return
        }
        sendNotification(type_action.LAUNCH_SLIDER.rawValue, ["sliderNum":user_data["sliderNum"] as AnyObject])
       
    }
   
}





