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
    var mData:Any
    
    init(type: mType){
        switch type {
        case .freeFormat:
            mData = mData as! freeFormat
            mData = freeFormat()
        case .numericFormat:
            mData = mData as! numericFormat
            mData = numericFormat()
        case .dateFormat:
            mData = mData as! dateFormat
            mData = dateFormat()
        case .numericWithUnitFormat:
            mData = mData as! numericWithUnitFormat
            mData = numericWithUnitFormat()
        case .colorFormat:
            mData = mData as! colorFormat
            mData = colorFormat()
        case .imageFormat:
            mData = mData as! imageFormat
            mData = imageFormat()
        }
    }
    struct freeFormat{
        var text:String
        init(){
            self.text = Defaults().text
        }
    }
    struct numericFormat{
        var value: Double
        init(){
            self.value = Defaults().num
        }
    }
    struct numericWithUnitFormat{
        var value: Double
        var unit: String
        init(){
            self.value = Defaults().num
            self.unit = Defaults().text
        }
    }
    struct colorFormat {
        var color: UIColor
        init(){
            self.color = Defaults().textColor
        }
    }
    struct dateFormat{
        var date:DateComponents
        init(){
            self.date = Defaults().today
        }
    }
    struct imageFormat{
        var image: UIImage
        init(){
            self.image = Defaults().image
        }
    }
}

class metaDataFormat {
    var name:String = ""
    var metaDataType:metaDataFormat
    var metaDataElement:metaData
    
    init(){
        self.name = "untitled"
        self.metaDataType = metaData.mType.freeFormat
        self.metaDataElement = metaData(type: metaData.mType.freeFormat)
    }
    init(name: String, mType:metaData.mType){
        self.name = name
        self.metaDataType = mType
        self.metaDataElement = metaData(type: mType)
    }
}
