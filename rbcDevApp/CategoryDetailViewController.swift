//
//  CategoryDetailViewController.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/10/01.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var colorLabel:UILabel!
    @IBOutlet var metadataTableView:UITableView!
    var delegateCategory:CategoryObject = CategoryObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        metadataTableView.dataSource = self
        metadataTableView.delegate = self
        metadataTableView.tableFooterView = UIView()
        delegateCategory.decodeData()
        let nib : UINib = UINib(nibName:"CategoryMetadataPresetTableViewCell",bundle: Bundle.main)
        metadataTableView.register(nib, forCellReuseIdentifier: "metaDataPresetCell")
        titleLabel.text = delegateCategory.catName
        colorLabel.backgroundColor = delegateCategory.catBackColor
        colorLabel.textColor = delegateCategory.catTextColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegateCategory.metaDataPresetsObjArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "metaDataPresetCell", for: indexPath) as! CategoryMetadataPresetTableViewCell
        cell.numberingLabel.text = String(indexPath.row + 1)
        cell.nameLabel.text = delegateCategory.metaDataPresetsObjArray[indexPath.row].mpName
        cell.formatLabel.text = delegateCategory.metaDataPresetsObjArray[indexPath.row].mpFormat
        cell.unitLabel.text = delegateCategory.metaDataPresetsObjArray[indexPath.row].mpUnit
        cell.deleteLabel.backgroundColor = UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
