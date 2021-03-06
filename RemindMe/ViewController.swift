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
    let version = "1.0"
    let build = "14"
    let date = "Jan 31 2020"
    
    // Management objects for Core Data
    var managedObjectContext:NSManagedObjectContext?
    var managedObjects: [NSManagedObject] = []
    
    // Outlets
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var thisWeekTasksTableView: UITableView!
    
    /*
        MARK: - VIEW DID LOAD
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskButton.layer.cornerRadius = 25.0
        
        thisWeekTasksTableView.delegate = self
        thisWeekTasksTableView.dataSource = self
        
        // Initialization of Core Data in the view
        initCoreData()
        // Load the datas stored in database
        loadData()
    }
    
    /*
        MARK: - CORE DATA PART
     */
    
    // Initialization of Core Data
    func initCoreData () {
        // Step 1: Create the managed object context
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    // Load the datas stored in the database
    func loadData() {
        // Step 1: Create a fetch request meeting the criteria "Item".
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        let sortDescriptor = NSSortDescriptor(key: "taskDueDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        // Step 2: Fetch and store the data into the managed objects
        do {
            // Returns an array
            managedObjects = try managedObjectContext!.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func saveData(title: String, description: String, dueDate: Date, category: String, priority: String, achivement: Bool = false) {
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedObjectContext!)!
        let currentItem = NSManagedObject(entity: entity, insertInto: managedObjectContext!)
        // 3
        
        currentItem.setValue(title, forKeyPath: "taskTitle")
        currentItem.setValue(description, forKey: "taskDescription")
        currentItem.setValue(dueDate, forKey: "taskDueDate")
        currentItem.setValue(category, forKey: "taskCategory")
        currentItem.setValue(priority, forKey: "taskPriority")
        currentItem.setValue(achivement, forKey: "taskAchived")

        // 4
        do {
            try managedObjectContext!.save()
            managedObjects.append(currentItem)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    /*
        Function to delete a task with its ID
        NOT WORKING !
     */
    func deleteData(taskId: Int){
        print(taskId)
        loadData()
        print(managedObjects)
        managedObjectContext!.delete(managedObjects[taskId] as NSManagedObject)
        managedObjects.remove(at: taskId)
        do { try managedObjectContext?.save() }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        loadData()
        thisWeekTasksTableView.reloadData()
    }
    
    /*
        MARK: - TABLE VIEW GESTURE
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managedObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Select the row of the task item
        let row = indexPath.row
        let currentItem = managedObjects[row]
        
        var cell: ThisWeekTaskTableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: "thisWeekTasksCell", for: indexPath) as? ThisWeekTaskTableViewCell
        remplissageCellule(currentItem: currentItem, cell: cell)
        
        return cell!
    }
    
    func remplissageCellule(currentItem: NSManagedObject, cell: ThisWeekTaskTableViewCell?){
        let formatDateFr = DateFormatter()
        formatDateFr.locale = Locale(identifier: "FR-fr")
        formatDateFr.dateStyle = .medium
        formatDateFr.timeStyle = .medium
        
        let date = currentItem.value(forKeyPath: "taskDueDate") as! Date
        let dateNow = Date()
        
        let titleOfTask = currentItem.value(forKeyPath: "taskTitle") as? String
        let descriptionOfTask = currentItem.value(forKey: "taskDescription") as? String
        let categoryOfTask = currentItem.value(forKey: "taskCategory") as? String
        var colorCodeForCategory: UIColor = UIColor.white
        switch categoryOfTask {
            case "Catégorie 1":
                colorCodeForCategory = UIColor.orange
            case "Catégorie 2":
                colorCodeForCategory = UIColor.brown
            case "Catégorie 3":
                colorCodeForCategory = UIColor.yellow
            default:
                colorCodeForCategory = UIColor.lightGray
        }
        cell!.taskTitle.text = titleOfTask
        if date <= dateNow {
            cell!.taskTitle.textColor = UIColor.red
        }
        cell!.taskDescription.text = descriptionOfTask
        cell!.taskCategory.tintColor = colorCodeForCategory
        cell!.taskDueDate.text = formatDateFr.string(from: currentItem.value(forKeyPath: "taskDueDate") as! Date)
    }
    
    /*
     MARK: - SEGUES
     */
    
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
        else if segue.identifier == "taskDetails" {
            let detailViewController = segue.destination as! DetailViewController
            let myIndexPath = self.thisWeekTasksTableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            let currentItem = managedObjects[row]
            
            let formatDateFr = DateFormatter()
            formatDateFr.locale = Locale(identifier: "FR-fr")
            formatDateFr.dateStyle = .medium
            formatDateFr.timeStyle = .medium
            
            detailViewController.titleOfTask = currentItem.value(forKeyPath: "taskTitle") as! String
            detailViewController.detailOfTask = currentItem.value(forKeyPath: "taskDescription") as! String
            detailViewController.dueDateOfTask = "Pour le \(formatDateFr.string(from: currentItem.value(forKeyPath: "taskDueDate") as! Date))"
            detailViewController.categoryOfTask = currentItem.value(forKeyPath: "taskCategory") as! String
            detailViewController.priorityOfTask = currentItem.value(forKeyPath: "taskPriority") as! String
            detailViewController.taskId = row
        }
        else{
            print("Action inconnue...")
        }
    }
    
    // This function will add a new task in the app database with Core Data
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        // Save action
        if unwindSegue.identifier == "saveNewTask" {
            let sourceViewController = unwindSegue.source as! AddTaskViewController
            print("Saving new task in database...")
            saveData(title: sourceViewController.taskTitle.text!, description: sourceViewController.taskDetail.text, dueDate: sourceViewController.taskDueDate.date, category: sourceViewController.category, priority: sourceViewController.priority)
            loadData()
            thisWeekTasksTableView.reloadData()
        }
        else if unwindSegue.identifier == "saveTask" {
            //let sourceViewController = unwindSegue.source as! AddTaskViewController
            print("Editing an existing task...")
            loadData()
            thisWeekTasksTableView.reloadData()
            // TO BE DONE
        }
        // Delete a task
        else if unwindSegue.identifier == "deleteTask" {
            
        }
        else{
            print("Action inconnue...")
        }
    }
    
    @IBAction func reloadData(_ sender: Any) {
        print("Reloading datas...")
        loadData()
        thisWeekTasksTableView.reloadData()
    }
    
}

