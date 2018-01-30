
import Foundation
import  GameKit

extension SKNode
{
  
    var user_data : NSMutableDictionary
    {
        get{
            guard (userData != nil)else{
                return NSMutableDictionary()
            }
            return userData!
        }
        set{
         
            if  (userData ==  nil){
             userData = NSMutableDictionary()
            }else{
            let data = NSMutableDictionary()
            data.setDictionary(userData as! [AnyHashable : Any])
            userData = NSMutableDictionary()
            userData? = data
            }

        }
        }
}

