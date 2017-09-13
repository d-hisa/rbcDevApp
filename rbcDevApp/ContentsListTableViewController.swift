//
//  ContentsListTableViewController.swift
//  rbcDevApp
//
//  Created by nttr on 2017/09/12.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class ContentsListTableViewController: UITableViewController {
    
    var mainText: [String] = ["iPhone7","iPad Pro 9.7","AppleWatch2"]
    var subText: [String] = ["MNCJ2J/A","MM172J/A","MNT22J/A"]
    var contentsImage: [UIImage] = [
        UIImage(named: "sample_iphone.jpg")!,
        UIImage(named: "sample_ipad.jpg")!,
        UIImage(named: "sample_appleWatch.jpg")!
        ]
    
    var category:Category = Category()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib : UINib = UINib(nibName:"ContentsListTableViewCell",bundle: Bundle.main)
        self.tableView.register(nib,forCellReuseIdentifier:"ContentsListTableViewCell")
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainText.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ContentsListTableViewCell",
            for: indexPath
            ) as! ContentsListTableViewCell
        cell.mainText.text = mainText[indexPath.row]
        cell.subText.text = subText[indexPath.row]
        cell.contentImage.image = contentsImage[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let storyborad:UIStoryboard = self.storyboard!
        //let detailContentView = storyboard?.instantiateViewController(withIdentifier: "detailContentView") as! ContentDetailViewController
        //self.presentedViewController(detailContentView, animated: true, completion: nil)
        self.performSegue(withIdentifier: "toDetailContent", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ((segue.destination as! ContentDetailViewController) != nil){
            let contentDetailViewController = segue.destination as! ContentDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            let selectedContentBelongingCategory = category
            
            contentDetailViewController.selectedContentIndex = selectedIndexPath.row
            contentDetailViewController.selectedContentBelongingCategory = selectedContentBelongingCategory
            
            
        }
    }
    
}
