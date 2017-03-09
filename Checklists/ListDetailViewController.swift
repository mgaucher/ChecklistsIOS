//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by iem on 02/03/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController ,UITextFieldDelegate{
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var Cancel: UIBarButtonItem!
    @IBOutlet weak var Done: UIBarButtonItem!
    var editItem : Checklist?
    
    
    weak var delegate:ListDetailViewControllerDelegate?
      @IBAction func btnCancel() {
        delegate?.listDetailViewControllerDidCancel(controller: self)
    }
    @IBAction func btnDone() {
        if(editItem?.name != nil)
        {
            editItem?.name = textField.text!
            delegate?.listDetailViewController(controller: self, didFinishEditingItem: editItem!);
        }
        else{
            delegate?.listDetailViewController(controller: self,didFinishAddingItem: Checklist(name : "test"))
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        textField.text = editItem?.name
        textField.becomeFirstResponder()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(editItem?.name != nil)
        {
            self.navigationItem.title = "Edit Text"
        }
        else
        {
            self.navigationItem.title  = "Add Text"
        }
        textField.text = editItem?.name
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
protocol ListDetailViewControllerDelegate : class {
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingItem item: Checklist)
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingItem item: Checklist);
    
}

