//
//  CameraManager.swift
//  Focus Birmanie
//
//  Created by Laurent Aubourg on 29/11/2016.
//  Copyright © 2016 appedufun. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
class CameraManager{
  weak  var _camera:SKCameraNode?
    var nc : NotificationCenter = NotificationCenter.default
    var _console:ConsoleCamera?
    var cameraPosition:CGPoint{
        return (_camera?.position)!
    }
    init(camera:SKCameraNode,p_position:CGPoint){
       
      
        _camera = camera
        _console = nil
        self.positionCamera(position:p_position)
        
        addListener()
        
       _console = ConsoleCamera(node:SKNode())
                _camera?.addChild(_console!)
         
        _console?.addListener()
    }
    
    func positionCamera(position p_position:CGPoint){
        _camera?.position = p_position
    }
    //MARK: ACTIONS
    
    func scaleCamera(from p_from:CGFloat = 1 ,
                     to p_to:CGFloat,
                     duration p_duration:TimeInterval,
                     completion:Bool = false){
        let scale = SKAction.scale(to: p_to, duration: p_duration)
        _camera?.run(scale){
            if(completion == true){
             let scale2 = SKAction.scale(to: p_from, duration: p_duration)
            self._camera?.run(scale2)
            }
        }
    }
    func moveCamera(to p_to:CGPoint,duration p_duration:TimeInterval){
        let move = SKAction.move(to: p_to, duration: p_duration)
        _camera?.run(move)
    }
    func containNode(node p_node:SKNode)->Bool{
        return _camera!.contains(p_node)
    }
    // MARK: LISTENER
    func removeListener(){
        nc.removeObserver(self)
    }
    func addListener(){
        
        nc.addObserver(self,
                       selector: #selector(repScaleCamera(notification:)),
                       name : NSNotification.Name(rawValue: notification.SCALE_CAMERA.rawValue),
                       object : nil)
        nc.addObserver(self,
                       selector: #selector(repMoveCamera(notification:)),
                       name : NSNotification.Name(rawValue: notification.MOVE_CAMERA.rawValue),
                       object : nil)
              
    }
    //MARK: HANDLERS
    
      @objc func repMoveCamera(notification:NSNotification)
    {
        if  let  userInfo = notification.userInfo as! Dictionary<String, AnyObject>?{
            
            let newPoint   = userInfo["newPoint"] as! CGPoint
            let duration = userInfo["duration"] as! TimeInterval
            moveCamera(to:newPoint ,duration:duration)
        }
    }
    @objc func repScaleCamera(notification:NSNotification)
    {
        if  let  userInfo = notification.userInfo as! Dictionary<String, AnyObject>?{
            
            let ratio   = userInfo["ratio"] as! NSNumber
            let duration = userInfo["duration"] as! TimeInterval
            scaleCamera(to: CGFloat(ratio.floatValue), duration: duration)
        }
    }
    //MARK: DEINIT
    deinit {
       
     
    }
    func deallocate(){
       
        nc.removeObserver(self)
        
        _console?.deallocate()
        _camera?.removeAllActions()
        _camera?.removeFromParent()
       _camera = nil
        _console = nil
        
    }

}
