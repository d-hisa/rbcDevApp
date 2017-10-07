//
//  CommonTabBarController.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/10/07.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class CommonTabBarController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if viewController is AddContentViewController {
            if let currentVC = self.selectedViewController as! AddContentViewController! {
                currentVC.categoryTableView.reloadData()
                currentVC.noticeLabel.isHidden = true
            }
            print("Tapped AddContentView")
            return false
        }
        return true
    }

}
