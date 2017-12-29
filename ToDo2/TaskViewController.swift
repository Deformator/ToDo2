//
//  TaskViewController.swift
//  ToDo2
//
//  Created by Andrii Damm on 2017-12-29.
//  Copyright © 2017 Andrii Damm. All rights reserved.
//  Version: 0.2
//  Commite: Create datePicker for due date field

import UIKit

class TaskViewController: UIViewController {
    
    
    @IBOutlet weak var titleTask: UITextView!
    @IBOutlet weak var descriptionTask: UITextView!
    @IBOutlet weak var dueDateField: UITextField!
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

       createDatePicker()
    }

    @IBAction func submitPressed(_ sender: UIButton) {
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
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
