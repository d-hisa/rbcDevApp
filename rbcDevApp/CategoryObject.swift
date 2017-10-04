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
    var catTextColor: UIColor = UIColor()
    dynamic var catTextColorData: Data = Data()
    var catBackColor: UIColor = UIColor()
    dynamic var catBackColorData: Data = Data()
    var metaDataPresetsObjArray:[MetadataPresetObject] = []
    let metaDataPresetsObjList = List<MetadataPresetObject>()
    /*
    convenience required init() {
        self.init()
        self.catName = "untitled"
        self.catBackColor = Defaults().backColor
        self.catTextColor = Defaults().textColor
    }*/
    
    override static func ignoredProperties() -> [String] {
        return ["catTextColor","catBackColor","metaDataPresetsObjArray"]
    }
    
    convenience init(name:String,color:UIColor,textColor:UIColor){
        self.init()
        self.catName = name
        self.catBackColor = color
        self.catTextColor = textColor
    }
    // Convert
    func convertArray2List(){
        if metaDataPresetsObjList.count > 0{
            metaDataPresetsObjList.removeAll()
        }
        for i in 0..<metaDataPresetsObjArray.count {
            metaDataPresetsObjList.append(metaDataPresetsObjArray[i])
        }
    }
    func convertList2Array(){
        if metaDataPresetsObjArray.count > 0{
            metaDataPresetsObjArray.removeAll()
        }
        for i in 0..<metaDataPresetsObjList.count{
            metaDataPresetsObjArray.append(metaDataPresetsObjList[i])
        }
    }
    
    // Realm格納用に各データをエンコード
    func encodeData(){
        self.catBackColorData = NSKeyedArchiver.archivedData(withRootObject: self.catBackColor) as Data
        self.catTextColorData = NSKeyedArchiver.archivedData(withRootObject: self.catTextColor) as Data
        convertArray2List()
    }
    // Realm展開用に各データをデコード
    func decodeData(){
        self.catBackColor = (NSKeyedUnarchiver.unarchiveObject(with: self.catBackColorData) as? UIColor)!
        self.catTextColor = (NSKeyedUnarchiver.unarchiveObject(with: self.catTextColorData) as? UIColor)!
        convertList2Array()
    }
    
    
}

