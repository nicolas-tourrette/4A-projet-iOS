//
//  DetailViewController.swift
//  RemindMe
//
//  Created by Nicolas TOURRETTE on 20/12/2019.
//  Copyright © 2019 Nicolas TOURRETTE. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // Outlets
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDetail: UILabel!
    @IBOutlet weak var taskTimerReminder: UILabel!
    @IBOutlet weak var deleteTaskButton: UIBarButtonItem!
    @IBOutlet weak var changeReminderButton: UIButton!
    @IBOutlet weak var editTaskButton: UIButton!
    @IBOutlet weak var markTaskAsFinishedSwitch: UISwitch!
    
    var titleOfTask = ""
    var detailOfTask = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editTaskButton.layer.cornerRadius = 25.0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
