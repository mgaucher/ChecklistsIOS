//
//  ChecklistItem.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class ChecklistItem: NSObject ,NSCoding{
    
    var text : String
    var checked : Bool
    
    init( text: String,checked: Bool = false){
        self.text = text
        self.checked = checked;
    }

    required convenience init?(coder decoder: NSCoder) {
        guard let text = decoder.decodeObject(forKey: "text") as? String,
            let checked = decoder.decodeObject(forKey: "checked") as? Bool
            else { return nil }
        
        self.init(
            text: text,
            checked: checked
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.text, forKey: "text")
        coder.encode(self.checked, forKey: "checked")
       
    }
    

}
