import Foundation
import SpriteKit
import GameplayKit
import SceneKit

//MARK: - extension
public extension GKComponent {
    
   
    @objc func deallocate() {
        print("GKComponent deallocate")
    }
    func removeChild(node:SKNode){
        for c in node.children{
            if ( c.children.count<1){
                c.removeAllActions()
                c.removeFromParent()
                
            }else{
                removeChild(node:c)
            }
        }
    }
    @objc func build(){
        
    }
}
public extension GKEntity {
    
    // swiftlint:disable:next variable_name
    @objc func deallocate() {
        print("EntityManager deallocate")
    }
    func removeChild(node:SKNode){
        for c in node.children{
            if ( c.children.count<1){
                c.removeAllActions()
                c.removeFromParent()
                
            }else{
            removeChild(node:c)
            c.removeAllActions()
            c.removeFromParent()
            }
        }
    }
}
class EntityManager {
//MARK: - property
    
    var entities:Set<GKEntity>? = Set<GKEntity>()
    var modeConsole:Bool? = false
    weak  var console : ConsoleCamera?
    weak var scene: SKScene?
    var _param: Dictionary<String,AnyObject>?
  
    var paramNode: Dictionary<String,AnyObject>?{
    get{
     return _param
    }
    set{
       
        _param = newValue
        
    }
    }
    
    var parentNode:String?{
        
        get{
            if paramNode==nil{
                return nil
            }
            guard let parent = paramNode?["parent"] else{
                return nil
            }
            return parent as? String 
        }
    }
//MARK: - Methods
    
    init(scene: SKScene) {
        self.scene = scene
     
    }
//MARK:  Suppression de managerEntity -
    func dealloc(){
       
        guard entities != nil else {
            print(" --- entityManager --- dealloc abort --- no entities")
            return
        }
        print(" --- entityManager --- dealloc ---")
        for item in entities!{
            remove(entity: item)
        }
        console = nil
        modeConsole = nil
        entities = nil
        _param = nil
        scene = nil
    }
//MARK:  Ajouter une entity
    func add(entity: GKEntity)-> SKSpriteNode{
      
        entities!.insert(entity)
        var node = SKSpriteNode()
         if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node
            {
                if !(modeConsole!){
                    scene?.addChild(spriteNode)
                }else{
                    node = spriteNode
                }
          
        
        }
        return node
    }
    
// MARK: REMOVE
    func removeAllEntities(){
        for item in entities!{
            remove(entity: item)
        }
    }
    func remove(entity: GKEntity) {
        entity.deallocate()
        
        if var spriteNode:SKSpriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            
            spriteNode.removeAllActions()
            spriteNode.removeAllChildren()
            spriteNode.removeFromParent()
           // spriteNode = nil
        }
        entities!.remove(entity)
        
    }
    func createEntitieByName(p_name: String,p_param: Dictionary<String,AnyObject>)-> SKSpriteNode{
        let tmp = p_param
      paramNode = template.build(param: tmp)
     
        var returnNode = SKSpriteNode()
        switch  p_name {
        case entityName.OBJECT_ENTITY.rawValue:
            print(p_param["id"] )
           guard let node = scene?.childNode(withName: p_param["id"] as! String)else{
                return returnNode
                }
            let entitie = ObjectEntity(param: p_param,node:node as! SKSpriteNode)
        returnNode = add(entity: entitie)
            
        case entityName.IMAGE_ENTITY.rawValue:
            let entitie:ImageEntity = ImageEntity(param: p_param)
            returnNode =   add(entity: entitie)

        case entityName.MESSAGE_ENTITY.rawValue:
            let entitie:MessageEntity = MessageEntity(param: p_param)
         returnNode =   add(entity: entitie)
        case entityName.BUTTON.rawValue:
            let entitie = ButtonEntity(param: p_param)
           
        returnNode = add(entity: entitie)
        case entityName.TEXT_ENTITY.rawValue:
            let entitie = TextEntity(param: p_param)
         returnNode =   add(entity: entitie)
        case entityName.EMITTER_ENTITY.rawValue:
            guard let node = scene?.childNode(withName: p_param["id"] as! String)else{
                return SKSpriteNode()
            }
            
            let entitie = EmitterEntity(param: p_param,node:node as! SKSpriteNode)
           
           returnNode = add(entity: entitie)
       
        
        case entityName.SLIDER_ENTITY.rawValue:
            let entitie = SliderEntity(param: p_param) 
           
            returnNode =   add(entity: entitie)
             entitie.build()
        default:
             returnNode = SKSpriteNode()
           
        }
      return returnNode
    }
}
