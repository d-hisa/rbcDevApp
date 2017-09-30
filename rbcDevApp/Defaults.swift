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
    let num: Double = 0.0
    init(){
    }
}
