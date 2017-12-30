//
//  TaskViewController.swift
//  ToDo2
//
//  Created by Andrii Damm on 2017-12-29.
//  Copyright © 2017 Andrii Damm. All rights reserved.
//  Version: 0.5
//  Commite: Adding styles for new task screen. Updated nav bar

import UIKit
import CoreData

class TaskViewController: UIViewController {
    
    
    @IBOutlet weak var titleTask: UITextView!
    @IBOutlet weak var descriptionTask: UITextView!
    @IBOutlet weak var dueDateField: UITextField!
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
//        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        title = "New note"
        createDatePicker()
    }

    @IBAction func submitPressed(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
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
    
    @IBAction func clearPressed(_ sender: UIButton) {
        titleTask.text = ""
        descriptionTask.text = ""
        dueDateField.text = ""
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
