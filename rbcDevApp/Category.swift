//
//  Category.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/08/30.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class Category {
    // Category set
    // name: Electronics
    // code: 0
    // color: black
    // textColor: white

    var name: String = ""
    var code: String = ""
    var color: UIColor = UIColor.black
    var textColor: UIColor = UIColor.white
    
    init() {
        name = "untitled cattegory"
        code = "0"
        color = UIColor.white
        textColor = UIColor.black
    }
    
    init(name:String,code:String,color:UIColor,textColor:UIColor){
        self.name = name
        self.code = code
        self.color = color
        self.textColor = textColor
    }
    
}
