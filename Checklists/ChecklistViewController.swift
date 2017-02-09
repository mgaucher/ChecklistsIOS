//
//  ViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController{
    

    var listChecklistItem = [ChecklistItem]()

    @IBAction func addDummyTodo(_ sender: AnyObject) {
        
        listChecklistItem.append(ChecklistItem(text: "add test", checked: false))
        tableView.insertRows(at: [IndexPath(item: listChecklistItem.count-1, section: 0)], with: UITableViewRowAnimation.automatic)

    }
    
   
    required init?(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: dataFileUrl().path) {
            loadChecklistItems()
        } else {
        }
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       // listChecklistItem.append(ChecklistItem(text: "How about beets?"))
       // listChecklistItem.append(ChecklistItem(text: "How about beats?",checked:true))
       // listChecklistItem.append(ChecklistItem(text: "How about bits?"))
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)

 }

        func documentDirectory() -> URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        
        func dataFileUrl() -> URL{
            let docsDir : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            return docsDir.appendingPathComponent("Ckecklists.plist")
        }
   
    
    func saveChecklistItems(){
        NSKeyedArchiver.archiveRootObject(self.listChecklistItem, toFile: self.dataFileUrl().path)
    }
    
    func loadChecklistItems() {
      listChecklistItem =  NSKeyedUnarchiver.unarchiveObject(withFile: self.dataFileUrl().path) as! [ChecklistItem]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return listChecklistItem.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureTextForCell(cell: cell, withItem: listChecklistItem[indexPath.row])
        configureCheckmarkForCell(cell: cell, withItem: listChecklistItem[indexPath.row])
        saveChecklistItems()
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        toggleChecked(number: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
       

    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            listChecklistItem.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
 
    func configureCheckmarkForCell(cell: UITableViewCell, withItem item: ChecklistItem){
        if(item.checked){
            
            cell.viewWithTag(1)?.isHidden = false

        }
        else
        {
            cell.viewWithTag(1)?.isHidden = true
        }
    
    }
    func configureTextForCell(cell: UITableViewCell, withItem item: ChecklistItem){
        let label = cell.viewWithTag(2) as! UILabel
        label.text = item.text
    }
    
    func toggleChecked(number : Int){
        listChecklistItem[number].checked = !listChecklistItem[number].checked
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddItem" {
            let nav = segue.destination as? UINavigationController
            let destination = nav?.topViewController as? ItemDetailViewController
            destination?.delegate = self
        }
        else if segue.identifier == "EditItem"{
            let nav = segue.destination as? UINavigationController
            let destination = nav?.topViewController as? ItemDetailViewController
            let cell = sender as! UITableViewCell
            let i = tableView.indexPath(for: cell)?.row

            destination?.editItem = listChecklistItem[i!]
            destination?.delegate = self

        }
        
    }
    
}

//MARK: - ItemDetailViewControllerDelegate
extension ChecklistViewController :  ItemDetailViewControllerDelegate
{
    func itemDetailViewControllerDidCancel(controller:ItemDetailViewController){
        controller.dismiss(animated: true, completion: nil)
    }
    
    func  itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem){
        listChecklistItem.append(ChecklistItem(text : controller.textField.text!))
        tableView.insertRows(at: [IndexPath(item: listChecklistItem.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
        controller.dismiss(animated: true, completion: nil)
    }
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem){
        let i =  listChecklistItem.index(where:{$0 === item})
        listChecklistItem[i!] = item
        
        tableView.reloadRows(at: [IndexPath(row : i!,section  : 0)], with: UITableViewRowAnimation.automatic)
        controller.dismiss(animated: true, completion: nil)

    }

}

