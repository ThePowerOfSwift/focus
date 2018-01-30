//
//  PdfManager.swift
//  Focus Birmanie
//
//  Created by Georgia Leguem on 28/12/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//

import Foundation
import UIKit
import PDFKit

protocol DocumentViewControllerDelegate {
    func didSaveDocument()
}
class PdfManager{
    let pdfView:PDFView!
    var pdfDocument:PDFDocument?
    var delegate: DocumentViewControllerDelegate?

    private  var _pdfPageNumber:Int = 0
    enum _displayMode:String{
        case singlePage
        case singlePageContinuous
        case twoUp
        case twoUpContinuous
        
        func mode()->PDFDisplayMode{
            switch self {
            case .singlePageContinuous:
                return PDFDisplayMode.singlePageContinuous
            case .singlePage:
                return PDFDisplayMode.singlePage
            case .twoUp:
                return PDFDisplayMode.twoUp
            case .twoUpContinuous:
                return PDFDisplayMode.twoUpContinuous
            }
        }
    }
    var display:String{
        get{
            guard PDF_DATA!["mode"] != nil else{
                print ("Pas de paramètre pageNumber pour ce guide")
                return "singlePage"
            }
            return PDF_DATA!["mode"] as! String
        }
    }
    
    var pdfPageNumber:Int{
        get {
            return _pdfPageNumber
        }
        set{
            if newValue < (pdfDocument?.pageCount)!{
                _pdfPageNumber = newValue
            }else{
                _pdfPageNumber = 0
            }
        }
    }
 var PDF_DATA: Dictionary<String,AnyObject>?
// MARK:FILES
  let DOCUMENTS_DIRECTORY: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//MARK: PDF Name
    enum DocumentName: String {
        case guide
        case guide2
        case cqcRangoon
        case pm_rangoon1
        func nameWithExtension() -> String {
            return (self.rawValue as NSString).appendingPathExtension("pdf")!
        }
        
    static func allDocuments() -> [DocumentName] {
            return [guide,
                    guide2,
                    cqcRangoon,
                    pm_rangoon1
                    ]
        }
    }
    init(p_pdfView:PDFView!){
        
     pdfView = p_pdfView
       
     preloadDocuments()
    }
    private func preloadDocuments() {
        for document in DocumentName.allDocuments(){
            let documentPath = DOCUMENTS_DIRECTORY.appending("/\(document.nameWithExtension())")
            if !FileManager.default.fileExists(atPath: documentPath) {
                guard let pdfPath =   Bundle.main.path(forResource: document.rawValue, ofType: "pdf"),
                    let pdfDocument = PDFDocument(url: URL(fileURLWithPath: pdfPath)) else { continue }
                pdfDocument.write(toFile: documentPath)
              
            }
        }
    }

    func initPdf()->Bool{
        return loadingPdfDocument()
        
    }
    func loadingPdfDocument()->Bool{
        guard PDF_DATA!["namePdf"] != nil else{
            return false
        }
       guard  let guideName = DocumentName(rawValue: PDF_DATA!["namePdf"] as! String) else{
        
            return false
        }
    let document = guideName.rawValue
    let  documentPath = DOCUMENTS_DIRECTORY.appending("/"+document)
    if !FileManager.default.fileExists(atPath: documentPath) {
        guard let pdfPath =   Bundle.main.path(forResource: document, ofType: "pdf")
        else { return false }
    self.pdfDocument = PDFDocument(url: URL(fileURLWithPath: pdfPath))
        self.pdfDocument?.delegate = self as? PDFDocumentDelegate
    pdfDocument?.write(toFile: pdfPath)
    return true
        }
    return false
    }
//MARK:** RAW PDF  (c'est quoi Ca ?)
    func openRawPdf() {
        pdfView.frame.size = CGSize(width:1024, height:768)
        pdfView.superview?.frame.origin.y = 0
        pdfView.superview?.frame.origin.x = 0
        pdfView.isUserInteractionEnabled = true
        openPDF()
    }
    func closeRawPdf() {
        pdfView.superview?.frame.origin = CGPoint(x:0,y:1000)
    }
//MARK:** CQC  (c'est quoi Ca ?)
    func openCqc() {
     
        pdfView.superview?.frame.origin.y = 0
        pdfView.superview?.frame.origin.x = 0
        pdfView.isUserInteractionEnabled = false
        openPDF()
    }
    func closeCqc() {
        pdfView.superview?.frame.origin = CGPoint(x:0,y:1000)
    }
//MARK:** GUIDE
    func openGuide() {
        pdfView.isUserInteractionEnabled = true
        pdfView.superview?.frame.origin.y = 70
        pdfView.superview?.frame.origin.x = 0
        pdfView.minScaleFactor = 0.1
        pdfView.autoScales = false
        pdfView.isUserInteractionEnabled = true
        PDF_DATA = (pl?.PdfData())!
        openPDF()
            }
func closeGuide(note: NSNotification) {
        pdfView.superview?.frame.origin = CGPoint(x:0,y:1000)
    }
//MARK: common PDF methods
    func openPDF() {

        if(initPdf()){
            
            let dm = _displayMode(rawValue: display)
            self.pdfView.displayMode = dm!.mode()
            
            
           // self.pdfView.autoScales = true
          //  self.pdfView.minScaleFactor = 1.0
            self.pdfView.document = pdfDocument
            
            guard PDF_DATA!["pageNumber"] != nil else{
                print ("Pas de paramètre pageNumber pour ce guide")
                return
            }
            pdfPageNumber = PDF_DATA!["pageNumber"] as! Int
            self.pdfView.go(to: (pdfDocument?.page(at:pdfPageNumber))!)
         
        }
    }

   


}
