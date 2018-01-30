//
//  Parser.swift
//  Focus Birmanie
//
//  Created by Laurent on 14/02/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//

import Foundation
import UIKit
/**
 Call this function to grok some globs.
 */
struct Parser {
    
    static func valueOf(variableName: String, contentBy param:Dictionary<String, AnyObject>)->AnyObject{
        
        switch variableName{
        case "align":
            if let align = param["align"] as? Int
            {
                return (align as AnyObject?)!
            }
        case "bold":
            if let bold = param["bold"] as? Bool
            {
                return (bold as AnyObject?)!
            }
        case "color":
            if let color = param["color"] as? String
            {
                return (color as AnyObject?)!
            }
        case "fontSize":
            if let fontSize = param["fontSize"] as? Int
            {
                    return (fontSize as AnyObject?)!
            }
        case "fontName":
            if let fontName = param["fontName"] as? String
            {
                return (fontName as AnyObject?)!
            }
        case "name":
            if let name = param["name"] as? String
            {
                return (name as AnyObject?)!
            }
        case "CSEE":
            if let csee = param["CSEE"] as? Int
            {
                return (csee as AnyObject?)!
            }
        case "position":
            if let pos = param["position"] as? Dictionary<String,CGFloat>
            {
                return (CGPoint(x: pos["X"]!,y:pos["Y"]!) as AnyObject?)!
            }
        case "size":
            if let size = param["size"] as? Dictionary<String,CGFloat>
            {
                return (CGSize(width:size["width"]!,height:size["height"]!) as AnyObject?)!
            }
        case "texture":
            if let texture = param["texture"] as? String
            {
                return (texture as AnyObject?)!
            }
        case "txt":
            if let txt = param["txt"] as? String
            {
                return (txt as AnyObject?)!
            }
        case "zPosition":
            if let zPos =  param["zPosition"] as? Int
            {
             return (zPos as AnyObject?)!
            }
        case "leading":
            if let leading =  param["leading"] as? Int
            {
                return (leading as AnyObject?)!
            }
         default :
            return (paramDefault[variableName] as AnyObject?)!
        }
      return (paramDefault[variableName] as AnyObject?)!
    }
    
}
