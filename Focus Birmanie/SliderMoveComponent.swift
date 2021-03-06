
import SpriteKit
import  GameplayKit
import UIKit

class SliderMoveComponent:GKComponent{
    var _spriteComponent : SpriteComponent{
        get{
            guard let _spriteComponent = entity?.component(ofType: SpriteComponent.self) else{
                return SpriteComponent(texture: SKTexture(imageNamed:"trans"))
            }
            return _spriteComponent
        }
    }
    var _dataSlider : DataSliderComponent?{
        get{
            guard let _dataSliderComponent = entity?.component(ofType: DataSliderComponent.self) else{
                return nil
            }
            return _dataSliderComponent
        }
    }
    var slider:SKSpriteNode{return _spriteComponent.node!}
    private let slide1 = SKSpriteNode()
    private let slide2 = SKSpriteNode()
    var slidePosition = CGPoint.zero
    var slidePosition2 = CGPoint.zero
    var slidePosition3 = CGPoint.zero
    var nbSlide:Int{
        return dataSlider.nbSlides
    }
    struct OrderSlide{
        
        var slide1 = SKSpriteNode()
        var slide2 = SKSpriteNode()
        private var _out = SKSpriteNode()
        init(_ p_slide1 : SKSpriteNode,_ p_slide2 : SKSpriteNode){
            slide1 = p_slide1
            slide2 = p_slide2
            SlideOut = slide1
        }
        mutating func reverse(){
            if (slide2 == SlideIn){
                SlideOut = slide2
            }else{
                SlideOut = slide1
            }
        }
        var SlideOut:SKSpriteNode{
            get{
               
                return (_out)
            }
            set{
                _out = newValue
             
            }
        }
      
        var SlideIn:SKSpriteNode{
            get{
                if (_out == slide1 ){
                   
                    return slide2
                }else{
                       return slide1
                }
            }
        }
    }
    var  orderSlide:OrderSlide?
    private var dataSlider : DataSliderComponent{
        get{
            guard  ((entity?.component(ofType: DataSliderComponent.self )) != nil)else{
            return DataSliderComponent()
           }
            return (entity?.component(ofType: DataSliderComponent.self ))!
        }
    }
    //MARK: - actions
    private var _scale:SKAction?
    private var _unscale:SKAction?
    private var scaleIn:SKAction?
    private var scaleOut:SKAction?
    private var wait:SKAction?
    private var fadeIn :SKAction?
    private var fadeOut:SKAction?
    private var move :SKAction?

    private   let _nc : NotificationCenter = NotificationCenter.default
    //MARK: - METHODS
    override init(){
        
        super.init()

        
    }
    override  func build(){
        let slideSize = _dataSlider?.SliderSize
        slider.size.width = (slideSize?.width)! * 2
        slider.size.height = (slideSize?.height)!
     
        slidePosition2.x =  (slideSize?.width)!
      //  slidePosition3.x = (slideSize?.width)! * -1
        slide1.size = slideSize!
        slide2.size = slideSize!
        slide1.position = slidePosition
        slide1.name = "slide1"
        slide2.position = slidePosition2
        slide2.name = "slide2"
        
       slider.addChild(slide1)
       slider.addChild(slide2)
        
        dataSlider.currentSlide = 0
        
        slide1.texture = dataSlider.slideTexture
        dataSlider.currentSlide = 1
         slide2.texture = dataSlider.slideTexture
       // dataSlider.currentSlide = 0
       
        playAnimation()
    }
    func showLegend(){
        if(dataSlider.SlideLegend != ""){
             let e = entity as! SliderEntity
            
            sendNotification(notification.WRITE_TO_CONSOLE.rawValue, ["node":e.messageConsole(title: (dataSlider.SlideLegend)) as SKNode,"offsetValue":"mini"] as Dictionary<String, AnyObject>)
            
        }else{
            sendNotification(notification.CLOSE_CONSOLE.rawValue, [:] )
        }
    }
    func loadActions(){
    _scale = SKAction.scale(to:dataSlider.SlideScaleValue, duration: TimeInterval((dataSlider.slideDuration / 2) ))
    _unscale = SKAction.scale(to:1.0 , duration: TimeInterval((dataSlider.slideDuration / 2) ))
    scaleIn = SKAction.sequence([_scale!,_unscale!])
    scaleOut = SKAction.sequence([_scale!,_unscale!])
    wait = SKAction.wait(forDuration: (TimeInterval(dataSlider.slideTime2wait)))
    fadeIn = actionsStruct(_duration: dataSlider.slideDuration ,
    scaleTo: nil,
    targetPoint: nil)._fade_in
    fadeOut = actionsStruct(_duration: dataSlider.slideDuration  ,
    scaleTo: nil,
    targetPoint: nil)._fade_out
    move = actionsStruct(_duration: dataSlider.slideDuration,
    scaleTo: nil,
    targetPoint: CGPoint(x:-((_dataSlider?.SliderSize.width)!) ,y:dataSlider.SliderPosition.y))._move
    }
    func runActions()
    {
        loadActions()
        orderSlide?.SlideOut.run(scaleOut!)
        orderSlide?.SlideIn.run(scaleIn!)
        orderSlide?.SlideIn.run(fadeIn!)
        orderSlide?.SlideOut.run(fadeOut!){
            self.orderSlide?.SlideOut.alpha = 1
            self.orderSlide?.SlideIn.alpha = 1
        }
    }
    //MARK: playAnimation
    func playAnimation(){
        if dataSlider.currentSlide + 1 < nbSlide  {
          
            orderSlide = OrderSlide(slide1,slide2)
            showLegend()
            runActions()
            let emitterNode = SKEmitterNode(fileNamed: "smoke")!
            emitterNode.position = CGPoint(x:0,y:-((_dataSlider?.SliderSize.height)! / 2))
            orderSlide?.SlideIn.addChild(emitterNode)
            
            slider.run(move!){
                self.orderSlide?.SlideOut.texture = self.dataSlider.slideTexture
                self.orderSlide?.SlideOut.position = self.slidePosition2
                self.orderSlide?.SlideOut.position = self.slidePosition
                self.orderSlide?.reverse()
            
                self.dataSlider.currentSlide += 1
                self.orderSlide?.SlideOut.texture = self.dataSlider.slideTexture
                self.slider.position = self.dataSlider.SliderPosition
                emitterNode.removeFromParent()
                self.slider.run(self.wait!){
                    self.playAnimation()
                }
            }
            
        }else{
            sendNotification(type_action.CHANGE_PAGE.rawValue,["pageName":pages_name.RANGOON.rawValue as AnyObject, "numSequence":1 as AnyObject])
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


