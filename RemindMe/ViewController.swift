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
    
    /*
        MARK: - VIEW DID LOAD
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskButton.layer.cornerRadius = 25.0
        
        todayTasksTableView.delegate = self
        todayTasksTableView.dataSource = self
        tomorrowTasksTableView.delegate = self
        tomorrowTasksTableView.dataSource = self
        sevenNextDaysTasksTableView.delegate = self
        sevenNextDaysTasksTableView.dataSource = self
        laterTasksTableView.delegate = self
        laterTasksTableView.dataSource = self
        
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
        currentItem.setValue(dueDate, forKeyPath: "taskDueDate")
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
        MARK: - TABLE VIEW GESTURE
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managedObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Select the row of the task item
        let row = indexPath.row
        let currentItem = managedObjects[row]
        
        var cellIdentifier = ""
        let date = currentItem.value(forKeyPath: "taskDueDate") as! Date
        let dateNow = Date()
        
        if date == dateNow {
            cellIdentifier = "todayTasksCell"
        }
        else if date > dateNow && date < dateNow.addingTimeInterval(3600*24) {
            cellIdentifier = "tomorrowTasksCell"
        }
        else if date > dateNow.addingTimeInterval(3600*24) && date < dateNow.addingTimeInterval(7*3600*24) {
            cellIdentifier = "sevenDaysTasksCell"
        }
        else if date > dateNow.addingTimeInterval(14*3600*24) {
            cellIdentifier = "laterTasksCell"
        }
        else{
            print("Date ne rentrant pas dans les conditions...")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TaskTableViewCell
        
        if cell != nil {
            let titleOfTask = currentItem.value(forKeyPath: "taskTitle") as? String
            
            let descriptionOfTask = currentItem.value(forKey: "taskDescription") as? String
            
            let categoryOfTask = currentItem.value(forKey: "taskCategory") as? String
            var colorCodeForCategory: UIColor = UIColor.white
            switch categoryOfTask {
                case "Catégorie 2":
                    colorCodeForCategory = UIColor.brown
                default:
                    colorCodeForCategory = UIColor.white
            }
            cell!.taskTitle.text = titleOfTask
            cell!.taskDescription.text = descriptionOfTask
            cell!.taskCategory.tintColor = colorCodeForCategory
            return cell!
        }
        else {
            print("Pas de cellule !")
            return cell!
        }
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
            // HOW TO PASS DATAS TO THE DETAIL VIEW ??
            /*let myIndexPath = self.todayTasksTableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            detailViewController.titleOfTask =
            */
        }
        else{
            print("Action inconnue...")
        }
    }
    
    // This function will add a new task in the app database with Core Data
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        // We find the addPhoto view controller
        let sourceViewController = unwindSegue.source as! AddTaskViewController
        // Use data from the view controller which initiated the unwind segue
        
        // Save action
        if unwindSegue.identifier == "saveNewTask" {
            print("Saving new task in database...")
            saveData(title: sourceViewController.taskTitle.text!, description: sourceViewController.taskDetail.text, dueDate: sourceViewController.taskDueDate.date, category: sourceViewController.category, priority: sourceViewController.priority)
            //todayTasksTableView.reloadData()
        }
        else if unwindSegue.identifier == "saveTask" {
            print("Editing an existing task...")
            // TO BE DONE
        }
        else{
            print("Action inconnue...")
        }
    }

}

