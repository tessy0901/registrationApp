//
//  CustomProductCell.swift
//  registrationApp
//
//  Created by 手嶋慧太 on 2018/11/17.
//  Copyright © 2018年 手嶋慧太. All rights reserved.
//

import UIKit
import Firebase

class CustomProductCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productNumber: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var number:Int = 1
    var id:String = ""
    var productId:String = ""
    
    func syokika(num : Int){
        stepper.value = Double(num)
        productNumber.text = String(num)
    }
    
    @IBAction func pushStepper(_ sender: UIStepper) {
        let db = Firestore.firestore()
        let productRef: DocumentReference? = db.collection("groups").document(id).collection("products").document(productId)

//        stepper.value = sender.value
        productNumber.text = String(Int(sender.value))
        productRef?.updateData([
            "number": sender.value
            ])
//        print(stepper.value)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
