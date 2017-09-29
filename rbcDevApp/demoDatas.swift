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
        catAppleDevice.addMetaData2Preset(md: metaData(name: "TypeCode", type: metaData.mType.freeFormat))
        catAppleDevice.addMetaData2Preset(md: metaData(name: "Price", type: metaData.mType.numericWithUnitFormat))
        catAppleDevice.addMetaData2Preset(md: metaData(name: "Bought Day", type: metaData.mType.dateFormat))
        catAppleDevice.addMetaData2Preset(md: metaData(name: "Device Color", type: metaData.mType.colorFormat))
        catAppleDevice.addMetaData2Preset(md: metaData(name: "Generation", type: metaData.mType.numericFormat))
        catAppleDevice.addMetaData2Preset(md: metaData(name: "Reciept", type: metaData.mType.imageFormat))
        
        
        
        var conIphone7: Contents = Contents(name: "iPhone7",image: UIImage(named: "sample_iphone.jpg")!, category: catAppleDevice)
        var conIpad: Contents = Contents(name: "iPad Pro 9.7", image: UIImage(named: "sample_ipad.jpg")!, category: catAppleDevice)
        var conAppleWatch: Contents = Contents(name: "AppleWatch2", image: UIImage(named: "sample_appleWatch.jpg")!, category: catAppleDevice)
        
        conIphone7.conMetaDataArray[0].text = "MNCJ2J/A"
        conIpad.conMetaDataArray[0].text = "MM172J/A"
        conAppleWatch.conMetaDataArray[0].text = "MNT22J/A"
        
        conIphone7.conMetaDataArray[1].value = 79800
        conIphone7.conMetaDataArray[1].text = "yen"
        conIphone7.conMetaDataArray[2].date = Defaults().today
        conIphone7.conMetaDataArray[3].color = Azusa().red.light
        conIphone7.conMetaDataArray[4].value = 2016
        conIphone7.conMetaDataArray[5].image = UIImage(named: "iphone_receipt.jpg")!
        
        conIpad.conMetaDataArray[1].value = 99800
        conIpad.conMetaDataArray[1].text = "yen"
        conIpad.conMetaDataArray[2].date = Defaults().today
        conIpad.conMetaDataArray[3].color = Azusa().cream.pale
        conIpad.conMetaDataArray[4].value = 2017
        conIpad.conMetaDataArray[5].image = Defaults().image
        
        conAppleWatch.conMetaDataArray[1].value = 179800
        conAppleWatch.conMetaDataArray[1].text = "yen"
        conAppleWatch.conMetaDataArray[2].date = Defaults().today
        conAppleWatch.conMetaDataArray[3].color = Azusa().navy.dark
        conAppleWatch.conMetaDataArray[4].value = 2018
        conAppleWatch.conMetaDataArray[5].image = UIImage(named: "iphone_receipt.jpg")!
        
        catAppleDevice.addContent(content: conIphone7)
        catAppleDevice.addContent(content: conIpad)
        catAppleDevice.addContent(content: conAppleWatch)
        categoryArray.append(catAppleDevice)
        
        // demo category 2
        var catCloth: Category = Category(name: "Clothes", code: "1", color: UIColor.blue, textColor: UIColor.white)
        catCloth.addMetaData2Preset(md: metaData(name: "Price", type: metaData.mType.numericWithUnitFormat))
        
        var conTops: Contents = Contents(name: "Tops", image:Defaults().image, category: catCloth)
        var conBottoms: Contents = Contents(name: "Bottoms", image: Defaults().image, category:catCloth)
        var conSocks: Contents = Contents(name: "Socks", image:Defaults().image, category: catCloth)
        
        conTops.conMetaDataArray[0].value = 9000
        conTops.conMetaDataArray[0].text = "yen"
        conBottoms.conMetaDataArray[0].value = 3500
        conBottoms.conMetaDataArray[0].text = "yen"
        conSocks.conMetaDataArray[0].value = 180000
        conSocks.conMetaDataArray[0].text = "yen"
        
        catCloth.addContent(content: conTops)
        catCloth.addContent(content: conBottoms)
        catCloth.addContent(content: conSocks)
        
        for i in 0..<10 {
            var conTest:Contents = Contents(name: "cloth" + String(i), image: Defaults().image, category: catCloth)
            conTest.conMetaDataArray[0].value = Double(i * 1000 + i * i)
            conTest.conMetaDataArray[0].text = "yen"
            catCloth.addContent(content: conTest)
        }
        categoryArray.append(catCloth)
        
        // test cat
        for i in 0..<10 {
            var catTest: Category = Category(name: "TestC" + String(i), code: "hoge", color: Azusa().blue.main, textColor: Azusa().cream.main)
            catTest.addMetaData2Preset(md: metaData(name: "lorem", type: metaData.mType.freeFormat))
            for j in 0..<5 {
                var conTestOfTests: Contents = Contents(name: "con" + String(j), image: Defaults().image, category: catTest)
                conTestOfTests.conMetaDataArray[0].text = "conTests" + String(j)
                catTest.addContent(content: conTestOfTests)
            }
            categoryArray.append(catTest)
        }
        
        
        
        
        
    }
    
    
}
