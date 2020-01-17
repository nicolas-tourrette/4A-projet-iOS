//
//  AddTaskViewController.swift
//  RemindMe
//
//  Created by Nicolas TOURRETTE on 20/12/2019.
//  Copyright © 2019 Nicolas TOURRETTE. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDetail: UITextView!
    @IBOutlet weak var taskCategory: UIPickerView!
    @IBOutlet weak var taskDueDate: UIDatePicker!
    @IBOutlet weak var taskPriority: UIPickerView!
    @IBOutlet weak var addTaskButton: UIButton!
    
    var category: String = ""
    var priority: String = ""
    
    /*
        BEGIN ** DATAS FOR THE PICKERS IN THE VIEW: CATEGORIES AND PRIORITY
     */
    
    // Datas of the task picker
    var categories = ["Catégorie 1", "Catégorie 2", "Catégorie 3"]
    var priorities = ["Priorité 1", "Priorité 2", "Priorité 3"]
    // Number of slider in the picker (1 because only categories)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // Number of components in the unique slider: number of categories/priorities contained in the table
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == taskCategory {
            return categories.count
        }
        else if pickerView == taskPriority {
            return priorities.count
        }
        else {
            return 0
        }
    }
    // Give the datas to the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == taskCategory {
            return categories[row]
        }
        else if pickerView == taskPriority {
            return priorities[row]
        }
        else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == taskCategory {
            category = categories[row]
        }
        else if pickerView == taskPriority {
            priority = priorities[row]
        }
        else {
            print("An error has occured...")
        }
    }
    
    /*
        END
     */
    
    @IBAction func cancelAction(_ sender: Any) {
        let alert = UIAlertController(title: "Annuler les modifications ?", message: "Voulez-vous vraiment annuler les modifications et revenir à la liste des tâches ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Oui", comment: "Ceci reviendra à l'accueil."), style: .destructive, handler: { action in self.dismiss(animated: true, completion: nil) }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Non", comment: "Ceci gardera vos modifications."), style: .cancel))
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
        
        // Adding datas to the tasks picker
        taskCategory.delegate = self
        taskCategory.dataSource = self
        
        // Adding datas to the tasks picker
        taskPriority.delegate = self
        taskPriority.dataSource = self
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
