//
//  CONSTANTS.swift
//  Focus Birmanie
//
//  Created by Georgia Leguem on 26/09/2016.
//  Copyright © 2016 appedufun. All rights reserved.
//

import Foundation
import SpriteKit
var previousScene:GameScenes?
var initPosCamera : CGPoint?
private var _GUIDE_DATA = ["name":"guide" as AnyObject,"pageNumber":0 as AnyObject]
var GUIDE_DATA : Dictionary<String,AnyObject>?{
    get{
        return _GUIDE_DATA
    }
    set{
        if(newValue?.count != 0){
            _GUIDE_DATA = (newValue)!
        }else{
            _GUIDE_DATA = ["name":"guide" as AnyObject,"pageNumber":0 as AnyObject]
        }
    }
}
let MIN_CSE_FOR_GO = 60
// MARK:FILES
let DOCUMENTS_DIRECTORY: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//MARK: PDF
enum DocumentName: String {
    case guide
   
    func nameWithExtension() -> String {
        return (self.rawValue as NSString).appendingPathExtension("pdf")!
    }
    
    static func allDocuments() -> [DocumentName] {
        return [guide]
    }
}
//MARK:TRANSITIONS
    let LONG_FLIP_HORIZONTAL = SKTransition.flipHorizontal(withDuration: 3)
    let SHORT_FLIP_HORIZONTAL = SKTransition.flipHorizontal(withDuration: 1.5)
    let LONG_CROSS_FADE = SKTransition.crossFade(withDuration: 1.5)
    let SHORT_CROSS_FADE = SKTransition.crossFade(withDuration: 0.5)
    let SHORT_OPEN_DOOR_VERTICAL = SKTransition.doorsOpenHorizontal(withDuration: 1.5)
    let LONG_OPEN_DOOR_VERTICAL = SKTransition.doorsOpenHorizontal(withDuration: 2.5)

enum gestureType:String{
    case PAN = "pan"
    case PINCH = "pinch"
    case ROTATION = "rotation"
    case SWIPE = "swipe"
    case LONG_PRESS = "longPress"
}


enum pages_name:String {
    
    case ACCUEIL = "Accueil"
    case AEROPORT = "Aeroport"
    case CQC = "CqcScene"
    case GUESTHOUSE = "GuestHouse"
    case PDF_SCENE = "PDFScene"
    case HOTEL = "Hotel"
    case BAG = "BagScene"
    case RANGOON = "Rangoon"
    case MON_ET_KAREN = "MonEtKaren"
    case MAP = "MapScene"
    case TEA_HOUSE = "TeaHouse"
    case SHAN_ET_LOIKAN = "ShanEtLoikaw"
    case LE_NORD = "LeNord"
    case ARAKAN = "Arakan"
    case MANDALAY = "Mandalay"
    case BAGAN = "Bagan"

    case PREVIOUS_PAGE = "__prev"
}

enum load_action:String {
    case BAGAGES    = "bagages"
    case BANK = "bank"
    case CITY_JETTY = "city_jetty"
    case PANO_VERICAL_TRADER = "panoVerticalTrader"
    case WELCOME = "welcome"
    case FLY_AWAY = "flyAway"
    case TAXI_ELEPHANT = "taxiElephants"
    case TAXIS_AEROPORT    = "taxisAeroport"
    case TAXIS_PAGODES    = "taxisPagodes"
}
enum type_action:String {
    
    case ADD_TO_BAG = "addToBag"
    case CHANGE_SEQUENCE = "changeSequence"
    case CHANGE_PAGE = "changePage"
    case CLOSE_WINDOW = "closeWindow"
    case GUIDE_LOAD_URL = "guideLoadUrl"
    case DEAL_AND_MOVE = "dealAndMove"
    case PLAY_SLIDE = "playSlide"
    case ZOOM_IN = "zoomIn"
    case LOAD_SLIDE_CONSOLE = "loadSlideConsole"
    case CLOSE_CONSOLE = "closeConsole"
    case LAUNCH_SLIDER = "launchSlider"
    case OPEN_CQC = "openCqc"
    case CLOSE_CQC = "closeCqc"
    case OPEN_RAW_PDF = "openRawPdf"

}
enum state:String {
    case IN_PAGE = "inPage"
    case IN_GUIDE = "inGuide"
    case IN_MAP = "inMap"
    case IN_BAG = "inBag"
}
enum entityName:String {
    case OBJECT_ENTITY = "ObjectEntity"
    case BUTTON = "ButtonEntitie"
    case TEXT_ENTITY = "TextEntity"
    case IMAGE_ENTITY = "ImageEntity"
    case MESSAGE_ENTITY = "MessageEntity"
    case EMITTER_ENTITY = "EmitterEntity"
    case SLIDER_ENTITY = "SliderEntity"
}
enum consoleAnimations:String {
    case EASY_IN = "easyIn"
    case UP_TO_DOWN = "upToDown"
    case DOWN_TO_UP = "downToUp"
    }
//MARK: Les Notifications
enum notification:String {

    case ADD_GESTURE = "addGesture"
    case CHANGE_STATE = "changeState"
    case REMOVE_ENTITY = "removeMaterialEntity"
    
//MARK: --> Bag
    case VIEW_BAG = "viewBag"
    case HIDE_BAG = "hideBag"
    
    case ADD_TO_BAG = "addToBag"
    case REMOVE_FROM_BAG = "removeFromBag"
    case BAG_CHANGED = "bagChanged"
    case BAG_IS_EMPTY = "bagIsEmpty"
 
//MARK: --> Money / Wallet / Paid ....
    case EARN = "earn"
    case PAID = "paid"
    case WALLET_CHANGE = "walletChange"
 
    
//MARK: --> CSEE
    case MAJ_CSEE = "majCsee"
//MARK: --> Pages / Sequences
    case CHANGE_SEQUENCE = "changeSequence"
    case CHANGE_PAGE = "changePage"
   
//MARK: --> Camera
    case SCALE_CAMERA = "scaleCamera"
    case MOVE_CAMERA = "moveCamera"
//MARK: --> RAW PDF
    case OPEN_RAW_PDF = "openRawPdf"
    case CLOSE_RAW_PDF = "closeRawPdf"
//MARK: --> Guide
    case OPEN_GUIDE = "openGuide"
    case CLOSE_GUIDE = "closeGuide"
//MARK: --> C'est quoi ca
    case OPEN_CQC = "openCqc"
    case CLOSE_CQC = "closeCqc"
    case VALIDATION_CQC = "cqcValidation"
//MARK: --> Map
    case VIEW_MAP = "viewMap"
    case HIDE_MAP = "hideMap"
    
//MARK: --> HYSTORY
    case UPDATE_HISTORY = "updateHistory"
    case UPDATE_ZOOM_BTN = "unselectZoomBtn"
    
//MARK: --> Console
    case LOAD_CONSOLE_DATA = "loadConsoleData"
    case LOAD_SLIDE_CONSOLE = "loadSlideConsole"
    case OPEN_CONSOLE = "openConsole"
    case CLOSE_CONSOLE = "closeConsole"
    case WRITE_TO_CONSOLE = "writeToConsole"
    case GET_CONSOLE = "getConsole"
    case OBJ_CONSOLE = "objConsole"
    }
let paramDefault = [
    "align": 1,
    "bold": false,
    "color":"black",
    "CSEE": 0,
    "fontSize":20,
    "fontName":"Cuprum",
    "id":"",
    "name": "unknow",
    "position": CGPoint(x: 0, y: 0),
    "size":CGSize(width: 5, height: 5),
    "texture": "trans",
     "txt": "",
    "zPosition":10,
    "leading":20
    ] as [String : Any]
    
    let ROOT_URL = "http://www.focusBirmanie.org/"
    var SCALE_MODE = false
    var UNSCALE_MODE = false

