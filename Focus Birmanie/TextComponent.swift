 //
//  SpriteComponent.swift
//  MonsterWars
//
//  Created by Georgia Leguem on 26/09/2016.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import SpriteKit
import  GameplayKit

class TextComponent:GKComponent{
    
  weak  var node:SKSpriteNode?
    var param : Dictionary<String, AnyObject>?
    
     init(p_param : Dictionary<String, AnyObject>, _ _node : SKSpriteNode){
       
        super.init()
        node = _node
        param = p_param
        print ("createContentText()")
        createContentText()
     
    }
    
    func masquer(){
        let texture = SKTexture(imageNamed: "trans")
        let action = SKAction.animate(with: [texture], timePerFrame: TimeInterval(0.5)) ;
        node?.run(action)
        }
    func zoom(_ scaleValue:CGFloat){
      
        let scale = SKAction.scale(to: scaleValue, duration: 0.5)
        node?.run(scale)
       
    }
    func resetZoom(){
        
        let scale = SKAction.scale(to: 1, duration: 0.5)
        node?.run(scale)
    }
    func createContentText(){
       let align = Parser.valueOf(variableName: "align", contentBy: param!)  as!  Int
        let leading  =  Parser.valueOf(variableName: "leading", contentBy: param!)  as!  Int
        let color = Parser.valueOf(variableName: "color", contentBy: param!)  as! String
        let txt = Parser.valueOf(variableName: "txt", contentBy: param!)  as! String
        
      //  // print(param!)
        //    let txt = _param?["txt"] as! String
        let fontSize = CGFloat( Parser.valueOf(variableName: "fontSize", contentBy: param!)  as!  Int)
        let fontName = String( Parser.valueOf(variableName: "fontName", contentBy: param!)  as!  String)
        let bold = Bool( Parser.valueOf(variableName: "bold", contentBy: param!)  as!  Bool)
        let content = SKMultilineLabel(
            text: txt,
            labelWidth:Int((node?.size.width)!-20),
            pos: CGPoint(x:0,y:0),
            fontName:fontName,
            fontSize: fontSize,
            fontColor : UIColor(name:color)! ,
            leading : leading,
            alignement : SKLabelHorizontalAlignmentMode(rawValue: align)!,
            bold : bold
            
        )
        
        let pos = CGPoint(
            x:0,
            y: ( (node?.size.height)! / 4)
        )
       
        content.position = pos
        content.alignment = .left
        
        
        
       
        node?.addChild(content)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit  {
        print("TextComponent deinit name : \(node?.name)")
        removeChild(node: node!)
        node = nil
        
    }
 

}
