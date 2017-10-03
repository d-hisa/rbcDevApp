//
//  Category.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/08/30.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryObject: Object {
    dynamic var catName: String = ""
    dynamic var catTextColor: UIColor = UIColor()
    dynamic var catTextColorData: NSData = NSData()
    dynamic var catBackColor: UIColor = UIColor()
    dynamic var catBackColorData: NSData = NSData()
    
    convenience required init() {
        self.init()
        self.catName = "untitled"
        self.catBackColor = Defaults().backColor
        self.catTextColor = Defaults().textColor
    }
    
    convenience init(name:String,color:UIColor,textColor:UIColor){
        self.init()
        self.catName = name
        self.catBackColor = color
        self.catTextColor = textColor
    }
}

