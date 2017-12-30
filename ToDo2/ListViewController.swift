//
//  TaskViewController.swift
//  ToDo2
//
//  Created by Andrii Damm on 2017-12-29.
//  Copyright © 2017 Andrii Damm. All rights reserved.
//  Version: 0.9
//  Commite: Inner documentation added

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //table view instanse
    @IBOutlet weak var tableVIewList: UITableView!
    
    //array of tasks from Core Data
    var tasks : [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cleaning background and separators for tableView
        tableVIewList.backgroundColor = .clear
        tableVIewList.tableFooterView = UIView(frame: CGRect.zero)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //fill tasks array with Core Data data (Task)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath) as! CustomTableViewCell
        
        //customizing cell's border
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.green.cgColor
        cell.layer.cornerRadius = 20
        
        //adding tag for switcher in cell
        cell.taskCompletionSwitcher.tag = indexPath.row
        
        //change labels color in order to task completion
        if self.tasks[indexPath.row].completion == true {
            cell.taskCompletionSwitcher.setOn(false, animated: true)
            cell.taskTitle.textColor = #colorLiteral(red: 0.3669572473, green: 0.3970608115, blue: 0.4392519891, alpha: 1)
            cell.taskDueTime.textColor = #colorLiteral(red: 0.3725490196, green: 0.3960784314, blue: 0.4352941176, alpha: 1)
        } else {
            cell.taskCompletionSwitcher.setOn(true, animated: true)
            cell.taskTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.taskDueTime.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        //change labels data with Task object data
        cell.taskTitle?.text = tasks[indexPath.row].title
        cell.taskDueTime.text = tasks[indexPath.row].dueDate
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //fetching data from Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //implement "delete" functionality
        guard let tasksToDelete = tasks[indexPath.row] as? Task, editingStyle == .delete else {return}
        
        //delete object from Core Data
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
    
    //segue for parsing data for edit task
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
    
    //updating task completion with switcher
    @IBAction func switchTaskCompletion(_ sender: UISwitch) {
        
        //fetching Core Data object
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //prepare request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            
            //fetching Task object from Core Data
            let results = try context.fetch(request)
            if results.count > 0 {
                var resutlsObjects = results as! [NSManagedObject]
                
                //geting proper task by tag index
                let result = resutlsObjects[sender.tag]
                
                _ = result.value(forKey: "completion") as? String
                
                //changing completion
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
