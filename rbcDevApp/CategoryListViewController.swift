//
//  CategoryListViewController.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/08/30.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var categoryTableView:UITableView!
    
    var categoryArray:[Category] = [
        Category(name: "hoge", code: "22", color: Azusa().cyan.light, textColor: Azusa().getUseTextColor(level: Azusa.levelNum.light, colorNum: Azusa().cyan.num)),
        Category(name: "fuga", code: "3332", color: Azusa().orange.main, textColor: Azusa().getUseTextColor(level: Azusa.levelNum.main, colorNum: Azusa().orange.num))
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryListTableViewCell
        cell.categoryLabel.text = categoryArray[indexPath.row].catName
        cell.backgroundColor = categoryArray[indexPath.row].catBackColor
        cell.categoryLabel.textColor = categoryArray[indexPath.row].catTextColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetailCategory", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.tableFooterView = UIView()
        let nib : UINib = UINib(nibName:"CategoryListTableViewCell",bundle: Bundle.main)
        categoryTableView.register(nib, forCellReuseIdentifier: "CategoryCell")
        categoryTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // editボタンが押されたらエディットモードへ遷移
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        categoryTableView.isEditing = editing
    }
    
    // 削除可能なセルを設定（すべてを許可）
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // テーブルの元データアレイを更新
        categoryArray.remove(at: indexPath.row)
        // テーブルビューを更新
        categoryTableView.reloadData()
        //categoryTableView.deleteRows(at: [IndexPath(forRow: indexPath.row, inSection: 0) as IndexPath], with: UITableViewRowAnimation.fade)
    }
    // 移動可能なセルを設定（すべてを許可）
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ((segue.destination as! CategoryDetailViewController) != nil){
            // delegate value process
        }
    }
    

}
