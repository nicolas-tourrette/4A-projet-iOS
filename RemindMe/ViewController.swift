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
    let version = "0.1"
    let build = "1"
    let date = "Dec 15 2019"
    
    // Outlets
    @IBOutlet weak var addTaskButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskButton.layer.cornerRadius = 25.0
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAbout" {
            print("Changing view to About...")
            let aboutViewController = segue.destination as! AboutViewController
            aboutViewController.version = "Version " + version + " b" + build
            aboutViewController.date = "Compiled on " + date + "."
        }
    }
}

