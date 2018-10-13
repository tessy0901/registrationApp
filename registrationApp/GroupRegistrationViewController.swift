//
//  GroupRegistrationViewController.swift
//  registrationApp
//
//  Created by 手嶋慧太 on 2018/09/20.
//  Copyright © 2018年 手嶋慧太. All rights reserved.
//

import UIKit

class GroupRegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func endInput(_ sender: Any) {
        nameTextField?.text = (sender as AnyObject).text
    }
}
