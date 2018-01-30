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



class Slider:Swipeable {
    //MARK: VARIABLES ET CONSTANTES
 private   let _nc : NotificationCenter = NotificationCenter.default
 private   let  showAction = SKAction.move(to: CGPoint(x:0,y:0), duration:0.2)

 private   let  hideAction = SKAction.move(to: CGPoint(x:0,y:-800), duration:0.5)
 private    var data:[Dictionary<String, AnyObject>]{
    get {
        return  (pl?.slidersData()[currentSlider])!

    }
    }
    
 private   var currentSlider = 0
 private   var currentSlideNumber = 0
 private   let SWIPE_LEFT = 2
 private   let SWIPE_RIGHT = 1
 private   let SWIPE_TOP = 4
 private   let SWIPE_DOWN = 8
 private   let slidePos = CGPoint(x:0,y:0)
 private   let slideWidth = CGFloat(990.0)
 private   let slideHeight = CGFloat(760.0)
 private   var permanentSlide:SKSpriteNode?
 private   var Max = 0
 private   var cursorSildes :Int = 0
 private   var listSlideNumber:Array<Int> = []
 private var WAIT_END_SWIPE = false
//MARK: INIT
    override init (){
      
        
          super.init()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        let slideBg = SKSpriteNode(texture: SKTexture(imageNamed:"middle"),  size:CGSize(width: slideWidth  , height: slideHeight))
        slideBg.position = slidePos
        slideBg.zPosition = -15
        slideBg.name="bacground slide"
        addChild(slideBg)
        
        addListener()
       
    }
    
//MARK: LISTENER
    func addListener(){
        _nc.addObserver(self,
                        selector: #selector(repLaunchSlider),
                        name : NSNotification.Name(rawValue:type_action.LAUNCH_SLIDER.rawValue),
                        object : nil)
    }
    func removeListener(){
       
        _nc.removeObserver(self)
    }
    
//MARK: HANDLER NOTIFICATION CREATION DU SLIDE
    @objc func repLaunchSlider (notification:NSNotification){
        WAIT_SWIPE = true
        
       
        guard (notification.userInfo!["sliderNum"] != nil) else{
         
            currentSlider = 0
             initMatrice()
             cursorSildes = listSlideNumber.count / 2
         
            createSlides()
            run(showAction)
            return
        }
       currentSlider = notification.userInfo!["sliderNum"] as! Int
         initMatrice()
        cursorSildes = listSlideNumber.count / 2
     
       //  initSlideAnim()
        createSlides()
      //  addChild((slideAnim)!)
        run(showAction)
       
    }
//MARK: REPONSE AU SWIPE
    override func swipeHandler(_ s:UISwipeGestureRecognizer){

        if(WAIT_END_SWIPE){
            return
        }
        WAIT_END_SWIPE = true

      

        let  moveAction:SKAction
     
        if Int(s.direction.rawValue)  == SWIPE_LEFT
        {
                self.removeListener()
                moveAction = SKAction.move(to: CGPoint(x:-912,y:0), duration:0.01)
                permanentSlide?.run(moveAction){
                    self.endMoveSlide(direction: self.SWIPE_LEFT)
                }
           
        }else if Int(s.direction.rawValue)  == SWIPE_RIGHT{
                self.removeListener()
                moveAction = SKAction.move(to: CGPoint(x:912,y:0), duration:0.01)
                permanentSlide?.run(moveAction){
                    self.endMoveSlide(direction: self.SWIPE_RIGHT)
                
                }
        }else if Int(s.direction.rawValue)  == self.SWIPE_DOWN {
           
            run(hideAction){
                self.removeChild(node:self)
                self.WAIT_END_SWIPE = false
                WAIT_SWIPE = false
                self.addListener()
            }
        }else{
                 self.addListener()
                WAIT_END_SWIPE = false
        }
    }
    //MARK: HANDLER FIN DU MOUVEMENT
    func endMoveSlide(direction:Int){
      
        let  moveAction:SKAction =  SKAction.move(to: CGPoint(x:0,y:0), duration:0.5)
     
        if(direction == SWIPE_RIGHT){
            if (cursorSildes  > 0 ){
                cursorSildes -= 1
             
            }else{
                cursorSildes = listSlideNumber.count/2
                }
            
        }else{
            if (cursorSildes  < (listSlideNumber.count) - 1 ){
             cursorSildes += 1
            }else{
             cursorSildes = listSlideNumber.count / 2
            }
        }
        currentSlideNumber = listSlideNumber[cursorSildes]
        permanentSlide?.removeAllChildren()
        permanentSlide?.removeFromParent()
       createSlides()
       permanentSlide?.run(moveAction){

        }
        self.WAIT_END_SWIPE = false
        addListener()
      
    }
    //:MARK: CREATION ET AJOUT DU SLIDE
    func createSlides(){
        var slideData = data[currentSlideNumber]
        permanentSlide = initSlide(slideData["texture"]! as! String,slideData["legend"] as! String) as? SKSpriteNode
        permanentSlide?.zPosition = -1
        addChild( permanentSlide! )
    
    }
    
//MARK: CREATION DU CONTENU DU SLIDE
    func initSlide(_ p_imageName:String,_ p_text:String)->SKNode{
        let slide = SKSpriteNode(texture: SKTexture(imageNamed:"trans"),  size: CGSize(width: slideWidth, height: slideHeight))
      
        slide.position = slidePos

        slide.addChild(newImage(p_imageName))
    
        addChild(newLabel(p_text))
        return slide
        
    }
    func newImage(_ p_imageName:String)->SKNode{
        let ill = SKSpriteNode(imageNamed: p_imageName)
        ill.size = CGSize(width: slideWidth, height: slideHeight)
        ill.position = CGPoint(x:0,y:0)
        return ill
    }
    func newLabel(_ p_text:String)->SKNode{
        let bg_label = SKSpriteNode(texture: SKTexture(imageNamed:"main"),  size:CGSize(width: slideWidth  , height: 40))
        bg_label.position.y = -(slideHeight/2)+40
        let tpl = template.templates["consolePresentation_Stitle"]
        let label:SKLabelNode = SKLabelNode()
        label.fontColor = UIColor(name: tpl!["color"] as! String)
        label.color = UIColor.black
        label.fontSize = tpl!["fontSize"] as! CGFloat
        label.fontName = Parser.valueOf(variableName: "fontName", contentBy: tpl!) as? String
        label.text = p_text
        label.position =  CGPoint(x:0,y:-15
        )
        bg_label.addChild(label)
        return bg_label
    }
//MARK: Matrice SlideNumber
    func createLine(numLine:Int){
        
       
            listSlideNumber.removeAll()
            for i in 0...numLine{
              
                listSlideNumber.append(i  )
                
            }
            listSlideNumber.append(contentsOf: listSlideNumber)
            listSlideNumber.remove(at: 0)
        
        
    }
    func initMatrice(){
        Max = data.count - 1
        createLine(numLine:Max)
        
    }
//MARK UTIL
    func removeChild(node:SKNode?){
        for c in (node?.children)!{
            if ( c.children.count<1){
                c.removeAllActions()
                c.removeFromParent()
                
            }else{
                removeChild(node:c)
                
            }
        }
}
}

