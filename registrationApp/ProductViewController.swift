//
//  ProductViewController.swift
//  registrationApp
//
//  Created by 手嶋慧太 on 2018/10/10.
//  Copyright © 2018年 手嶋慧太. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var productTitle:[String] = []
    
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    //ここに戻ってくる時の処理
    @IBAction func GoToProductViewController(_ segue : UIStoryboardSegue){
        guard let source = segue.source as? AddProductViewController else {
            fatalError()
        }
        if let text = source.productName!.text {
            productTitle.append(text)
            productTable.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        productTable.delegate = self
        productTable.dataSource = self
        
        //セルの編集buttonの追加
        //self.navigationController?.isNavigationBarHidden = false
        //navigationItem.rightBarButtonItem = editButtonItem
        //productTable.reloadData()
    }
    
    // Table Viewにいくつのセルを表示するかを指定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productTitle.count
    }
    
    // セルに表示する値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // データを表示するセルを取得する
        let productCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        
        // セルに表示する値を設定する
        productCell.textLabel!.text = productTitle[indexPath.row]
        
        // データを設定したセルを返却する
        return productCell
    }
    //セルの編集
    //override func setEditing(_ editing: Bool, animated: Bool) {
        //override前の処理を継続してさせる
        //super.setEditing(editing, animated: animated)
        //productTable.isEditing = editing
        
        //addButton有効化，無効化
        //if editing {
            //addButton.isEnabled = true
            //self.navigationItem.hidesBackButton = false
        //}
        //else{
            //addButton.isEnabled = false
            //self.navigationItem.hidesBackButton = true
        //}
    //}
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //編集ボタンが押下された時の処理
    //func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //dataを消してから
        //productTitle.remove(at: indexPath.row)
        //tableViewCellの削除
        //tableView.deleteRows(at: [indexPath], with: .automatic)
        //productTable.reloadData()
    //}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

