//
//  ViewController.swift
//  RemindMe
//
//  Created by Nicolas TOURRETTE on 12/12/2019.
//  Copyright © 2019 Nicolas TOURRETTE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Constantes de version
    let version = "0.2"
    let build = "1"
    let date = "Jan 13 2020"
    
    // Outlets
    @IBOutlet weak var addTaskButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskButton.layer.cornerRadius = 25.0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAbout" {
            print("Changing view to About...")
            let aboutViewController = segue.destination as! AboutViewController
            aboutViewController.version = "Version " + version + " b" + build
            aboutViewController.date = "Compiled on " + date + "."
        }
        if segue.identifier == "showMenu" {
            print("Changing view to Menu...")
        }
    }
}

