//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController , UITextFieldDelegate{
   
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var Cancel: UIBarButtonItem!
    @IBOutlet weak var Done: UIBarButtonItem!
    var editItem : ChecklistItem?
    
    
    weak var delegate:ItemDetailViewControllerDelegate?
    @IBAction func btnCancel() {
        delegate?.itemDetailViewControllerDidCancel(controller: self)
    }
    @IBAction func btnDone() {
        if(editItem?.text != nil)
        {
            editItem?.text = textField.text!
            delegate?.itemDetailViewController(controller: self, didFinishEditingItem: editItem!);
        }
        else{
            delegate?.itemDetailViewController(controller: self,didFinishAddingItem: ChecklistItem(text : "test"))
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        textField.text = editItem?.text
        textField.becomeFirstResponder()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(editItem?.text != nil)
        {
            self.navigationItem.title = "Edit Text"
        }
        else
        {
            self.navigationItem.title  = "Add Text"
        }
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

protocol ItemDetailViewControllerDelegate : class {
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem);

}
