//
//  ViewController.swift
//  RemindMe
//
//  Created by Nicolas TOURRETTE on 12/12/2019.
//  Copyright © 2019 Nicolas TOURRETTE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let version = "0.1"
    let build = "1"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAbout" {
            print("Changing view to About...")
            let aboutViewController = segue.destination as! AboutViewController
            let versionActuelle = "Version " + version + " b" + build
            aboutViewController.version = versionActuelle
        }
    }
}

