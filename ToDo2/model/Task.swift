//
//  TaskViewController.swift
//  ToDo2
//
//  Created by Andrii Damm on 2017-12-29.
//  Copyright © 2017 Andrii Damm. All rights reserved.
//  Version: 0.2
//  Commite: Create datePicker for due date field

import Foundation

struct Task {
    let title : String
    let description : String
    let dueDate : String
    let completion : Bool

    init(title : String, description : String, dueDate : String, completion : Bool){
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.completion = completion
    }
}
