//
//  ContentsListTableViewController.swift
//  rbcDevApp
//
//  Created by nttr on 2017/09/12.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class ContentsListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, IndicatorInfoProvider {
    
    var itemInfo: IndicatorInfo = "RED"
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    var mainText: [String] = ["iPhone7","iPad Pro 9.7","AppleWatch2"]
    var subText: [String] = ["MNCJ2J/A","MM172J/A","MNT22J/A"]
    var contentsImage: [UIImage] = [
        UIImage(named: "sample_iphone.jpg")!,
        UIImage(named: "sample_ipad.jpg")!,
        UIImage(named: "sample_appleWatch.jpg")!
        ]
    
    var category:Category = Category()
    var contentsObj:[ContentObject] = []
    let refreshCtrl = UIRefreshControl()
    
    @IBOutlet var contentsListTableViews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        contentsObj = Array(realm.objects(ContentObject.self).filter("conBelongingCategory like '" + self.title! + "'"))
        contentsListTableViews.delegate = self
        contentsListTableViews.dataSource = self
        contentsListTableViews.tableFooterView = UIView()
        contentsListTableViews.refreshControl = refreshCtrl
        refreshCtrl.addTarget(self, action: #selector(self.refresh(sender:)), for: .valueChanged)
        let nib : UINib = UINib(nibName:"ContentsListTableViewCell",bundle: Bundle.main)
        contentsListTableViews.register(nib,forCellReuseIdentifier:"ContentsListTableViewCell")
        contentsListTableViews.reloadData()
    }
    func refresh(sender: UIRefreshControl) {
        let realm = try! Realm()
        contentsObj = Array(realm.objects(ContentObject.self).filter("conBelongingCategory like '" + self.title! + "'"))
        for cObj in contentsObj{
            cObj.decodeData()
            for mData in cObj.conMetadataObjArray{
                mData.decodeData()
            }
        }
        contentsListTableViews.reloadData()
        sender.endRefreshing()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsObj.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ContentsListTableViewCell",
            for: indexPath
            ) as! ContentsListTableViewCell
        let thisContent:ContentObject = contentsObj[indexPath.row]
        thisContent.decodeData()
        
        cell.mainText.text = thisContent.conName
        cell.contentImage.image = thisContent.conImage
        if thisContent.conMetadataObjArray.count == 0{
            cell.subText.text = "-"
        }else{
            let firstMetaObj = thisContent.conMetadataObjArray[0]
            firstMetaObj.decodeData()
            let type = MetadataObject.mType.self
            let thisType:String = firstMetaObj.mType
            switch thisType{
            case type.freeFormat.rawValue:
                cell.subText.text = firstMetaObj.mText
            case type.numericFormat.rawValue:
                cell.subText.text = String(firstMetaObj.mValue)
            case type.numericWithUnitFormat.rawValue:
                cell.subText.text = String(firstMetaObj.mValue)
            case type.dateFormat.rawValue:
                cell.subText.text = firstMetaObj.mDate.date2stringY4M2D2sepSrash()
            case type.imageFormat.rawValue:
                cell.subText.text = "-"
            case type.colorFormat.rawValue:
                cell.subText.text = "Color"
                cell.subText.backgroundColor = firstMetaObj.mColor
            default:
                cell.subText.text = "-"
            }
        }
        /*
        switch thisContent.conMetaDataArray[0].myType{
        case .freeFormat:
            cell.subText.text = thisContent.conMetaDataArray[0].text
        case .numericFormat:
            cell.subText.text = String(thisContent.conMetaDataArray[0].value)
        case .numericWithUnitFormat:
            cell.subText.text = String(thisContent.conMetaDataArray[0].value) + " " + thisContent.conMetaDataArray[0].text
        default:
            cell.subText.text = "no metadata or missing myType."
        }
        
        if thisContent.conMetaDataArray[0].myType == metaData.mType.freeFormat{
            cell.subText.text = thisContent.conMetaDataArray[0].text
        }else if thisContent.conMetaDataArray[0].myType == metaData.mType.numericFormat{
            cell.subText.text = String(thisContent.conMetaDataArray[0].value)
        }
        //cell.subText.text = (category.catContensArray[indexPath.row].conMetaDataArray[0].text
        cell.contentImage.image = category.catContensArray[indexPath.row].conImage
        */
        return cell
    }
    
    // セルがタップされたときの挙動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let storyborad:UIStoryboard = self.storyboard!
        //let detailContentView = storyboard?.instantiateViewController(withIdentifier: "detailContentView") as! ContentDetailViewController
        //self.presentedViewController(detailContentView, animated: true, completion: nil)
        self.performSegue(withIdentifier: "toDetailContent", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // セグエの挙動を制御
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ((segue.destination as! ContentDetailViewController) != nil){
            let contentDetailViewController = segue.destination as! ContentDetailViewController
            contentDetailViewController.thisContent = contentsObj[contentsListTableViews.indexPathForSelectedRow!.row]
            contentDetailViewController.selectedContentBelongingCategoryName = itemInfo.title
        }
    }
    @IBAction func unwindToContentList(segue:UIStoryboardSegue){
        self.viewDidLoad()
        contentsListTableViews.reloadData()
    }
    
}
