//
//  metaData.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/08/30.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import RealmSwift

class MetadataPresetObject:Object{
    dynamic var mpName:String = ""
    dynamic var mpUnit:String = ""
    dynamic var mpFormat:String = ""
    dynamic var mpBelongCategory = ""
    convenience init(name:String,format:String,unit:String, withCategory:String){
        self.init()
        self.mpName = name
        self.mpFormat = format
        self.mpUnit = unit
        self.mpBelongCategory = withCategory
    }
}

class MetadataObject: Object {
    enum mType: String{
        case freeFormat             = "freeFormat"
        case numericFormat          = "numericFormat"
        case dateFormat             = "dateFormat"
        case numericWithUnitFormat  = "numericWithUnitFormat"
        case colorFormat            = "colorFormat"
        case imageFormat            = "imageFormat"
    }
    dynamic var mName:String = ""
    dynamic var mType:String = ""
    dynamic var mValue:Double = 0.0
    dynamic var mText:String = ""
    var mImage:UIImage = UIImage()
    dynamic var mImageData:Data = Data()
    var mDate:Date = Defaults().todayDate
    dynamic var mDateData:Data = Data()
    var mColor:UIColor = UIColor()
    dynamic var mColorData:Data = Data()
    
    override static func ignoredProperties() -> [String] {
        return ["mImage","mDate","mColor"]
    }
    
    convenience init(
        name: String,
        type:String,
        value:Double,
        text:String,
        image:UIImage,
        date:Date,
        color:UIColor
        ){
        self.init()
        self.mName = name
        self.mType = type
        self.mValue = value
        self.mText = text
        self.mImage = image
        self.mDate = date
        self.mColor = color
    }
    // freeFormat
    convenience init(name: String, type:String, text:String){
        self.init()
        self.mName = name
        self.mType = type
        self.mValue = 0.0
        self.mText = text
        self.mImage = UIImage()
        self.mDate = Date()
        self.mColor = UIColor()
    }
    // numeric
    convenience init(name: String, type:String, value:Double){
        self.init()
        self.mName = name
        self.mType = type
        self.mValue = value
        self.mText = ""
        self.mImage = UIImage()
        self.mDate = Date()
        self.mColor = UIColor()
    }
    // numeric with unit
    convenience init(name: String, type:String, value:Double, text:String){
        self.init()
        self.mName = name
        self.mType = type
        self.mValue = value
        self.mText = text
        self.mImage = UIImage()
        self.mDate = Date()
        self.mColor = UIColor()
    }
    // image
    convenience init(name: String, type:String, image:UIImage){
        self.init()
        self.mName = name
        self.mType = type
        self.mValue = 0.0
        self.mText = ""
        self.mImage = image
        self.mDate = Date()
        self.mColor = UIColor()
    }
    // date
    convenience init(name: String, type:String, date:Date){
        self.init()
        self.mName = name
        self.mType = type
        self.mValue = 0.0
        self.mText = ""
        self.mImage = UIImage()
        self.mDate = date
        self.mColor = UIColor()
    }
    // color
    convenience init(name: String, type:String, color:UIColor){
        self.init()
        self.mName = name
        self.mType = type
        self.mValue = 0.0
        self.mText = ""
        self.mImage = UIImage()
        self.mDate = Date()
        self.mColor = color
    }
    
    // Realm格納用に各データをエンコード
    func encodeData(){
        self.mImageData = NSKeyedArchiver.archivedData(withRootObject: self.mImage) as Data
        self.mColorData = NSKeyedArchiver.archivedData(withRootObject: self.mColor) as Data
    }
    // Realm展開用に各データをデコード
    func decodeData(){
        self.mImage = NSKeyedUnarchiver.unarchiveObject(with: mImageData) as! UIImage
        self.mColor = NSKeyedUnarchiver.unarchiveObject(with: mColorData) as! UIColor
    }
}
