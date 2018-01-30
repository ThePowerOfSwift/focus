import Foundation
import SpriteKit
import  GameplayKit
 import UIKit
struct actionsStruct{
    var _duration : CGFloat? = nil
    var scaleTo:CGFloat? = nil
    var targetPoint : CGPoint? = nil
    var _scale:SKAction{
        get{
            return SKAction.scale(to: scaleTo! , duration: TimeInterval((_duration)! ))
        }
    }
    var _fade_in:SKAction{
        get{
            return SKAction.fadeIn(withDuration: TimeInterval(_duration!))
        }
    }
    var _fade_out:SKAction{
        get{
            return SKAction.fadeOut(withDuration: TimeInterval(_duration!))
        }
    }
    var _wait:SKAction{
        get{
            return SKAction.wait(forDuration: TimeInterval(_duration!))
        }
    }
    var  _move:SKAction{
        get{
           
            return SKAction.moveBy(x: (targetPoint?.x)!, y: 0.0, duration: TimeInterval(_duration!))
        }
    }
}
class SliderEntity:GKEntity {
    
    private var _param : Dictionary<String, AnyObject>?
    var spriteComponent: SpriteComponent?
    var dataSpc : DataSpriteComponent?
    var sliderComponent:GKComponent?
    var dataSliderComponent: DataSliderComponent?
    init(param : Dictionary<String, AnyObject>){
    
        super.init()
        if(param.count>0){
            
            _param = template.build(param: param)
            //MARK: - SpriteComppnent
            spriteComponent = SpriteComponent(texture : SKTexture(imageNamed : Parser.valueOf(variableName: "texture", contentBy: _param!)  as! String ))
           
            addComponent(spriteComponent!)
            
            spriteComponent?.addToNodeKey()
            //MARK: - DataSpriteComponent
            dataSpc = DataSpriteComponent(p_param: _param!)
            guard dataSpc != nil else{
                return
            }
             addComponent(dataSpc!)
            initNode()
           //MARK: - DataSliderComponent
            dataSliderComponent = DataSliderComponent()
            guard dataSliderComponent != nil else{
                return
            }
          addComponent(dataSliderComponent!)
            
            
            switch dataSliderComponent?.sliderType{
            case  "move"?:
                sliderComponent = SliderMoveComponent()
            case  "fade"?:
                sliderComponent = SliderFadeComponent()
            default:
                sliderComponent = SliderMoveComponent()
            }
            addComponent(sliderComponent!)
            
            
        }
    }
    func build(){
        sliderComponent?.build()
    }
  
   
    func initNode(){
        
        let node = spriteComponent?.node
        initPosition()
        
        node?.size = Parser.valueOf(variableName: "size", contentBy: _param!) as! CGSize
        node?.zPosition = CGFloat(Parser.valueOf(variableName: "zPosition", contentBy: _param!) as! Int)
        node?.name = Parser.valueOf(variableName: "name", contentBy: _param!) as? String

    }
    func messageConsole(title: String)->SKNode{
        var node = SKSpriteNode(texture:SKTexture(imageNamed:"trans"))
        let param = template.templates["consoletextInfo_label"]!
        let label = SKLabelNode(text: title)
        if param["bold"] as! Bool {
            label.fontName = "Cuprum-Bold"
        }else{
            label.fontName = "Cuprum"
        }
        label.fontColor = UIColor(name:param["color"] as! String)
        label.name = "title_lab"
        // label.text = (_param?["titre"] as! String)
        label.position = CGPoint.zero
        node.addChild(label)
        return node
        
    }
    func initPosition(){
      
        spriteComponent?.node?.position = dataSpc!.posititonSprite()

    }
    
    func position()->CGPoint{

        return   spriteComponent!.node!.position
        
    }
     override public func deallocate() {
        print ("textEntity dealloc")
        removeChild(node:  (spriteComponent?.node!)!)
        _param = nil
        dataSpc = nil
        dataSliderComponent = nil
    }
    deinit{
        
        print ("textEntity deinit")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

