//
//  ContentDetailViewController.swift
//  rbcDevApp
//
//  Created by nttr on 2017/09/13.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class ContentDetailViewController: UIViewController {
    
    var selectedContentIndex: Int = 0
    var selectedContentBelongingCategory: Category = Category()
    var thisContent: Contents = Contents()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
