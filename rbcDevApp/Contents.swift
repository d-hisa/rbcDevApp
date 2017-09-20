//
//  Contents.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/08/30.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class Contents{
    var conName:String = ""
    var conImage:UIImage = UIImage()
    var conMetaDataArray: [metaData] = []
    
    ///////////// Constructor /////////////
    init(){
        self.conName = "untitled"
        self.conImage = Defaults().image
    }
    
    init(name: String){
        self.conName = name
        self.conImage = Defaults().image
    }
    ///////////////////////////////////////
    
    func addMetaData(mData:metaData){
        conMetaDataArray.append(mData)
    }
}
