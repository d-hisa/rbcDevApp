//
//  Contents.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/08/30.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import RealmSwift

class ContentObject: Object{
    dynamic var conName:String = ""
    var conImage:UIImage = UIImage()
    dynamic var conImageData: Data = Data()
    dynamic var conBelongingCategory:String = ""
    var conMetadataObjArray: [MetadataObject] = []
    let conMetadataObjList = List<MetadataObject>()
    
    override static func ignoredProperties() -> [String] {
        return ["conImage","conMetadataObjArray"]
    }
    
    convenience init(name:String, withCat:String){
        self.init()
        self.conName = name
        self.conBelongingCategory = withCat
    }
    
    // Convert
    func convertArray2List(){
        if conMetadataObjList.count > 0{
            conMetadataObjList.removeAll()
        }
        for i in 0..<conMetadataObjArray.count {
            conMetadataObjArray[i].encodeData()
            conMetadataObjList.append(conMetadataObjArray[i])
        }
    }
    func convertList2Array(){
        if conMetadataObjArray.count > 0{
            conMetadataObjArray.removeAll()
        }
        for i in 0..<conMetadataObjList.count{
            conMetadataObjList[i].decodeData()
            conMetadataObjArray.append(conMetadataObjList[i])
        }
    }
    // Realm格納用に各データをエンコード
    func encodeData(){
        //self.conImageData = NSKeyedArchiver.archivedData(withRootObject: self.conImage) as Data
        self.conImageData = conImage.convertImage2DataWithArchiving(maxKB: 100)
        convertArray2List()
    }
    // Realm展開用に各データをデコード
    func decodeData(){
        //self.conImage = (NSKeyedUnarchiver.unarchiveObject(with: self.conImageData) as? UIImage)!
        self.conImage = UIImage(data: conImageData)!
        convertList2Array()
    }
    
}

