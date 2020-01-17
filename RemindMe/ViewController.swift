//
//  ViewController.swift
//  RemindMe
//
//  Created by Nicolas TOURRETTE on 12/12/2019.
//  Copyright © 2019 Nicolas TOURRETTE. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // Constantes de version
    let version = "0.2"
    let build = "3"
    let date = "Jan 15 2020"
    
    // Management objects for Core Data
    var managedObjectContext:NSManagedObjectContext?
    var managedObjects: [NSManagedObject] = []
    
    // Outlets
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var todayTasksTableView: UITableView!
    @IBOutlet weak var tomorrowTasksTableView: UITableView!
    @IBOutlet weak var sevenNextDaysTasksTableView: UITableView!
    @IBOutlet weak var laterTasksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskButton.layer.cornerRadius = 25.0
        
        todayTasksTableView.delegate = self
        todayTasksTableView.dataSource = self
        
        // Initialization of Core Data in the view
        initCoreData()
        // Load the datas stored in database
        loadData()
        
        //self.todayTasksTableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: Selector(("refreshTable:")), name: NSNotification.Name(rawValue: "refresh"), object: nil)
    }
    
    func refreshTable(notification: NSNotification) {
        //println("Received Notification")
        self.todayTasksTableView.reloadData()
    }
    
    // Initialization of Core Data
    func initCoreData () {
        // Step 1: Create the managed object context
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    // Load the datas stored in the database
    func loadData() {
        // Step 1: Create a fetch request meeting the criteria "Item".
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        // Step 2: Fetch and store the data into the managed objects
        do {
            // Returns an array
            managedObjects = try managedObjectContext!.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let versionToPass = "Version " + version + " b" + build
        let dateToPass = "Compiled on " + date + "."
        
        if segue.identifier == "showAbout" {
            let aboutViewController = segue.destination as! AboutViewController
            aboutViewController.version = versionToPass
            aboutViewController.date = dateToPass
        }
        else if segue.identifier == "showMenu" {
            let menuViewController = segue.destination as! MenuViewController
            menuViewController.version = versionToPass
            menuViewController.date = dateToPass
        }
    }
    
    // This function will add a new task in the app database with Core Data
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        // We find the addPhoto view controller
        let sourceViewController = unwindSegue.source as! AddTaskViewController
        // Use data from the view controller which initiated the unwind segue
        
        // Save action
        if unwindSegue.identifier == "saveNewTask" {
            print("Saving task in database...")
            saveData(title: sourceViewController.taskTitle.text!, description: sourceViewController.taskDetail.text!, dueDate: sourceViewController.taskDueDate.date, category: sourceViewController.category, priority: sourceViewController.priority)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
        }
    }
    
    func saveData(title: String, description: String, dueDate: Date, category: String, priority: String) {
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedObjectContext!)!
        let currentItem = NSManagedObject(entity: entity, insertInto: managedObjectContext!)
        // 3
        currentItem.setValue(title, forKeyPath: "taskTitle")
        currentItem.setValue(description, forKey: "taskDescription")
        currentItem.setValue(dueDate, forKeyPath: "taskDueDate")
        currentItem.setValue(category, forKey: "taskCategory")
        currentItem.setValue(priority, forKey: "taskPriority")

        // 4
        do {
            try managedObjectContext!.save()
            managedObjects.append(currentItem)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managedObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasksCell", for: indexPath) as! TaskTableViewCell
        let row = indexPath.row
        let currentItem = managedObjects[row]
        
        let titleOfTask = currentItem.value(forKeyPath: "taskTitle") as? String
        cell.taskTitle.text = titleOfTask
        let descriptionOfTask = currentItem.value(forKey: "taskDecription") as? String
        cell.taskDescription.text = descriptionOfTask
        let categoryOfTask = currentItem.value(forKey: "taskCategory") as? String
        var colorCodeForCategory: UIColor = UIColor.white
        switch categoryOfTask {
        case "Catégorie 1":
            colorCodeForCategory = UIColor.brown
        default:
            colorCodeForCategory = UIColor.white
        }
        cell.taskCategory.tintColor = colorCodeForCategory
        return cell
    }

}

