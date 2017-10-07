//
//  AddContentViewController.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/08/30.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import RealmSwift

class AddContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var categoryTableView: UITableView!
    @IBOutlet var noticeLabel:UILabel!
    var selectedindexRow:Int = 0
    let refreshCtrl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let count:Int = realm.objects(CategoryObject.self).count
        if count != 0{
            noticeLabel.isHidden = true
        }else{
            noticeLabel.isHidden = false
        }
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.tableFooterView = UIView()
        categoryTableView.refreshControl = refreshCtrl
        refreshCtrl.addTarget(self, action: #selector(self.refresh(sender:)), for: .valueChanged)
        let nib : UINib = UINib(nibName:"CategoryListTableViewCell",bundle: Bundle.main)
        categoryTableView.register(nib, forCellReuseIdentifier: "CategoryCell")
        categoryTableView.reloadData()
    }
    // 引き下げ更新の処理
    func refresh(sender: UIRefreshControl) {
        categoryTableView.reloadData()
        sender.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        return realm.objects(CategoryObject.self).count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryListTableViewCell
        
        let realm = try! Realm()
        let tmpCat:CategoryObject = realm.objects(CategoryObject.self)[indexPath.row]
        tmpCat.decodeData()
        cell.categoryLabel.text = tmpCat.catName
        cell.backgroundColor = tmpCat.catBackColor
        cell.categoryLabel.textColor = tmpCat.catTextColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedindexRow = indexPath.row
        self.performSegue(withIdentifier: "toAddContent", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toAddContent"?:
            if ((segue.destination as! InputContentDataViewController) != nil){
                let inputContentDataViewController = segue.destination as! InputContentDataViewController
                let realm = try! Realm()
                let tmpCat = realm.objects(CategoryObject.self)[selectedindexRow]
                inputContentDataViewController.categoryObj = tmpCat
            }
        case .none:
            break
        case .some(_):
            break
        }
    }
    @IBAction func unwindToAddMenu(segue:UIStoryboardSegue){
        // pass
    }

}
