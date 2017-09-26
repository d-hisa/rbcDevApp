//
//  ContetsListViewController.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/08/30.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import PageMenu

class ContentsListViewController: UIViewController {

    var pageMenu: CAPSPageMenu?
    
    var demoCategoryArray: [Category] = [
        Category(name: "Apple",code: "1",color: UIColor.white,textColor: UIColor.black),
        Category(name: "Device",code: "2",color: UIColor.white,textColor: UIColor.black),
        Category(name: "Cloth",code: "3",color: UIColor.white,textColor: UIColor.black)
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define scroll page contoller array
        var controllerArray : [UIViewController] = []
        var demoDataCatArray: [Category] = demoDatas().categoryArray
        
        for i in 0 ..< demoDataCatArray.count{
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller = storyboard.instantiateViewController(withIdentifier: "ContentsListTableViewController") as! ContentsListTableViewController
            controller.title = demoDataCatArray[i].catName
            controller.category = demoDataCatArray[i]
            controllerArray.append(controller)
        }
        /*
        for i in 0 ..< demoCategoryArray.count {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller = storyboard.instantiateViewController(withIdentifier: "ContentsListTableViewController") as! ContentsListTableViewController
            controller.title = demoCategoryArray[i].catName
            controller.category = demoCategoryArray[i]
            controllerArray.append(controller)
        }*/

        var parameters: [CAPSPageMenuOption] = [
            // テキストタイトルの幅にタブ幅を追従
            .menuItemWidthBasedOnTitleTextWidth(true),
            // スクロールメニューの背景色
            .scrollMenuBackgroundColor(UIColor.white),
            // タブ自体の背景色
            .viewBackgroundColor(UIColor.white),
            // タブメニュー自体の下線の色
            .bottomMenuHairlineColor(UIColor.blue),
            // 選択されているタブの下線の色
            .selectionIndicatorColor(UIColor.red),
            // メニューのフォント設定
            .menuItemFont(UIFont(name: "HelveticaNeue", size: 14.0)!),
            // タブ内テキストの中央揃え？
            .centerMenuItems(true),
            // メニューの余白
            .menuMargin(16),
            // 選択されたタブの（文字の）色
            .selectedMenuItemLabelColor(UIColor.black),
            // 選択されていないタブの（文字の）色
            .unselectedMenuItemLabelColor(UIColor.gray)
        ]
        
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(
            viewControllers: controllerArray,
            frame: CGRect(x:0.0,y: 0.0, width:self.view.frame.width, height:self.view.frame.height),
            pageMenuOptions: parameters
        )
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.addChildViewController(self.pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        // Optional delegate
        pageMenu!.delegate = self as? CAPSPageMenuDelegate
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
