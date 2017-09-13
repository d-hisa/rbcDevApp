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
    
    var metaDataFormat: [Any] = []
    
    
    init(metaDataType: MetaDataType){
        switch metaDataType {
        case .freeFormat:
            metaDataFormat.append(String())
        case .numericFormat:
            metaDataFormat.append(Double())
        case .dateFormat:
            metaDataFormat.append(Int())
        case .numericWithUnitFormat:
        case .colorFormat:
        case .imageFormat:
        default:
            <#code#>
        }
        
        
    }
    
}
