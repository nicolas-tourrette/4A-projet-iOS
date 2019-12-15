//
//  AboutViewController.swift
//  RemindMe
//
//  Created by Nicolas TOURRETTE on 15/12/2019.
//  Copyright © 2019 Nicolas TOURRETTE. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    var version = "undefined"
    
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = version
        // Do any additional setup after loading the view.
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
