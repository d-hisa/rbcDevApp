//
//  ContentDetailViewController.swift
//  rbcDevApp
//
//  Created by nttr on 2017/09/13.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import RealmSwift

class ContentDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var selectedContentBelongingCategoryName: String = ""
    var thisContent: ContentObject = ContentObject()
    
    @IBOutlet var contentMetadataTableView: UITableView!
    
    @IBOutlet var contentTitleLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let editActionButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: self, action: #selector(ContentDetailViewController.clickEditableAction))
        let trashActionButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: self, action: #selector(ContentDetailViewController.clickTrashAction))
        self.navigationItem.setRightBarButtonItems([editActionButton, trashActionButton], animated: true)


        self.title = thisContent.conName
        contentImageView.image = thisContent.conImage
        
        contentMetadataTableView.dataSource = self
        contentMetadataTableView.delegate = self
        let nib = UINib(nibName: "ContentMetadataTableViewCell", bundle: Bundle.main)
        contentMetadataTableView.register(nib, forCellReuseIdentifier: "contentMetadataCell")
    }
    func clickTrashAction(){
        let alert = UIAlertController(title: "このコンテンツを消しますがよろしいですか？", message: "消えたデータは元には戻りません", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: {
            (action:UIAlertAction!) -> Void in
            let realm = try! Realm()
            let withMetadata = realm.objects(MetadataObject.self).filter("mBelongingContent like '" + self.thisContent.conName + "'")
            try! realm.write {
                for wM in withMetadata{
                    realm.delete(wM)
                }
                realm.delete(self.thisContent)
            }
            self.performSegue(withIdentifier: "toContentList", sender: nil)
        })
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "cancel", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            return
        })
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func clickEditableAction(){
        performSegue(withIdentifier: "toEditContent", sender: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppper")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Sectionの数を設定
    func numberOfSections(in tableView: UITableView) -> Int {
        return thisContent.conMetadataObjArray.count
    }
    
    // Sectionのタイトルを設定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return thisContent.conMetadataObjArray[section].mName
    }
    
    // Cellの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1    // 1 section に対して1 row
    }
    
    // Cellの内容を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentMetadataCell") as! ContentMetadataTableViewCell
        let mData: MetadataObject = thisContent.conMetadataObjArray[indexPath.section]
        mData.decodeData()
        let type = MetadataObject.mType.self
        switch mData.mType {
        case type.freeFormat.rawValue:
            cell.textDataLabel.text = mData.mText
            cell.unitDataLabel.text = ""
            cell.imageDataImageView.isHidden = true
        case type.numericFormat.rawValue:
            cell.textDataLabel.text = String(mData.mValue)
            cell.unitDataLabel.text = ""
            cell.imageDataImageView.isHidden = true
        case type.numericWithUnitFormat.rawValue:
            cell.textDataLabel.text = String(mData.mValue)
            cell.unitDataLabel.text = mData.mText
            cell.imageDataImageView.isHidden = true
        case type.imageFormat.rawValue:
            cell.textDataLabel.text = ""
            cell.unitDataLabel.text = ""
            cell.imageDataImageView.isHidden = false
            cell.imageDataImageView.image = mData.mImage
        case type.dateFormat.rawValue:
            /*
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ja_JP")
            dateFormatter.dateFormat = "yyyy/MM/dd"
            cell.textDataLabel.text = dateFormatter.string(from: Calendar.current.date(from: mData.date)!)*/
            cell.textDataLabel.text = mData.mDate.date2stringY4M2D2sepSrash()
            cell.unitDataLabel.text = ""
            cell.imageDataImageView.isHidden = true
        case type.colorFormat.rawValue:
            cell.backgroundColor = mData.mColor
            cell.textDataLabel.text = ""
            cell.unitDataLabel.text = ""
            cell.imageDataImageView.isHidden = true
        default:
            cell.textDataLabel.text = "invalid metadata format."
            cell.unitDataLabel.text = "connot read this data."
            cell.imageDataImageView.isHidden = true
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toEditContent"?:
            if ((segue.destination as! InputContentDataViewController) != nil){
                let inputContentDataViewController = segue.destination as! InputContentDataViewController
                let realm = try! Realm()
                inputContentDataViewController.categoryObj = realm.objects(CategoryObject.self).filter("catName like '" + selectedContentBelongingCategoryName + "'")[0]
                inputContentDataViewController.contentObj = thisContent
                inputContentDataViewController.tempMetadataObjArray = thisContent.conMetadataObjArray
            }
        case .none:
            break
        case .some(_):
            break
        }
    }
    @IBAction func unwindToContentDetail(segue:UIStoryboardSegue){
        contentMetadataTableView.reloadData()
    }
    


}
