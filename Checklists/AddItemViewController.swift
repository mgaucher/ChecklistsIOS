//
//  AddItemViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController , UITextFieldDelegate{
   
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var Cancel: UIBarButtonItem!
    @IBOutlet weak var Done: UIBarButtonItem!
    var editItem : ChecklistItem?
    
    
    weak var delegate:AddItemViewControllerDelegate?
    @IBAction func btnCancel() {
        delegate?.addItemViewControllerDidCancel(controller: self)
    }
    @IBAction func btnDone() {
        if(editItem?.text != nil)
        {
            editItem?.text = textField.text!
            delegate?.addItemViewController(controller: self, didFinishEditingItem: editItem!);
        }
        else{
            delegate?.addItemViewController(controller: self,didFinishAddingItem: ChecklistItem(text : "test"))
        }
        print(textField.text)
    }
    override func viewWillAppear(_ animated: Bool) {
        textField.text = editItem?.text
        textField.becomeFirstResponder()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = editItem?.text
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
       let beforeText: NSString = NSString(string: textField.text!)

        let afterText: NSString = beforeText.replacingCharacters(in: range, with: string) as NSString
            
        if afterText.length > 0 {
            Done.isEnabled = true
        } else {
            Done.isEnabled = false
        }
        
        return true
    }
}

protocol AddItemViewControllerDelegate : class {
    
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    func addItemViewController(controller: AddItemViewController, didFinishEditingItem item: ChecklistItem);

}
