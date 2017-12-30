//
//  TaskViewController.swift
//  ToDo2
//
//  Created by Andrii Damm on 2017-12-29.
//  Copyright © 2017 Andrii Damm. All rights reserved.
//  Version: 0.8
//  Commite: Changing completion mark to switchers 

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
        cell.taskCompletionSwitcher.tag = indexPath.row
        
//        cell.accessoryType = self.tasks[indexPath.row].completion ? .checkmark : .none
        if self.tasks[indexPath.row].completion == true {
            cell.taskCompletionSwitcher.setOn(false, animated: true)
            cell.taskTitle.textColor = #colorLiteral(red: 0.3669572473, green: 0.3970608115, blue: 0.4392519891, alpha: 1)
            cell.taskDueTime.textColor = #colorLiteral(red: 0.3725490196, green: 0.3960784314, blue: 0.4352941176, alpha: 1)
        } else {
            cell.taskCompletionSwitcher.setOn(true, animated: true)
            cell.taskTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.taskDueTime.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        

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

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

    }
    
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
    
    @IBAction func switchTaskCompletion(_ sender: UISwitch) {

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            
            do {
                let results = try context.fetch(request)
                if results.count > 0 {
                   var resutlsObjects = results as! [NSManagedObject]
                    let result = resutlsObjects[sender.tag]
               
                    _ = result.value(forKey: "completion") as? String
                            if sender.isOn {
                                result.setValue(false, forKey: "completion")
                            } else {
                                result.setValue(true, forKey: "completion")
                            }
                            
                            do {
                                try context.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                       

                    
                }
            } catch {
                print(error.localizedDescription)
            }
        
        self.tableVIewList.reloadData()
    }
    


}
