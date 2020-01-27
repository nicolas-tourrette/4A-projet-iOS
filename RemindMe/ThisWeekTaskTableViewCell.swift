//
//  TaskTableViewCell.swift
//  RemindMe
//
//  Created by Nicolas Tourrette on 17/01/2020.
//  Copyright © 2020 Nicolas TOURRETTE. All rights reserved.
//

import UIKit

class ThisWeekTaskTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskCategory: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
