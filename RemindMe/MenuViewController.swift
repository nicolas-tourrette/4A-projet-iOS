//
//  MenuViewController.swift
//  RemindMe
//
//  Created by Nicolas Tourrette on 14/01/2020.
//  Copyright © 2020 Nicolas TOURRETTE. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var version = "undefined"
    var date = "undefined"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAbout" {
            let aboutViewController = segue.destination as! AboutViewController
            aboutViewController.version = version
            aboutViewController.date = date
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
