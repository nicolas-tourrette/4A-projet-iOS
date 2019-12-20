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
        alert.addAction(UIAlertAction(title: NSLocalizedString("Oui", comment: "Ceci reviendra à l'accueil."), style: .destructive, handler: { action in self.dism }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Non", comment: "Ceci gardera vos modificaitons."), style: .cancel))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTaskButton.layer.cornerRadius = 20.0
        //placeholder...
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
