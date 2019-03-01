//
//  EditGroupViewController.swift
//  registrationApp
//
//  Created by 手嶋慧太 on 2018/11/20.
//  Copyright © 2018年 手嶋慧太. All rights reserved.
//

import UIKit

class EditGroupViewController: UIViewController {
    @IBOutlet weak var changeName: UITextField!
    @IBAction func imputName(_ sender: Any) {
        changeName?.text = (sender as AnyObject).text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
