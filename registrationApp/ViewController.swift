//
//  ViewController.swift
//  registrationApp
//
//  Created by 手嶋慧太 on 2018/09/20.
//  Copyright © 2018年 手嶋慧太. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var GroupTitle:[String] = []
    
    @IBOutlet weak var GroupTable: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    //ここに戻ってくる時の処理
    @IBAction func GoToViewController(_ segue : UIStoryboardSegue){
        guard let source = segue.source as? GroupRegistrationViewController else {
            fatalError()
        }
        if let text = source.nameTextField!.text {
            GroupTitle.append(text)
            GroupTable.reloadData()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GroupTable.delegate = self
        GroupTable.dataSource = self
    
        //セルの編集buttonの追加
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = editButtonItem
        GroupTable.reloadData()
    }
    
    // Table Viewにいくつのセルを表示するかを指定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupTitle.count
    }
    
    // セルに表示する値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // データを表示するセルを取得する
        let GroupCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Groupcell", for: indexPath)
        
        // セルに表示する値を設定する
        GroupCell.textLabel!.text = GroupTitle[indexPath.row]
        GroupCell.accessoryType = UITableViewCell.AccessoryType.detailButton
        
        // データを設定したセルを返却する
        return GroupCell
    }
    //セルの編集
    override func setEditing(_ editing: Bool, animated: Bool) {
        //override前の処理を継続してさせる
        super.setEditing(editing, animated: animated)
        GroupTable.isEditing = editing
        
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
    
    //編集ボタンが押下された時の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //dataを消してから
        GroupTitle.remove(at: indexPath.row)
        //tableViewCellの削除
        tableView.deleteRows(at: [indexPath], with: .automatic)
        GroupTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
} 

