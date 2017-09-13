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
        return mainText.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ContentsListTableViewCell",
            for: indexPath
            ) as! ContentsListTableViewCell
        cell.mainText.text = mainText[indexPath.row]
        cell.subText.text = subText[indexPath.row]
        cell.contentImage.image = contentsImage[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let storyborad:UIStoryboard = self.storyboard!
        //let detailContentView = storyboard?.instantiateViewController(withIdentifier: "detailContentView") as! ContentDetailViewController
        //self.presentedViewController(detailContentView, animated: true, completion: nil)
        self.performSegue(withIdentifier: "toDetailContent", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
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
