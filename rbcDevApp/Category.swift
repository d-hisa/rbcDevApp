//
//  Category.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/08/30.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

struct Category {
    var catName: String = ""
    var catCode: String = ""
    var catTextColor: UIColor = UIColor()
    var catBackColor: UIColor = UIColor()
    var catContensArray: [Contents] = []
    var metaDataPresetArray:[metaData] = []
    
    init() {
        self.catName = "untitled"
        self.catCode = "0"
        self.catBackColor = Defaults().backColor
        self.catTextColor = Defaults().textColor
    }
    
    init(name:String,code:String,color:UIColor,textColor:UIColor){
        self.catName = name
        self.catCode = code
        self.catBackColor = color
        self.catTextColor = textColor
    }
    
    mutating func addMetaData2Preset(md:metaData){
        metaDataPresetArray.append(md)
    }
    
    mutating func addContent(content:Contents){
        catContensArray.append(content)
    }
    
}
