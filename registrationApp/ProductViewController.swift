//
//  ProductViewController.swift
//  registrationApp
//
//  Created by 手嶋慧太 on 2018/10/10.
//  Copyright © 2018年 手嶋慧太. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase

class ProductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var productTitle:[String] = []
    var productId:[String] = []
    var productNumber:[Int] = []
    var keyID:String? = ""
    
    @IBOutlet weak var productTable: UITableView!
    @IBAction func addButton(_ sender: Any) {
    }
    
    //ここに戻ってくる時の処理
    @IBAction func GoToProductViewController(_ segue : UIStoryboardSegue){
        guard let source = segue.source as? AddProductViewController else {
            fatalError()
        }
        var productRef: CollectionReference? = nil
        let db = Firestore.firestore()
//        if let text = source.productName!.text && source.productNumber != nil{
        if let text = source.productName!.text, let number = Int(source.productNumber!.text!), text != nil, number != nil {
            productRef = db.collection("groups").document(keyID!).collection("products")
            productRef?.addDocument(data: [
                "name": text,
                "number": number
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    self.reloadProduct()
                }
            }
//            productTitle.append(text)
//            productNumber.append(number)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        productTable.delegate = self
        productTable.dataSource = self
        
        self.productTable.register(UINib(nibName: "CustomProductCell", bundle: nil), forCellReuseIdentifier: "CustomProductCell")
        
        //セルの編集buttonの追加
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = editButtonItem
        
        reloadProduct()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        print("viewWillAppear")
//    }
    
    // Table Viewにいくつのセルを表示するかを指定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productTitle.count
    }
    
    // セルに表示する値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // データを表示するセルを取得する
        let cell: CustomProductCell = tableView.dequeueReusableCell(withIdentifier: "CustomProductCell", for: indexPath) as! CustomProductCell
        
        // セルに表示する値を設定する
        cell.productName!.text = productTitle[indexPath.row]
//        cell.productNumber!.text = String(productNumber[indexPath.row])
        cell.syokika(num: productNumber[indexPath.row])
        cell.id = keyID!
        cell.productId = productId[indexPath.row]
//        print(cell.stepper.value)
        
        // データを設定したセルを返却する
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //セルの編集
    override func setEditing(_ editing: Bool, animated: Bool) {
        //override前の処理を継続してさせる
        super.setEditing(editing, animated: animated)
        productTable.isEditing = editing
        
        //addButton有効化，無効化
        //if editing {
            //addButton.isEnabled = true
            //self.navigationItem.hidesBackButton = false
        //}
        //else{
            //addButton.isEnabled = false
            //self.navigationItem.hidesBackButton = true
        //}
    }
    
    //編集ボタンが押下された時の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let groupRef: CollectionReference? = db.collection("groups").document(keyID!).collection("products")

        //dataを消してから
        groupRef?.document(productId[indexPath.row]).delete()
            { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                    self.productTitle.remove(at: indexPath.row)
                    self.productNumber.remove(at: indexPath.row)
                    self.productId.remove(at: indexPath.row)
                    
                    //tableViewCellの削除
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
        }
        reloadProduct()
//        //dataを消してから
//        productTitle.remove(at: indexPath.row)
//        productNumber.remove(at: indexPath.row)
//        //tableViewCellの削除
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//        productTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //商品一覧リロード
    func reloadProduct() {
        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        var group = db.collection("users").document(uid!).collection("mygroups")
        let ref: CollectionReference? =  db.collection("groups").document(keyID!).collection("products")
        //指定した配列の要素番号もってくる処理書け
        
        ref?.getDocuments{(DocumentSnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.productTitle.removeAll()
                for document in DocumentSnapshot!.documents {
                    self.productTitle.append(String(describing: document.get("name")!))
                    self.productId.append(String(describing: document.documentID))
                    self.productNumber.append((document.get("number"))as! Int)
                }
                self.productTable.reloadData()
            }
        }
    
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

