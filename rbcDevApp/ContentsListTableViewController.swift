//
//  ContentsListTableViewController.swift
//  rbcDevApp
//
//  Created by nttr on 2017/09/12.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class ContentsListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var mainText: [String] = ["iPhone7","iPad Pro 9.7","AppleWatch2"]
    var subText: [String] = ["MNCJ2J/A","MM172J/A","MNT22J/A"]
    var contentsImage: [UIImage] = [
        UIImage(named: "sample_iphone.jpg")!,
        UIImage(named: "sample_ipad.jpg")!,
        UIImage(named: "sample_appleWatch.jpg")!
        ]
    
    var category:Category = Category()
    
    @IBOutlet var contentsListTableViews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentsListTableViews.delegate = self
        contentsListTableViews.dataSource = self
        contentsListTableViews.tableFooterView = UIView()
        
        let nib : UINib = UINib(nibName:"ContentsListTableViewCell",bundle: Bundle.main)
        contentsListTableViews.register(nib,forCellReuseIdentifier:"ContentsListTableViewCell")
        contentsListTableViews.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.catContensArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ContentsListTableViewCell",
            for: indexPath
            ) as! ContentsListTableViewCell
        
        let thisContent:Contents = category.catContensArray[indexPath.row]
        
        cell.mainText.text = thisContent.conName
        
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
            let selectedIndexPath = contentsListTableViews.indexPathForSelectedRow!
            let selectedContentBelongingCategory = category
            
            contentDetailViewController.selectedContentIndex = selectedIndexPath.row
            contentDetailViewController.selectedContentBelongingCategory = selectedContentBelongingCategory
            
            
        }
    }
    
}
