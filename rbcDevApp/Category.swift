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

    var cName: String = ""
    var cCode: String = ""
    var cColor: UIColor = UIColor.black
    var cTextColor: UIColor = UIColor.white
    var cMetaDataArray: [metaData] = []
    
    init() {
        self.cName = "untitled"
        self.cCode = "0"
        self.cColor = UIColor.white
        self.cTextColor = UIColor.black
        initializeMetaData()
    }
    
    init(name:String,code:String,color:UIColor,textColor:UIColor){
        self.cName = name
        self.cCode = code
        self.cColor = color
        self.cTextColor = textColor
        initializeMetaData()
    }
    
    func initializeMetaData(){
        cMetaDataArray.append(metaData(name: "MainText", type: metaData.mType.freeFormat))
        cMetaDataArray.append(metaData(name: "SubText", type: metaData.mType.freeFormat))
    }
    
}
