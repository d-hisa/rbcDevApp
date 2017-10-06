//
//  Defaults.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/09/15.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

struct Defaults{
    let text: String = "Default"
    let image: UIImage = UIImage(named: "noImage.png")!
    let textColor: UIColor = Azusa().navy.main
    let backColor: UIColor = Azusa().white.main
    let today: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    let todayDate = Date()
    let zeroDate:Date = Calendar(identifier: .gregorian).date(from: DateComponents(year:0000,month: 00, day:00))!
    let num: Double = 0.0
    init(){
    }
}
