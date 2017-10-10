//
//  ContetsListViewController.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/08/30.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class ContentsListViewController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        //バーの色
        settings.style.buttonBarBackgroundColor = UIColor(red: 73/255, green: 72/255, blue: 62/255, alpha: 1)
        //ボタンの色
        settings.style.buttonBarItemBackgroundColor = UIColor(red: 73/255, green: 72/255, blue: 62/255, alpha: 1)
        //セルの文字色
        settings.style.buttonBarItemTitleColor = UIColor.white
        //セレクトバーの色
        settings.style.selectedBarBackgroundColor = UIColor(red: 254/255, green: 0, blue: 124/255, alpha: 1)
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var listedViewControllers:[UIViewController] = []
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let catObjects = realm.objects(CategoryObject.self)
        if catObjects.count > 0{
            for cObj in catObjects{
                cObj.decodeData()
                let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContentsListTableViewController") as! ContentsListTableViewController
                controller.itemInfo = IndicatorInfo(stringLiteral: cObj.catName)
                controller.title = cObj.catName
                controller.contentsObj = Array(realm.objects(ContentObject.self).filter("conBelongingCategory like '" + cObj.catName + "'"))
                listedViewControllers.append(controller)
            }
        }else{
            let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContentsListTableViewController") as! ContentsListTableViewController
            controller.itemInfo = IndicatorInfo(stringLiteral: "NoCategories")
            controller.title = "カテゴリがありません"
            var tempContent = ContentObject(name: "カテゴリがありません", withCat: "NoCategories")
            tempContent.conImage = Defaults().image
            tempContent.encodeData()
            controller.contentsObj.append(tempContent)
            listedViewControllers.append(controller)
        }
        

        /*
        var demoDataCatArray: [Category] = demoDatas().categoryArray
        for i in 0 ..< demoDataCatArray.count{
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller = storyboard.instantiateViewController(withIdentifier: "ContentsListTableViewController") as! ContentsListTableViewController
            controller.itemInfo = IndicatorInfo(stringLiteral: demoDataCatArray[i].catName)
            controller.title = demoDataCatArray[i].catName
            controller.category = demoDataCatArray[i]
            listedViewControllers.append(controller)
        }
 */
        return listedViewControllers
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
