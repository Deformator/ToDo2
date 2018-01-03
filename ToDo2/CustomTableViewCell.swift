/*
 * File name: CustomTableViewCell.swift
 * App Name: ToDo2
 * Authors: Andrii Damm, Tarun Singh
 * Student IDs: 300966307, 300967393
 * Date: December 29, 2017
 * Version: 1.0 - Internal documentation added.
 * Description: Custom UITableViewCell for each cell of our To-do tasks list.
 * Copyright © 2017 Andrii Damm. All rights reserved.
 */

import UIKit

class CustomTableViewCell: UITableViewCell {

    //cells outlets
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDueTime: UILabel!
    @IBOutlet weak var taskCompletionSwitcher: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
