//
//  ChecklistItem.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class ChecklistItem: NSObject {
    
    var text : String
    var checked : Bool
    
   
    
   
    init( text: String,checked: Bool = false){
        self.text = text
        self.checked = checked;
    }

    
   
    

}
