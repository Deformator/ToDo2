//
//  TaskViewController.swift
//  ToDo2
//
//  Created by Andrii Damm on 2017-12-29.
//  Copyright © 2017 Andrii Damm. All rights reserved.
//  Version: 0.8
//  Commite: Changing completion mark to switchers 

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDueTime: UILabel!
    @IBOutlet weak var taskCompletionSwitcher: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
