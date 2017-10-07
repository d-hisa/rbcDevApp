//
//  ContentDetailViewController.swift
//  rbcDevApp
//
//  Created by nttr on 2017/09/13.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class ContentDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedContentIndex: Int = 0
    var selectedContentBelongingCategory: Category = Category()
    var thisContent: Contents = Contents()
    
    @IBOutlet var contentMetadataTableView: UITableView!
    
    @IBOutlet var contentTitleLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        thisContent = selectedContentBelongingCategory.catContensArray[selectedContentIndex]
        //contentTitleLabel.text = thisContent.conName
        self.title = thisContent.conName
        contentImageView.image = thisContent.conImage
        
        contentMetadataTableView.dataSource = self
        contentMetadataTableView.delegate = self
        let nib = UINib(nibName: "ContentMetadataTableViewCell", bundle: Bundle.main)
        contentMetadataTableView.register(nib, forCellReuseIdentifier: "contentMetadataCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppper")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Sectionの数を設定
    func numberOfSections(in tableView: UITableView) -> Int {
        return thisContent.conMetaDataArray.count
    }
    
    // Sectionのタイトルを設定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return thisContent.conMetaDataArray[section].name
    }
    
    // Cellの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1    // 1 section に対して1 row
    }
    
    // Cellの内容を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentMetadataCell") as! ContentMetadataTableViewCell
        let mData: metaData = thisContent.conMetaDataArray[indexPath.section]
        switch mData.myType {
        case .freeFormat:
            cell.textDataLabel.text = mData.text
            cell.unitDataLabel.text = ""
            cell.imageDataImageView.isHidden = true
        case .numericFormat:
            cell.textDataLabel.text = String(mData.value)
            cell.unitDataLabel.text = ""
            cell.imageDataImageView.isHidden = true
        case .numericWithUnitFormat:
            cell.textDataLabel.text = String(mData.value)
            cell.unitDataLabel.text = mData.text
            cell.imageDataImageView.isHidden = true
        case .imageFormat:
            cell.textDataLabel.text = ""
            cell.unitDataLabel.text = ""
            cell.imageDataImageView.isHidden = false
            cell.imageDataImageView.image = mData.image
        case .dateFormat:
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ja_JP")
            dateFormatter.dateFormat = "yyyy/MM/dd"
            cell.textDataLabel.text = dateFormatter.string(from: Calendar.current.date(from: mData.date)!)
            cell.unitDataLabel.text = ""
            cell.imageDataImageView.isHidden = true
        case .colorFormat:
            cell.backgroundColor = mData.color
            cell.textDataLabel.text = ""
            cell.unitDataLabel.text = ""
            cell.imageDataImageView.isHidden = true
        }
        return cell
    }
    


}
