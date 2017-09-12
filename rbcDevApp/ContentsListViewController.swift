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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define scroll page contoller array
        var controllerArray : [UIViewController] = []
        
        // Define contorollers each contents lists
        // ex.)
        // var controller : UIViewController = ContetnsListBuCategoryViewController
        // controller.title = "hoge"
        // controllerArray.append(controller)
        
        for i in 1...4 {
            //let controller = UITableViewController(nibName: "ContentsListTableViewController",bundle:nil)
            let controller = ContentsListTableViewController()
            controller.title = "MENU" + String(i)
            controllerArray.append(controller)
        }
        
        
        /*
         
        var controller : UIViewController = ContentsListByCategoryViewController()
        controller.title = "sample 1"
        controllerArray.append(controller)
        var controller2 : UIViewController = ContentsListByCategoryViewController()
        controller2.title = "sample 2"
        controllerArray.append(controller2)
        */
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
        self.view.addSubview(pageMenu!.view)
        // Optional delegate
        pageMenu!.delegate = self as? CAPSPageMenuDelegate
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
