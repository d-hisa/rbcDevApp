//
//  metaData.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/08/30.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class metaData{
    
    enum mType: String{
        case freeFormat             = "freeFormat"
        case numericFormat          = "numericFormat"
        case dateFormat             = "dateFormat"
        case numericWithUnitFormat  = "numericWithUnitFormat"
        case colorFormat            = "colorFormat"
        case imageFormat            = "imageFormat"
    }
    
    var mName: String = ""
    var metaDataFormat: [[String:Any]] = [[:]]
    
    init(name: String, type: mType){
        self.mName = name
        switch type {
        case .freeFormat:
            metaDataFormat.append(["text":"Free text"])
        case .numericFormat:
            metaDataFormat.append(["value":Double(0.0)])
        case .dateFormat:
            metaDataFormat.append(["date":Defaults().today])
        case .numericWithUnitFormat:
            metaDataFormat.append(["value":Double(0.0)])
            metaDataFormat.append(["unit":"Unit"])
        case .colorFormat:
            metaDataFormat.append(["color":UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)])
        case .imageFormat:
            metaDataFormat.append(["image":Defaults().image])
        }
    }
}
