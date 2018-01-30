import UIKit

class CqcManager {
    private var _container : UIView?
    private var _num_quiz = -1
    private var _quizData: Dictionary<String,AnyObject>?
    
    var choice1_btn : UIButton?
    var choice2_btn : UIButton?
    var valid_btn : UIButton?
    var choice_sel_id : Int?
   
    private var _quiz_num : Int = -1
    private var quiz_num : Int{
        get{
            guard  _PDF_DATA!["id"] != nil else{
                return -1
            }
            return _PDF_DATA!["id"] as! Int
        }
        
    }
     var is_close: Bool{
        get{
            let answer:Int = _quizData!["answer"] as! Int
            if  answer < 0  {
                return false
            }
            return true
        }
        
    }
    private var goodRep : Int{
        get{
            guard  _quizData!["goodRep"] != nil else{
                return -1
            }
            return _quizData!["goodRep"] as! Int
        }
       
    }
    private var _PDF_DATA: Dictionary<String,AnyObject>?
    init(cdcView:UIView,data: Dictionary<String,AnyObject>?){
        _PDF_DATA = data
        _container = cdcView
        _quizData = pl?.cqc[quiz_num]
        initBtn()
        if(is_close){
         
            selectItem((_quizData!["answer"] as? Int)! + 1)
        }else{
        choice_sel_id = nil
        }
        
 
    }
    func initBtn(){
        for  btn in (_container?.subviews)!{
            if (btn.tag == 1){
                choice1_btn = btn as? UIButton
                choice1_btn?.setTitle(_quizData?["choice1"] as? String, for: .normal)
                choice1_btn?.isSelected = false
            }else if(btn.tag == 2){
                choice2_btn = btn as? UIButton
                choice2_btn?.setTitle(_quizData?["choice2"] as? String, for: .normal)
                
                choice2_btn?.isSelected = false
            }else if(btn.tag == 3){
                valid_btn = btn as? UIButton
                if( is_close){
                valid_btn?.setTitle("fermer", for: .normal)
                }
              
            }
        }
    }
    func selectItem(_ num:Int){
         //choice1_btn?.isSelected = false
         //choice2_btn?.isSelected = false
        
        if num == 1 && !(choice1_btn?.isSelected)! {
            soundManager.playSoundEffect(BELL)
            choice2_btn?.isSelected = false
            choice1_btn?.isSelected = true
            choice_sel_id = 0
        }else if num == 2 && !(choice2_btn?.isSelected)! {
            soundManager.playSoundEffect(BELL)
            choice1_btn?.isSelected = false
            choice2_btn?.isSelected = true
            choice_sel_id = 1
        }
    }
    func valid()->Bool{
        if(!is_close){
        guard choice_sel_id != nil else{
            return false
        }
        _quizData!["answer"] = choice_sel_id as AnyObject
        pl?.cqc[quiz_num] = _quizData!
        if (goodRep == choice_sel_id){
            
            return true
        }
        return false
        }else{
           return false
        }
    }
}
