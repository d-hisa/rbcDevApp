//
//  ColorUitlities.swift
//  rbcDevApp
//
//  Created by nttr on 2017/09/12.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class colorUtilities{
    
    var modernColors:[UIColor] = []
    
    func initModerColors(){
        modernColors.append(UIColor(red:0,green:0,blue:0,alpha:1.0))
    }
    
    
    func randColor() -> UIColor{
        let r: CGFloat = CGFloat(arc4random_uniform(255)+1) / 255.0
        let g: CGFloat = CGFloat(arc4random_uniform(255)+1) / 255.0
        let b: CGFloat = CGFloat(arc4random_uniform(255)+1) / 255.0
        let color: UIColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        return color
    }
    func randModernColor() -> UIColor{
        return self.modernColors[Int(arc4random_uniform(UInt32(modernColors.count)))]
    }
}
