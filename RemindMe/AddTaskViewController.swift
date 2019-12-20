//
//  AddTaskViewController.swift
//  RemindMe
//
//  Created by Nicolas TOURRETTE on 20/12/2019.
//  Copyright © 2019 Nicolas TOURRETTE. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDetail: UITextView!
    @IBOutlet weak var taskCategory: UIPickerView!
    @IBOutlet weak var taskDueDate: UIDatePicker!
    @IBOutlet weak var taskPriority: UIPickerView!
    @IBOutlet weak var cancelAddTaskButton: UIBarButtonItem!
    @IBOutlet weak var addTaskButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTaskButton.layer.cornerRadius = 20.0
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
