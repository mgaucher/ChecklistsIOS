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
        /*
        if segue.identifier == "showList"{
            
            let controller = segue.destination as! ChecklistViewController
            controller.list = sender as! Checklist
            
        }
        */
    }

  
}
