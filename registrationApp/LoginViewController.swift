//
//  LoginViewController.swift
//  
//
//  Created by 手嶋慧太 on 2018/10/27.
//

import UIKit
import FirebaseUI
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController,FUIAuthDelegate {
    
    //let authUI = FUIAuth.defaultAuthUI()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let authUI = FUIAuth.defaultAuthUI()
        
        // You need to adopt a FUIAuthDelegate protocol to receive callback
//        authUI!.delegate = self
        
//        let providers: [FUIAuthProvider] = [
            //FUIGoogleAuth(),
            //FUIFacebookAuth(),
            //FUITwitterAuth(),
//            FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()!),
//            ]
//        authUI!.providers = providers
        
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
