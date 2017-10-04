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
    //var conMetaDataFormatPreset:[metaDataFormat] = []
    var conMetadataArray: [metaData] = []
    let conMetadataList = List<MetadataObject>()
    
    override static func ignoredProperties() -> [String] {
        return ["conImage","conMetadataArray"]
    }
    ///////////// Constructor /////////////
    /*
    convenience init(){
        self.init()
        self.conName = "untitled"
        self.conImage = Defaults().image
    }
    
    convenience init(name: String){
        self.init()
        self.conName = name
        self.conImage = Defaults().image
    }
    convenience init(name: String, image: UIImage, category: Category){
        self.init()
        self.conName = name
        self.conImage = image
        self.conMetaDataArray = category.metaDataPresetArray
        //self.conMetaDataFormatPreset = category.metaDataFormatPresetArray
    }*/
    
    ///////////////////////////////////////
    
    
}

