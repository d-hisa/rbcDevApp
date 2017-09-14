//
//  metaData.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/08/30.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class metaData{
    
    enum MetaDataType: String{
        case freeFormat             = "freeFormat"
        case numericFormat          = "numericFormat"
        case dateFormat             = "dateFormat"
        case numericWithUnitFormat  = "numericWithUnitFormat"
        case colorFormat            = "colorFormat"
        case imageFormat            = "imageFormat"
    }
    
    var metaDataFormat: [[String:Any]] = [[:]]
    
    
    init(metaDataType: MetaDataType){
        switch metaDataType {
        case .freeFormat:
            metaDataFormat.append(["text":String()])
        case .numericFormat:
            metaDataFormat.append(["value":Double()])
        case .dateFormat:
            metaDataFormat.append(["year":Int()])
            metaDataFormat.append(["month":Int()])
            metaDataFormat.append(["daty":Int()])
        case .numericWithUnitFormat:
            metaDataFormat.append(["value":Double()])
            metaDataFormat.append(["unit":String()])
        case .colorFormat:
            metaDataFormat.append(["color":UIColor()])
        case .imageFormat:
            metaDataFormat.append(["image":UIImage()])
        default:
            metaDataFormat.append(["text":String()])
        }
    }
    
}
