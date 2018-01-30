//
//  ButtonNode.swift
//
//


import Foundation
import SpriteKit

class ButtonNode : SKSpriteNode {


   var paramFunc: Dictionary<String, AnyObject>?
   var onButtonPress: (Dictionary<String, AnyObject>)->Void;
    init(iconName: String, text: String,buttonSize:CGSize, onButtonPress: @escaping (Dictionary<String, AnyObject>) -> ()) {
   
        self.onButtonPress = onButtonPress
        let paramBtn = template.build(param: ["template":"consoleGuide_btn" as AnyObject])
        super.init(texture:(SKTexture(imageNamed:paramBtn["texture"] as! String )), color: SKColor.white, size: buttonSize)
        let label = SKLabelNode()
        label.fontSize = paramBtn["fontSize"] as! CGFloat
        label.fontColor = UIColor(name:paramBtn["color"] as! String)
        label.fontName = Parser.valueOf(variableName: "fontName", contentBy: paramBtn) as? String
        
    label.zPosition = 1
    label.verticalAlignmentMode = .center
    label.text = text
    self.addChild(label)
    label.position = CGPoint(x: 0 , y: 0)
    isUserInteractionEnabled = true

  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    onButtonPress(paramFunc!)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    deinit{
        removeAllActions()
        removeAllChildren()
        paramFunc?.removeAll()
       
        
    }
}
