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
    let textColor: UIColor = UIColor.black
    let backColor: UIColor = UIColor.white
    let today: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
}
