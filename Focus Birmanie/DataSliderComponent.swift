import SpriteKit
import  GameplayKit
import UIKit

class DataSliderComponent:GKComponent{
//MARK: PROPERTIES
        private   let _nc : NotificationCenter = NotificationCenter.default
  //MARK: SLIDES
    
    var slideTime2wait: CGFloat{
        guard (currentSlideData["time2wait"] as? CGFloat != nil) else{
            return 0.0
        }
        return currentSlideData["time2wait"] as! CGFloat
    }
   var slideDuration: CGFloat{
        guard (currentSlideData["duration"] as? CGFloat != nil) else{
            return 0.1
        }
        return currentSlideData["duration"] as! CGFloat
    }
    var slideTexture: SKTexture{
guard (currentSlideData["texture"] as? String != nil) else{
            return SKTexture(imageNamed:"trans")
        }
        
        return SKTexture(imageNamed:currentSlideData["texture"] as! String)
    }
    var SlideLegend: String{
        guard (currentSlideData["legend"] as? String != nil) else{
            return ""
        }
        return currentSlideData["legend"] as! String
    }
    var SlideScaleValue: CGFloat{
        guard (currentSlideData["scaleValue"] as? CGFloat != nil) else{
            return 1.0
        }
        return currentSlideData["scaleValue"] as! CGFloat
    }
    //MARK: SLIDER
    var param : Dictionary<String, AnyObject>?{
        get{
            guard ((entity?.component(ofType: DataSpriteComponent.self)?.param) != nil) else{
                print ("pas de parametre")
               return nil
            }
            return (entity?.component(ofType: DataSpriteComponent.self)?.param)!
        }
    }
    var data:[Dictionary<String, AnyObject>]?{
        get {
            guard (param != nil) else{
                return nil
            }
            return  param!["slider"] as? [Dictionary<String, AnyObject>]
        }
        
    }
    var sliderTypeDefault = "move"
    var sliderType : String{
        get {
        guard (param!["type"] != nil) else{
            return  sliderTypeDefault
        }
            return  (param!["type"] as? String)!
        }
    }
    var currentSlideData:Dictionary<String, AnyObject>{
        return data![currentSlide]
    }
    var nbSlides:Int{
        return data!.count
    }
    var currentSlide = 0
    
    var nextSlide:Int{
        if currentSlide + 1 < nbSlides {
            return currentSlide + 1
        }else {
            print ("pas de slide suivant")
            return 0
        }
    }

    var SliderSize:CGSize{
        guard let sizeDic = (param!["size"] as? Dictionary<String,AnyObject>) else{
            return CGSize(width:10,height:10)
        }
       return CGSize(width: sizeDic["width"] as! CGFloat, height: sizeDic["height"] as! CGFloat)
       
    }
    var SliderPosition:CGPoint{
        guard let posDic = (param!["position"] as? Dictionary<String,AnyObject>) else{
        return CGPoint(x:0,y:0)
        }
    return CGPoint(x: posDic["X"] as! CGFloat, y: posDic["Y"] as! CGFloat)

    }
     //MARK: - METHODS
    override init(){

        super.init()
      print(otherComponents())
      
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

