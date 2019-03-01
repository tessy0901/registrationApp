//
//  ViewController.swift
//  registrationApp
//
//  Created by 手嶋慧太 on 2018/09/20.
//  Copyright © 2018年 手嶋慧太. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseUI

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var groupTitle:[String] = []
    var groupId:[String] = []
    var idImput:String = ""
    var sendId:String = ""
    
    var authUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}
    let providers: [FUIAuthProvider] = []
    
    @IBOutlet weak var groupTable: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    //ここに戻ってくる時の処理
    @IBAction func GoToViewController(_ segue : UIStoryboardSegue){
        guard let imputsource = segue.source as? GroupRegistrationViewController else {
            fatalError()
        }
//        guard let changesource = segue.source as? EditGroupViewController else {
//            fatalError()
//        }
        var userRef: DocumentReference? = nil
        var groupRef: DocumentReference? = nil
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        //グループ作成
        if let imputtext = imputsource.nameTextField!.text {
            
            userRef = db.collection("groups").addDocument(data:[
                "name" : imputtext
            ]){ err in}
            groupRef = db.collection("users").document(uid!).collection("mygroups").document(userRef!.documentID)
            groupRef?.setData([
                "name": imputtext,
                "id": userRef!.documentID
                ])
            
            reloadTable()
        }//else if let changetext = changesource.changeName!.text{

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        groupTable.delegate = self
        groupTable.dataSource = self
        let authUI = FUIAuth.defaultAuthUI()
        authUI!.delegate = self
        
        //firestore使用
        let providers: [FUIAuthProvider] = [
            //FUIGoogleAuth(),
            //FUIFacebookAuth(),
            //FUITwitterAuth(),
            //FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()!),
            ]
        authUI!.providers = providers
        
        //let ref: DatabaseReference! = Database.database().reference()

        //セルの編集buttonの追加
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = editButtonItem
        
//        groupTable.reloadData()
        // Add a new document with a generated ID
        
        reloadTable()
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // handle user and error as necessary
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLoggedIn()
        
//        reloadTable()
        }
    
    // Table Viewにいくつのセルを表示するかを指定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupTitle.count
    }
    
    // セルに表示する値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // データを表示するセルを取得する
        let groupCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Groupcell", for: indexPath)
        
        // セルに表示する値を設定する
        groupCell.textLabel!.text = groupTitle[indexPath.row]
        groupCell.accessoryType = UITableViewCell.AccessoryType.detailButton
        
        // データを設定したセルを返却する
        return groupCell
    }
    //アクセサリボタン押下
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//        performSegue(withIdentifier: "EditGroup", sender: nil)
    }
    
    //セルタップ時のイベント
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let next = storyboard!.instantiateViewController(withIdentifier: "GoToProductTable") as? ProductViewController
//        let _ = next?.view // ** hack code **
        print(next!)
        print("idImputttttt: \(idImput)")
        print(indexPath.row)
        print(groupId[indexPath.row])
        
        sendId = groupId[indexPath.row]
        print("sendId:\(sendId)")

        performSegue(withIdentifier: "GoToProductTable", sender: nil)//groupId[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToProductTable"{
            let next = segue.destination as? ProductViewController
            next?.keyID = sendId
            let _ = next?.view

        }
    }
    
    //セルの編集
    override func setEditing(_ editing: Bool, animated: Bool) {
        //override前の処理を継続してさせる
        super.setEditing(editing, animated: animated)
        groupTable.isEditing = editing
        
        //addButton有効化，無効化
        if editing {
            addButton.isEnabled = false
        }
        else{
            addButton.isEnabled = true
        }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //削除ボタンが押下された時の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let ref: CollectionReference? =  db.collection("users").document(uid!).collection("mygroups")
        
        //dataを消してから
        ref?.document(groupId[indexPath.row]).delete()
            { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                    self.groupTitle.remove(at: indexPath.row)
                    self.groupId.remove(at: indexPath.row)

                    //tableViewCellの削除
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
        }
        reloadTable()
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //グループ一覧リロード
    func reloadTable() {
        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        var group = db.collection("users").document(uid!)
        let ref: CollectionReference? =  db.collection("users").document(uid!).collection("mygroups")
        
        ref?.getDocuments{(DocumentSnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.groupTitle.removeAll()
                for document in DocumentSnapshot!.documents {
                    self.groupTitle.append(String(describing: document.get("name")!))
                    self.idImput = String(describing: document.get("id")!)
                    self.groupId.append(String(describing: document.get("id")!))
                }
                self.groupTable.reloadData()
            }
        }
    }
    
}

///////////////////////////////////////////////////////////////////////////////////
//login
extension ViewController: FUIAuthDelegate {
    
    func checkLoggedIn() {
        self.setupLogin()
        Auth.auth().addStateDidChangeListener{auth, user in
            if user != nil{
                let uid = Auth.auth().currentUser?.uid
                let db = Firestore.firestore()
                db.collection("users").document(uid!).setData([
                    "uid" : uid,
                ]) { err in
                    if let err = err { return }
                }
            } else {
                self.login()
            }
        }
    }
    
    func setupLogin() {
        authUI.delegate = self
        authUI.providers = providers
//        authUI.isSignInWithEmailHidden = true
    }
    
    func login() {
        let authViewController = authUI.authViewController()
        self.present(authViewController, animated: true, completion: nil)
    }
    
}
