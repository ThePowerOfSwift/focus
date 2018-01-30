//
//  SpriteComponent.swift
//  Focus Birmanie - ConsoleComponent
//
//  Created by Georgia Leguem on 26/09/2016.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//
import UIKit
import SpriteKit
import  GameplayKit

class ConsoleComponent:GKComponent{
    let _nc : NotificationCenter = NotificationCenter.default

    var node: SKSpriteNode = SKSpriteNode()
    let nc : NotificationCenter = NotificationCenter.default
    var _param: Dictionary<String, AnyObject>?
    var _windowWith : Int?
    var _windowHeight : Int?
    let _windowTitle : String?
    let _windowName : String?
    var _parent_node = SKSpriteNode()
 //   var _windowPositition = 1 //1 : Left 2:Right
    var _windowOpen = false
    var _windowButtons:[Dictionary<String, AnyObject>?]?
    var _imageNode:String?
    private var _positionTitre:CGPoint = CGPoint(x:0,y:0)
    private var bordure: SKShapeNode?
    init(param : Dictionary<String, AnyObject>){
        _param = param
      
        let size = _param?["size"] as! Dictionary<String, AnyObject>
        _windowWith = size["width"] as? Int
        _windowHeight = size["height"] as? Int
        _windowTitle = (_param?["titre"] as! String) + "window"
        _windowName = (_param?["name"] as! String)
   
        _windowButtons = _param?["buttons"] as? [Dictionary<String, AnyObject>]
        
        super.init()
        // addListener()
        
    }
    deinit  {
        print("ConsoleComponent deinit name : \(node.name)")
        removeChild(node: node)
       
        
    }
    //MARK LISTENER
    /*func addListener(){
        _nc.addObserver(self,
                                        selector: #selector(repConsole),
                                        name : NSNotification.Name(rawValue: notification.OBJ_CONSOLE.rawValue),
                                        object : nil)
    }
    @objc func repConsole(notification:NSNotification){
       guard (notification.userInfo?["console"] as! ConsoleCamera) != nil else{
            return
        }
        let console = notification.userInfo!["console"] as! ConsoleCamera
       
    }
 */
    // MARK: CREATION ET INITISATION DE LA FENETRE
  
    func createWindow(in p_node:SKSpriteNode){
       // sendNotification(notification.GET_CONSOLE.rawValue, [:])
        _parent_node = p_node
        if !_windowOpen  {
            
            addWindow(p_node:p_node)
            }
    }
  
    func addWindow(p_node:SKSpriteNode){
        
        _imageNode = (pl?.touchedNodeData["texture"] as! String)
        
        node.size.width = CGFloat(_windowWith!)
        node.size.height = CGFloat(_windowHeight!)
        node.name = _windowName

        removeChild(node: p_node)
        makeBorder()
        createTitre(node)
        
        createContentText(node)
        createImg(node)
        createButton()
        p_node.zPosition =  100
        sendNotification(notification.WRITE_TO_CONSOLE.rawValue, ["node":node,"offsetValue":"main"] as Dictionary<String, AnyObject>)
     
        _windowOpen = false
    }
   
  // MARK: Creation du titre
    
    func createTitre(_ p_node:SKSpriteNode){
      //  let template = Template()
        let param = template.templates["consoleObject_title"]!
        let txt = _param?["titre"] as! String
        let label = SKLabelNode(text: txt)
        if param["bold"] as! Bool {
            label.fontName = "Cuprum-Bold"
        }else{
            label.fontName = "Cuprum"
        }
        label.fontColor = UIColor(name:param["color"] as! String)
        label.name = "title_lab"
        label.text = (_param?["titre"] as! String)
        label.position.y = (p_node.size.height/2) - 30
        
        _positionTitre = label.position
        
        bordure?.addChild(label)
     
    }
    
    func makeBorder(){
    
        let width = _windowWith
        let height = _windowHeight
        bordure = SKShapeNode()
        bordure?.path = UIBezierPath(roundedRect: CGRect(x: -(width!/2), y:  -(height!/2),width:width!, height:height!), cornerRadius: 20).cgPath
        bordure?.strokeColor = UIColor.lightGray
        bordure?.lineWidth = 0

    
        bordure?.glowWidth = 1.8
     
        bordure?.name = "bordure"
        node.removeAllChildren()
        node.addChild((bordure)!)
        
    }
    func createImg(_ p_node:SKSpriteNode){
        let bordureHeight = Double((bordure?.frame.size.height)!)
        
        let bordureWidth = Double((bordure?.frame.size.width)!)
        
        let imgNode = SKSpriteNode(imageNamed: _imageNode!)
        imgNode.size = CGSize(width:bordureHeight/2,height:bordureHeight/2)
        var imgPosX = -1*(bordureWidth/2)
            imgPosX += Double(imgNode.size.width / 2) + 30.0
        var imgPosY = Double(bordureHeight/2)
            imgPosY -= Double(imgNode.size.height / 2 ) + 30.0
        
        imgNode.position = CGPoint(x:imgPosX ,y:imgPosY )
       bordure?.addChild(imgNode)
    }
    func createContentText(_ p_node:SKSpriteNode){
        
        _param?["template"] = "consoleObject_content" as AnyObject
        _param = template.build(param: _param!)
        let align = Parser.valueOf(variableName: "align", contentBy: _param!)  as!  Int
        let leading  =  Parser.valueOf(variableName: "leading", contentBy: _param!)  as!  Int
        let color = Parser.valueOf(variableName: "color", contentBy: _param!)  as! String
        let  txt = Parser.valueOf(variableName: "txt", contentBy: _param!)  as! String
        
        
        let fontSize = CGFloat( Parser.valueOf(variableName: "fontSize", contentBy: _param!)  as!  Int)
        let fontName = String( Parser.valueOf(variableName: "fontName", contentBy: _param!)  as!  String)
       let  content = SKMultilineLabel(
            text: txt,
            labelWidth:500,
            pos: CGPoint(x:30,y:0),
            fontName:fontName,
            fontSize: fontSize,
            fontColor : UIColor(name:color)! ,
            leading : leading,
            alignement : SKLabelHorizontalAlignmentMode(rawValue: align)!
        )
        
         let pos = CGPoint(
            x:0,
            y: 15
        )
       
        content.position = pos
        content.alignment = .left
        
         content.zPosition =  100
        
        
        
     bordure?.addChild(content)
        
    

        
    }
    func createButton(){
        if _windowButtons != nil{
            let pos_btn = CGPoint(x:0,y:-60)
            let size_btn = CGSize(width: 180, height: 35)
            for btn in _windowButtons!{
               
                let pos = btn?["position"] as? Dictionary<String,AnyObject>?
                let size = btn?["size"] as! Dictionary<String,AnyObject>?
               
                let param = btn?["param"] as! Dictionary<String,AnyObject>?
                let iconName = btn?["iconName"] as! String
                let label = btn?["label"] as! String
              let btnSize = CGSize(width: CGFloat(size!["width"] as! Int), height: CGFloat(size!["height"] as! Int))
                
                let bouton = ButtonNode(iconName: iconName , text: label,buttonSize: size_btn, onButtonPress: buttonPress)
                
                bouton.paramFunc = param
             //   bouton.position.x  = CGFloat((pos??["X"] as? Int)!)
             //   bouton.position.y  = CGFloat(pos!?["Y"] as! Int)
                bouton.position = pos_btn
                bouton.zPosition =  10
                
                node.addChild(bouton)
            }
        }
    }
      required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    func close(){
       //test if the window is open
         node.parent?.zPosition = 1
        if(_windowOpen == true){
                
                // replace the parent node in its initial position
                let posParent = _param?["parent_position"] as! Dictionary<String, CGFloat>
          
                let pointPos = CGPoint(x: posParent["X"]!, y: posParent["Y"]!)
                node.parent?.position = pointPos
                // remove the window
           
                node.parent?.removeAllChildren()
           
                _windowOpen = false
            
        }
        
    }
    func position()->Int{
        return _param!["position"] as! Int
    }
    
    
 // MARK: HANDLER BOUTON
    func buttonPress(param:Dictionary<String, AnyObject>){
        SCALE_MODE = false
        guard let action = param["action"] else {
            debugPrint("Ops, no action...")
            return
        }
        if let buttonAction = type_action(rawValue: action as! String){
             sendNotification(action as! String,param)
        switch buttonAction  {
        case .CHANGE_SEQUENCE:
            break
         //  changeSequence(param: param)
        case .CHANGE_PAGE:
             changePage(param: param)
          
        case .CLOSE_WINDOW:
          closeWindow()
        case .ADD_TO_BAG:
            _parent_node.isHidden = true
            player?.addToBag()
     // sendNotification(notification.CLOSE_CONSOLE.rawValue, [:])
       // closeWindow()
      
        case .GUIDE_LOAD_URL:
            guideLoadUrl(param: param)
        case .DEAL_AND_MOVE:
            break
        default :
            return
           
                }
        }
 
          }
    func closeWindow(){
  /*      let parent_position = _param?["parent_position"] as? Dictionary<String, AnyObject>
        node.parent?.position.x = parent_position!["X"] as! CGFloat
        node.parent?.position.y = parent_position!["Y"] as! CGFloat
        
        close()
       
        sendNotification(
            notification.SCALE_CAMERA.rawValue,
            ["ratio":3 as AnyObject,"duration":0.5 as AnyObject]
        )
 */
    }
    func guideLoadUrl(param:Dictionary<String, AnyObject>){
        guard let url = param["url"]  else {
            debugPrint("Ops, no action...")
            return
        }
       closeWindow()
        
        
        sendNotification(
            notification.CHANGE_STATE.rawValue,
            ["state": state.IN_GUIDE as AnyObject]
        )
        
        sendNotification(
            notification.OPEN_GUIDE.rawValue,
            ["url": url  as AnyObject]
        )
    }
    
    func changeSequence(param:Dictionary<String, AnyObject>){
        
  
        guard let numSequence = param["numSequence"]   else {
            debugPrint("Ops, no numSequence...")
            return
        }
       
        
        let numSeq = (numSequence as! NSString).intValue
        // var notifications: BlockNotification
        nc.post(name: NSNotification.Name(rawValue: notification.CHANGE_SEQUENCE.rawValue) , object: nil, userInfo:  ["numSequence":numSeq ])
    }
    func changePage(param:Dictionary<String, AnyObject>){
 
        guard let pageName = param["pageName"]  else {
            debugPrint("Ops, no pageName...")
            return
        }
       
        
        // var notifications: BlockNotification
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification.CHANGE_PAGE.rawValue) , object: nil, userInfo:  ["pageName":pageName])
    }
}
