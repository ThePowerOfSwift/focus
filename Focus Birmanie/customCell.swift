//
//  customCell.swift
//  Focus Birmanie
//
//  Created by Georgia Leguem on 23/01/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet  var name: UILabel!
    @IBOutlet  var img: UIImageView!
    var _imageName = "";
    var _labelText = ""
    private let confirmationClass: AnyClass = NSClassFromString("UITableViewCellDeleteConfirmationView")!

    var label:String{
        get{
          return _labelText
        }
        set{
         _labelText = newValue
        name.text = newValue
        }
    }
    var imageName:String{
        get{
            return _imageName
        }
        set{
            _imageName = newValue
            img.image = UIImage(named: newValue )
        }
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
