//
//  BagScene.swift
//  Focus Birmanie
//
//  Created by Laurent Aubourg on 26/09/2016.
//  Copyright © 2016 appedufun. All rights reserved.
//

import SpriteKit
import GameplayKit

class BagScene:GameScenes{
    
   
    var elements : Array<Dictionary<String, AnyObject>>?

    override func didMove(to view: SKView) {
        pageName = pages_name.BAG.rawValue
       
        let seqNumber:Int = 1;
        super.didMove(to: view)
        sendNotification(notification.CHANGE_SEQUENCE.rawValue,["numSequence":seqNumber as AnyObject])
        sendNotification(
            notification.VIEW_BAG.rawValue,[:]   )
    }
  /*  override func willMove(from view: SKView){
       // let sequenceNumber = pl?.previousSequence
      //  sendNotification(notification.CHANGE_SEQUENCE.rawValue,["numSequence":sequenceNumber as AnyObject])
    

    }*/
   
    class func fromFile()->BagScene{
        
        return BagScene(fileNamed: "BagScene")!
    }
    override func update(_ currentTime: TimeInterval) {
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
  
}
