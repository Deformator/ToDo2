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

class TaskViewController: UIViewController {

    //view outlets
    @IBOutlet weak var submitButton: CustomButton!
    @IBOutlet weak var titleTask: UITextView!
    @IBOutlet weak var descriptionTask: UITextView!
    @IBOutlet weak var dueDateField: UITextField!
    
    //variables for segue
    var titleT = ""
    var descT = ""
    var dueDateT = ""
    
    //datePicker instance for toolBar
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assigning data from seque
        titleTask.text = titleT
        descriptionTask.text = descT
        dueDateField.text = dueDateT
        
        //changing button title for edit mode
        if !titleT.isEmpty {
            submitButton.setTitle("Update", for: .normal)
        }
        
        //change title for navigation bar
        title = "New note"
        
        //creating Date Picker
        createDatePicker()
        
    }
    
    //hiding keyboard function
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //create date picker function for due date field
    func createDatePicker() {
        
        //create a toolbar instance
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //create done button for date picker
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        //bounding due date field text with toolbar data chosen
        dueDateField.inputAccessoryView = toolbar
        dueDateField.inputView = datePicker
    }
    
    
    //done button functionality for date picker
    @objc func donePressed() {
        
        //set format for chosen date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        //set chosen date into due date field
        dueDateField.text = formatter.string(from: self.datePicker.date)
        self.view.endEditing(true)
    }

    //submit button pressed
    @IBAction func submitPressed(_ sender: UIButton) {
        
        //get Core Data object
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //update core data Task object
        if submitButton.titleLabel!.text == "Update" {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            
            do {
                let results = try context.fetch(request)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        let taskName = result.value(forKey: "title") as? String
                        let taskDesc = result.value(forKey: "taskDescription") as? String
                        let taskDueDate = result.value(forKey: "dueDate") as? String
                            if taskName == titleT && taskDesc == descT && taskDueDate == dueDateT {
                                result.setValue(titleTask.text, forKey: "title")
                                result.setValue(descriptionTask.text, forKey: "taskDescription")
                                result.setValue(dueDateField.text, forKey: "dueDate")
                                do {
                                    try context.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            
        } else {
            //save new Task object into Core Data
            let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
            let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Task
            taskObject.title = titleTask.text
            taskObject.taskDescription = descriptionTask.text
            taskObject.dueDate = dueDateField.text
            taskObject.completion = false
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        //redirecting to root ViewController (ListViewController)
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    //cancel button pressed functianality
    @IBAction func cancelPressed(_ sender: UIButton) {
        
        //redirecting to root ViewController (ListViewController)
        navigationController?.popToRootViewController(animated: true)
    }
    
}
