//
//  TaskViewController.swift
//  ToDo2
//
//  Created by Andrii Damm on 2017-12-29.
//  Copyright © 2017 Andrii Damm. All rights reserved.
//  Version: 0.7
//  Commite: Update functionality done

import UIKit
import CoreData

class TaskViewController: UIViewController {
    
    
    @IBOutlet weak var submitButton: CustomButton!
    @IBOutlet weak var titleTask: UITextView!
    @IBOutlet weak var descriptionTask: UITextView!
    @IBOutlet weak var dueDateField: UITextField!
    
    var titleT = ""
    var descT = ""
    var dueDateT = ""
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTask.text = titleT
        descriptionTask.text = descT
        dueDateField.text = dueDateT
        
        if !titleT.isEmpty {
            submitButton.setTitle("Update", for: .normal)
        }
//        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        title = "New note"
        createDatePicker()
        
        self.titleTask.resignFirstResponder()
    }

    @IBAction func submitPressed(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
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
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        dueDateField.inputAccessoryView = toolbar
        dueDateField.inputView = datePicker
    }
    
    @objc func donePressed() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        dueDateField.text = formatter.string(from: self.datePicker.date)
        self.view.endEditing(true)
    }
}
