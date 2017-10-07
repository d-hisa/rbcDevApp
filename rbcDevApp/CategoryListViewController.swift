//
//  CategoryListViewController.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/08/30.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var categoryTableView:UITableView!

    var category:[CategoryObject] = []
    // Cellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        return realm.objects(CategoryObject.self).count
    }
    
    // Cellの表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryListTableViewCell
        cell.categoryLabel.text = category[indexPath.row].catName
        cell.backgroundColor = category[indexPath.row].catBackColor
        cell.categoryLabel.textColor = category[indexPath.row].catTextColor
        return cell
    }
    
    // Cellをタップされたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetailCategory", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Cellの高さを指定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func realm2category()->[CategoryObject]{
        var catObj:[CategoryObject] = []
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let realmObj = realm.objects(CategoryObject.self)
        for i in 0..<realmObj.count{
            catObj.append(realmObj[i])
            catObj[i].decodeData()
        }
        return catObj
    }
    
    func updateTableView(){
        category = realm2category()
        categoryTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        category = realm2category()
        
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
    func deleteRealm(index:Int){
        let realm = try! Realm()
        print(index)
        print(realm.objects(CategoryObject.self).count)
        
        if let targetObject:CategoryObject = realm.objects(CategoryObject.self)[index]{
            // 消す対象のカテゴリに属するMetadataPreset
            let targetRelationMetadataPresetObjs = realm.objects(MetadataPresetObject.self).filter("mpBelongCategory like '" + targetObject.catName + "'")
            // 消す対象のカテゴリに属するContents
            let targetRelationContentObjs = realm.objects(ContentObject.self).filter("conBelongingCategory like '" + targetObject.catName + "'")
            // 消す対象のカテゴリに属するContentに属するMetadata
            var targetRelationMeataObjs:[Results<MetadataObject>] = []
            for tRCO in targetRelationContentObjs{
                targetRelationMeataObjs.append(realm.objects(MetadataObject.self).filter("mBelongingContent like '" + tRCO.conName + "'"))
            }
            try! realm.write {
                realm.delete(targetObject)
                realm.delete(targetRelationMetadataPresetObjs)
                realm.delete(targetRelationContentObjs)
                for tRMO in targetRelationMeataObjs{
                    realm.delete(tRMO)
                }
            }
        }else{
            showErrorAlert()
        }
    }
    func showErrorAlert(){
        let alert = UIAlertController(title: "削除処理に問題が発生しました", message: "再度お試しください", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    // TableViewがEditされたときの処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // テーブルの元データアレイを更新
        category.remove(at: indexPath.row)
        
        deleteRealm(index: indexPath.row)
        // テーブルビューを更新
        categoryTableView.reloadData()

        categoryTableView.isEditing = false
    }
    // 移動可能なセルを設定（すべてを許可）
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toDetailCategory"?:
            if ((segue.destination as! CategoryDetailViewController) != nil){
                let categoryDetailViewController = segue.destination as! CategoryDetailViewController
                categoryDetailViewController.delegateCategory = category[categoryTableView.indexPathForSelectedRow!.row]
            }
        case "toAddCategory"?:
            if ((segue.destination as! CategoryAddViewController) != nil){
                // delegate value process
            }
        
        case .none:
            break
        case .some(_):
            break
        }
    }
    

}
