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
        var catAppleDevice: Category = Category(name: "AppleDevice", code: "0", color: UIColor.black, textColor: UIColor.white)
        var mainText: [String] = ["iPhone7","iPad Pro 9.7","AppleWatch2"]
        var subText: [String] = ["MNCJ2J/A","MM172J/A","MNT22J/A"]
        var contentsImage: [UIImage] = [
            UIImage(named: "sample_iphone.jpg")!,
            UIImage(named: "sample_ipad.jpg")!,
            UIImage(named: "sample_appleWatch.jpg")!
        ]
        for i in 0 ..< mainText.count {
            let content: Contents = Contents(name: mainText[i])
            content.conImage = contentsImage[i]
            let mData: metaData = metaData(name: "TypeCode", type: metaData.mType.freeFormat)
            content.addMetaData(mData: mData)            
        }
        
        
        
        
        
    }
    
    
}
