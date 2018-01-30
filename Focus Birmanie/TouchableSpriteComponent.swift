//  Created by Ben Hutton on 19/12/2015.
//  Copyright © 2015 Ben Hutton. All rights reserved.
//

import GameplayKit
import SpriteKit

class TouchableSpriteComponent: GKComponent {
    var paramFunc: Dictionary<String, AnyObject>?
  //  var entityTouched: ()->Void;
    var entityTouched: (Dictionary<String, AnyObject>)->Void;
    
    init(f:@escaping (Dictionary<String, AnyObject>) -> Void) {
      
        self.entityTouched = f
          super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    override func deallocate(){
        print("touchableSpriteComponent deallocate")
        paramFunc = nil
        
        
    }
    func callFunction(param p_param: Dictionary<String, AnyObject> = ["none":0 as AnyObject]) {
        paramFunc = p_param
        self.entityTouched(paramFunc!)
    }
    
}
