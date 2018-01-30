//
//  Template.swift
//  Focus Birmanie
//
//  Created by Georgia Leguem on 16/08/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


private var _param: Dictionary<String, AnyObject>?
var param:Dictionary<String, AnyObject>{
    get{
        return _param!
    }
    set {
        _param = newValue
    }
}
var tplName:String?
class Template{
    
    var templates : Dictionary<String,Dictionary<String,AnyObject>> = [:]
    
    var consoleGuide_btn = [String:AnyObject]()
    var consolePresentation_title = [String:AnyObject]()
    var consolePresentation_Stitle = [String:AnyObject]()
    var consolePresentation_content = [String:AnyObject]()
    var consoleObject_title = [String:AnyObject]()
    var consoleObject_content = [String:AnyObject]()
    
    init(){
        
        //MARK:      TEMPLATES
        
        
       
        self.initTpl()
     
    }
    func initTpl(){
       
        var tpl =  [String:AnyObject]()
        //MARK: consoleDefault_title
        tpl.updateValue(0 as AnyObject, forKey: "align")
        tpl.updateValue("default_color" as AnyObject, forKey: "color")
        tpl.updateValue(false as AnyObject, forKey: "bold")
        tpl.updateValue(30 as AnyObject, forKey: "fontSize")
        tpl.updateValue(30 as AnyObject, forKey: "leading")
        tpl.updateValue("trans" as AnyObject, forKey: "texture")
        self.templates.updateValue(tpl,forKey:"consoleDefault_title")

        
        //MARK: consoleDefault_label
      
        tpl.updateValue(1 as AnyObject, forKey: "align")
        tpl.updateValue("black" as AnyObject, forKey: "color")
        tpl.updateValue(false as AnyObject, forKey: "bold")
        tpl.updateValue(25 as AnyObject, forKey: "fontSize")
        tpl.updateValue(25 as AnyObject, forKey: "leading")
        tpl.updateValue("trans" as AnyObject, forKey: "texture")
        self.templates.updateValue(tpl,forKey:"consoleDefault_label")
        
        //MARK: consoleChoice_label
        tpl = templates["consoleDefault_label"]!
        tpl.updateValue(true as AnyObject, forKey: "bold")
        tpl.updateValue("default_color" as AnyObject, forKey: "color")
        tpl.updateValue(20 as AnyObject, forKey: "fontSize")
        tpl.updateValue(20 as AnyObject, forKey: "leading")
        self.templates.updateValue(tpl,forKey:"consoleChoice_label")
        
        //MARK: consolebtnBrown_label
        tpl = templates["consoleDefault_label"]!
        tpl.updateValue(true as AnyObject, forKey: "bold")
        tpl.updateValue(25 as AnyObject, forKey: "fontSize")
        tpl.updateValue(20 as AnyObject, forKey: "leading")
        self.templates.updateValue(tpl,forKey:"consolebtnBrown_label")
        
        //MARK: consolebtnBrown_label
        tpl.updateValue(1 as AnyObject, forKey: "align")
        tpl.updateValue("brown" as AnyObject, forKey: "color")
        tpl.updateValue(true as AnyObject, forKey: "bold")
        tpl.updateValue(25 as AnyObject, forKey: "fontSize")
        tpl.updateValue(20 as AnyObject, forKey: "leading")
        tpl.updateValue("trans" as AnyObject, forKey: "texture")
        self.templates.updateValue(tpl,forKey:"consolebtnBrown_label")

        //MARK: consoletextInfo_label
        tpl.updateValue(1 as AnyObject, forKey: "align")
        tpl.updateValue("darkred" as AnyObject, forKey: "color")
        tpl.updateValue(true as AnyObject, forKey: "bold")
        tpl.updateValue(25 as AnyObject, forKey: "fontSize")
        tpl.updateValue(20 as AnyObject, forKey: "leading")
        tpl.updateValue("trans" as AnyObject, forKey: "texture")
        self.templates.updateValue(tpl,forKey:"consoletextInfo_label")
        
        //MARK: consoleNext_btn
        tpl.updateValue("boutonSuivant" as AnyObject, forKey: "texture")
        self.templates.updateValue(tpl,forKey:"consoleNext_btn")
   
        //MARK: brownLinkButton
        tpl.updateValue(1 as AnyObject, forKey: "align")
        tpl.updateValue(1 as AnyObject, forKey: "bold")
        tpl.updateValue("brown" as AnyObject, forKey: "color")
        tpl.updateValue(25 as AnyObject, forKey: "fontSize")
        tpl.updateValue("trans" as AnyObject, forKey: "texture")
        tpl.updateValue(20 as AnyObject, forKey: "leading")
        self.templates.updateValue(tpl,forKey:"brownLinkButton")
        
        //MARK: brown_btn
        tpl.updateValue(0 as AnyObject, forKey: "align")
        tpl.updateValue(1 as AnyObject, forKey: "bold")
        tpl.updateValue("white" as AnyObject, forKey: "color")
        tpl.updateValue("ButtonEntitie" as AnyObject, forKey: "entitie")
        tpl.updateValue(25 as AnyObject, forKey: "fontSize")
        tpl.updateValue(20 as AnyObject, forKey: "leading")
        tpl.updateValue("brownButton" as AnyObject, forKey: "texture")
        self.templates.updateValue(tpl,forKey:"brown_btn")
        
   //MARK: consoleGuide_btn
            
            tpl.updateValue(0 as AnyObject, forKey: "align")
            tpl.updateValue(1 as AnyObject, forKey: "bold")
            tpl.updateValue("default_color" as AnyObject, forKey: "color")
            tpl.updateValue("ButtonEntitie" as AnyObject, forKey: "entitie")
            tpl.updateValue(28 as AnyObject, forKey: "fontSize")
            tpl.updateValue("brownBorderButton" as AnyObject, forKey: "texture")
        self.templates.updateValue(tpl,forKey:"consoleGuide_btn")
        
   //MARK: consolePresentation_title"
            tpl.updateValue(0 as AnyObject, forKey: "align")
            tpl.updateValue("default_color" as AnyObject, forKey: "color")
            tpl.updateValue(false as AnyObject, forKey: "bold")
            tpl.updateValue(35 as AnyObject, forKey: "fontSize")
            tpl.updateValue(30 as AnyObject, forKey: "leading")
            tpl.updateValue("trans" as AnyObject, forKey: "texture")
        self.templates.updateValue(tpl,forKey:"consolePresentation_title")
        //MARK: consolePresentation_title_red"
        tpl = templates["consolePresentation_title"]!
       
        tpl.updateValue("default_color" as AnyObject, forKey: "color")
        tpl.updateValue(30 as AnyObject, forKey: "fontSize")
         tpl.updateValue(30 as AnyObject, forKey: "leading")
        self.templates.updateValue(tpl,forKey:"consolePresentation_title_red")
        
   //MARK: consolePresentation_Stitle
        tpl = templates["consolePresentation_title"]!

            tpl.updateValue(35 as AnyObject, forKey: "fontSize")
            tpl.updateValue(35 as AnyObject, forKey: "leading")
       self.templates.updateValue(tpl,forKey:"consolePresentation_Stitle")
  //MARK:  consolePresentation_content"
            tpl.updateValue(1 as AnyObject, forKey: "align")
            tpl.updateValue("black" as AnyObject, forKey: "color")
            tpl.updateValue(false as AnyObject, forKey: "bold")
            tpl.updateValue(25 as AnyObject, forKey: "fontSize")
            tpl.updateValue(25 as AnyObject, forKey: "leading")
            tpl.updateValue("trans" as AnyObject, forKey: "texture")
        self.templates.updateValue(tpl,forKey:"consolePresentation_content")
   //MARK: consoleObject_title
            tpl.updateValue(0
                as AnyObject, forKey: "align")
            tpl.updateValue("black" as AnyObject, forKey: "color")
            tpl.updateValue(true as AnyObject, forKey: "bold")
            tpl.updateValue(25 as AnyObject, forKey: "fontSize")
            tpl.updateValue(20 as AnyObject, forKey: "leading")
            self.templates.updateValue(tpl,forKey:"consoleObject_title")
       
        //MARK: consoleObject_content
            tpl.updateValue(0 as AnyObject, forKey: "align")
            tpl.updateValue("black" as AnyObject, forKey: "color")
            tpl.updateValue(false as AnyObject, forKey: "bold")
            tpl.updateValue(20 as AnyObject, forKey: "fontSize")
            tpl.updateValue(20 as AnyObject, forKey: "leading")
            tpl.updateValue("trans" as AnyObject, forKey: "texture")
        self.templates.updateValue(tpl,forKey:"consoleObject_content")
        
       
    self.templates.updateValue(tpl,forKey:"consoleDialog_player")
        //MARK: consolePastille
        
        tpl.updateValue("pastilleChoix" as AnyObject, forKey: "texture")
        self.templates.updateValue(tpl,forKey:"pastille_choix")
       
        //MARK: consoleDialog_default
        tpl.updateValue(1 as AnyObject, forKey: "align")
        tpl.updateValue("black" as AnyObject, forKey: "color")
        tpl.updateValue(false as AnyObject, forKey: "bold")
        tpl.updateValue(25 as AnyObject, forKey: "fontSize")
        tpl.updateValue(25 as AnyObject, forKey: "leading")
        tpl.updateValue("trans" as AnyObject, forKey: "texture")
        self.templates.updateValue(tpl,forKey:"consoleDialog_default")
        //MARK: consoleDialog_other
        tpl = self.templates["consoleDialog_default"]!
        tpl.updateValue("dialog_other_color" as AnyObject, forKey: "color")
        self.templates.updateValue(tpl,forKey:"consoleDialog_other")
        //MARK: consoleDialog_player
        tpl = self.templates["consoleDialog_default"]!
        
        self.templates.updateValue(tpl,forKey:"consoleDialog_player")
        //MARK: consoleWarning
        tpl.updateValue(1 as AnyObject, forKey: "align")
        tpl.updateValue("indianred" as AnyObject, forKey: "color")
        tpl.updateValue(true as AnyObject, forKey: "bold")
        tpl.updateValue(25 as AnyObject, forKey: "fontSize")
        tpl.updateValue(30 as AnyObject, forKey: "leading")
        tpl.updateValue("trans" as AnyObject, forKey: "texture")
        self.templates.updateValue(tpl,forKey:"consoleWarning")
  //      default:return
            
   //     }
       
    }
    func build(param p_param:Dictionary<String, AnyObject>)->Dictionary<String, AnyObject>{
        guard ((p_param["template"] as? String) != nil) else{
           
            return p_param
        }
      
        var p = p_param
    
        tplName = p_param["template"] as? String
        let tpl = templates[tplName!]
        for item in tpl! {
          
            p.updateValue(item.value,forKey:item.key)
        }
        return p
        }
    
    
}
