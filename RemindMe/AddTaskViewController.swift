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
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Annuler les modifications", message: "Voulez-vous vraiment annuler les modifications et revenir à la liste des tâches ?", preferredStyle: .alert)
        //alert.addAction(UIAlertAction(title: NSLocalizedString("Oui", comment: "Ceci reviendra à l'accueil."), style: .destructive, handler: { action in self.dism }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Non", comment: "Ceci gardera vos modificaitons."), style: .cancel))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTaskButton.layer.cornerRadius = 20.0
        taskTitle.placeholder = "Enter the task title..."
        taskDetail.layer.borderWidth = taskTitle.layer.borderWidth
        taskDetail.layer.borderColor = taskTitle.layer.borderColor
        taskDetail.layer.cornerRadius = taskTitle.layer.cornerRadius
        // Make a placeholder for task detail
        taskDetail.text = "Enter the task details..."
        taskDetail.textColor = UIColor.lightGray
        
        //taskCategory.dataSource
    }
    
    // When editing the placeholder text initialized in viewDidLoad(), transform the text into a black and real text
    func taskDetailDidBeginEditing(_ taskDetail: UITextView){
        if(taskDetail.textColor == UIColor.lightGray){
            taskDetail.text = nil
            taskDetail.textColor = UIColor.black
        }
    }
    
    // Reinitializing the placeholder text for task details box
    func taskDetailDidEndEditing(_ taskDetail: UITextView){
        if(taskDetail.text.isEmpty){
            taskDetail.text = "Enter the task details..."
            taskDetail.textColor = UIColor.lightGray
        }
    }
    
    // This function will add a new task in the app database with CoreData
    @IBAction func addNewTask(_ sender: UIButton) {
        
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
