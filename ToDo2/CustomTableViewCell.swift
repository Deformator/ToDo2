//
//  TaskViewController.swift
//  ToDo2
//
//  Created by Andrii Damm on 2017-12-29.
//  Copyright © 2017 Andrii Damm. All rights reserved.
//  Version: 0.9
//  Commite: Inner documentation added

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
