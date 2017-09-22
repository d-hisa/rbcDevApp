//
//  demoDatas.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/09/15.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class demoDatas {
    
    var categoryArray: [Category] = []
    
    init(){
        // demo category 1
        let catAppleDevice: Category = Category(name: "AppleDevice", code: "0", color: UIColor.black, textColor: UIColor.white)
        let conIphone7: Contents = Contents(name: "iPhone7",image: UIImage(named: "sample_iphone.jpg")!)
        let conIpad: Contents = Contents(name: "iPad Pro 9.7", image: UIImage(named: "sample_ipad.jpg")!)
        let conAppleWatch: Contents = Contents(name: "AppleWatch2", image: UIImage(named: "sample_appleWatch.jpg")!)
        conIphone7.addMetaData(mData: metaData(name: "TypeCode", type: metaData.mType.freeFormat))
        conIpad.addMetaData(mData: metaData(name: "TypeCode", type: metaData.mType.freeFormat))
        conAppleWatch.addMetaData(mData: metaData(name: "TypeCode", type: metaData.mType.freeFormat))
        catAppleDevice.addContent(content: conIphone7)
        catAppleDevice.addContent(content: conIpad)
        catAppleDevice.addContent(content: conAppleWatch)
        
        // demo category 2
        let catCloth: Category = Category(name: "Clothes", code: "1", color: UIColor.blue, textColor: UIColor.white)
        
        
        
        
        
    }
    
    
}
