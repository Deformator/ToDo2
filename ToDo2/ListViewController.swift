//
//  TaskViewController.swift
//  ToDo2
//
//  Created by Andrii Damm on 2017-12-29.
//  Copyright © 2017 Andrii Damm. All rights reserved.
//  Version: 0.7
//  Commite: Adding styles for task list. Adding completion marks

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableVIewList: UITableView!
    var tasks : [Task] = []
//    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableVIewList.backgroundColor = .clear
        tableVIewList.tableFooterView = UIView(frame: CGRect.zero)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            try tasks = context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        tableVIewList.reloadData()
    }


    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }


     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath) as! CustomTableViewCell
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.green.cgColor
        cell.layer.cornerRadius = 20
        
        cell.accessoryType = self.tasks[indexPath.row].completion ? .checkmark : .none
//        if self.tasks[indexPath.row].completion == true {
//            cell.taskTitle.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//            cell.taskDueTime.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        }
        

        cell.taskTitle?.text = tasks[indexPath.row].title
        cell.taskDueTime.text = tasks[indexPath.row].dueDate

        return cell
    }



     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let tasksToDelete = tasks[indexPath.row] as? Task, editingStyle == .delete else {return}
        context.delete(tasksToDelete)
        do{
            try context.save()
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } catch {
            print(error.localizedDescription)
        }
        
        

 
    }

    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let ac = UIAlertController(
//            title: "\(tasks[indexPath.row].title!)",
//            message: "\(tasks[indexPath.row].taskDescription!)",
//            preferredStyle: .actionSheet)
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        let isDoneTitle = self.tasks[indexPath.row].completion ? "Return to undone" : "Done"
//
//        let isDone = UIAlertAction(title: isDoneTitle, style: .default) { (action: UIAlertAction) in
//            let cell = tableView.cellForRow(at: indexPath)
//            self.tasks[indexPath.row].completion = !self.tasks[indexPath.row].completion
//            cell?.accessoryType = self.tasks[indexPath.row].completion ? .checkmark : .none
//            tableView.reloadData()
//        }
//        let edit = UIAlertAction(title: "Edit", style: .default) { (action: UIAlertAction) in
//
//        func prepare(for segue: UIStoryboardSegue, sender: Any?){
//            if segue.identifier == "details" {
//                if let indexPath = tableView.indexPathForSelectedRow {
//                    let tvk = segue.destination as! TaskViewController
//                    tvk.titleT = self.tasks[indexPath.row].title!
//                    tvk.descT = self.tasks[indexPath.row].taskDescription!
//                    tvk.dueDateT = self.tasks[indexPath.row].dueDate!
//                }
//            }
//            }
//
//
//        }
//        ac.addAction(isDone)
//        ac.addAction(edit)
//        ac.addAction(cancel)
//
//        present(ac, animated: true, completion: nil)
//        tableView.deselectRow(at: indexPath, animated: true)
//
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "details" {
            if let indexPath = self.tableVIewList.indexPathForSelectedRow {
                let tvk = segue.destination as! TaskViewController
                tvk.titleT = self.tasks[indexPath.row].title!
                tvk.descT = self.tasks[indexPath.row].taskDescription!
                tvk.dueDateT = self.tasks[indexPath.row].dueDate!
            }
        }
    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


}
