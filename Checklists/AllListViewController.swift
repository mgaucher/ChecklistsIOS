//
//  AllListViewController.swift
//  Checklists
//
//  Created by iem on 02/03/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

   // var listChecklistItem = [ChecklistItem]()
    var checkLists = [Checklist]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
      createList()


        /*
        listChecklistItem.append(ChecklistItem(text: "Liste 3"))
        tableView.insertRows(at: [IndexPath(item:  listChecklistItem.count, section: 0)], with: UITableViewRowAnimation.automatic)
        
        listChecklistItem.append(ChecklistItem(text: "Liste 3"))
        tableView.insertRows(at: [IndexPath(item:  listChecklistItem.count, section: 0)], with: UITableViewRowAnimation.automatic)
        */
        
        // Do any additional setup after loading the view.
    }
    
    required init?(coder aDecoder: NSCoder){
        
        
        super.init(coder: aDecoder)
        
    
    }
    
    func createList(){
        checkLists.append(Checklist(name : "Liste 1"))
        
        tableView.insertRows(at: [IndexPath(row: checkLists.count-1, section: 0)], with: .automatic)
        checkLists.append(Checklist(name : "Liste 2"))
        
        tableView.insertRows(at: [IndexPath(row: checkLists.count-1, section: 0)], with: .automatic)
        
        checkLists.append(Checklist(name : "Liste 3"))
        
        tableView.insertRows(at: [IndexPath(row: checkLists.count-1, section: 0)], with: .automatic)

          }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return checkLists.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Nameofthelist", for: indexPath)
         configureTextForCell(cell: cell, withItem: checkLists[indexPath.row])
               return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            checkLists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    func configureTextForCell(cell: UITableViewCell, withItem item: Checklist){
        cell.textLabel?.text = item.name
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showList"{
            
            let checklist  = segue.destination as! ChecklistViewController;
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                checklist.list = checkLists[indexPath.row]
                }
            }
            else if segue.identifier == "AddListItem" {
                let nav = segue.destination as? UINavigationController
                let destination = nav?.topViewController as? ListDetailViewController
                destination?.delegate = self
            }
            else if segue.identifier == "EditListItem"{
                let nav = segue.destination as? UINavigationController
                let destination = nav?.topViewController as? ListDetailViewController
                let cell = sender as! UITableViewCell
                let i = tableView.indexPath(for: cell)?.row
                
                destination?.editItem = checkLists[i!]
                destination?.delegate = self
                
            }

        
        
    }

  
}
//MARK: - ListDetailViewControllerDelegate
extension AllListViewController : ListDetailViewControllerDelegate
{
    func listDetailViewControllerDidCancel(controller:ListDetailViewController){
        controller.dismiss(animated: true, completion: nil)
    }
    
    func  listDetailViewController(controller: ListDetailViewController, didFinishAddingItem item: Checklist){
        checkLists.append(Checklist(name : controller.textField.text!))
        tableView.insertRows(at: [IndexPath(item: checkLists.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
        controller.dismiss(animated: true, completion: nil)
    }
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingItem item: Checklist){
        let i =  checkLists.index(where:{$0 === item})
        checkLists[i!] = item
        
        tableView.reloadRows(at: [IndexPath(row : i!,section  : 0)], with: UITableViewRowAnimation.automatic)
        controller.dismiss(animated: true, completion: nil)
        
    }
    
}


