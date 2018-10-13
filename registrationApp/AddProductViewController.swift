//
//  AddProductViewController.swift
//  registrationApp
//
//  Created by 手嶋慧太 on 2018/10/10.
//  Copyright © 2018年 手嶋慧太. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var productName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endInput(_ sender: Any) {
        productName?.text = (sender as AnyObject).text
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
