//
//  ContentListViewController.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/10/07.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ContentListViewController: ButtonBarPagerTabStripViewController {

    //@IBOutlet var contentListView:UIScrollView!
    //@IBOutlet var categoryTabView:PagerTabStripViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var listedViewControllers:[UIViewController] = []
        var demoDataCatArray: [Category] = demoDatas().categoryArray
        
        for i in 0 ..< demoDataCatArray.count{
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller = storyboard.instantiateViewController(withIdentifier: "ContentsListTableViewController") as! ContentsListTableViewController
            controller.itemInfo = IndicatorInfo(stringLiteral: demoDataCatArray[i].catName)
            controller.title = demoDataCatArray[i].catName
            controller.category = demoDataCatArray[i]
            listedViewControllers.append(controller)
        }
        return listedViewControllers
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
