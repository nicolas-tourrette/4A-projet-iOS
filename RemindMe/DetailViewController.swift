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
    @IBOutlet weak var taskDueDate: UILabel!
    @IBOutlet weak var taskCategory: UILabel!
    @IBOutlet weak var taskPriority: UILabel!
    @IBOutlet weak var taskTimerReminder: UILabel!
    @IBOutlet weak var deleteTaskButton: UIBarButtonItem!
    @IBOutlet weak var changeReminderButton: UIButton!
    @IBOutlet weak var editTaskButton: UIButton!
    @IBOutlet weak var markTaskAsFinishedSwitch: UISwitch!
    
    var titleOfTask = ""
    var detailOfTask = ""
    var dueDateOfTask = "Pour le --UNKNOWN DATE--"
    var categoryOfTask = ""
    var priorityOfTask = ""
    var taskId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editTaskButton.layer.cornerRadius = 25.0
        
        taskTitle.text = titleOfTask
        taskDetail.text = detailOfTask
        taskDueDate.text = dueDateOfTask
        taskCategory.text = categoryOfTask
        taskPriority.text = priorityOfTask
        
        print("Task ID: \(taskId)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "deleteTask" {
            let alert = UIAlertController(title: "Supprimer la tâche ?", message: "Voulez-vous vraiment supprimer définitivement cette tâche ?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Oui", comment: "Ceci supprimera définitivement la tâche."), style: .destructive, handler: { action in self.dismiss(animated: true, completion: nil) }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Non", comment: "Ceci gardera la tâche intacte."), style: .cancel))
            self.present(alert, animated: true)
            //let destViewController = segue.destination as! ViewController;
            //destViewController.deleteData(taskId: taskId)  // -- NOT WORKING
        }
    }
    
    @IBAction func markedAsAchived(_ sender: Any) {
        let alert = UIAlertController(title: "Marquer la tâche achevée ?", message: "Voulez-vous vraiment marquer cette tâche comme achevée et définitivement l'archiver ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Oui", comment: "Ceci achèvera la tâche la tâche."), style: .destructive, handler: { action in self.dismiss(animated: true, completion: nil) }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Non", comment: "Ceci gardera la tâche intacte."), style: .cancel))
        self.present(alert, animated: true)
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
