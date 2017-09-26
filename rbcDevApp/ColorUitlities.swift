//
//  ColorUitlities.swift
//  rbcDevApp
//
//  Created by nttr on 2017/09/12.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class colorUtilities{
    let modernColorsOfHex:[String] = [
        
    ]
    var modernColors:[UIColor] = []
    
    func initModernColors(){
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

struct colorSet{
    var mainColor: UIColor
    var subColor: UIColor
    var textColor: UIColor
}

struct level {
    var num:Int
    var main:UIColor
    var pale:UIColor
    var light:UIColor
    var medium:UIColor
    var heavy:UIColor
    var dark:UIColor
    
    init(num:Int, main:UIColor, pale:UIColor, light:UIColor, medium:UIColor, heavy:UIColor, dark:UIColor){
        self.num = num
        self.main = main
        self.pale = pale
        self.light = light
        self.medium = medium
        self.heavy = heavy
        self.dark = dark
    }
}

class Azusa{
    let white:level = level(
        num: 0,
        main: UIColor(hexString: "#FFFFFF"),
        pale: UIColor(hexString: "#EFEFEF"),
        light: UIColor(hexString: "#D0D0D0"),
        medium: UIColor(hexString: "#B1B2B1"),
        heavy: UIColor(hexString: "#959595"),
        dark: UIColor(hexString: "#6C6C6C")
    )
    let cream:level = level(
        num: 1,
        main: UIColor(hexString: "#FDF3DD"),
        pale: UIColor(hexString: "#F9DEA4"),
        light: UIColor(hexString: "#F4BF57"),
        medium: UIColor(hexString: "#EB8933"),
        heavy: UIColor(hexString: "#653D16"),
        dark: UIColor(hexString: "#241808")
        )
    let navy:level = level(
        num: 2,
        main: UIColor(hexString: "#363C5D"),
        pale: UIColor(hexString: "#CED1DF"),
        light: UIColor(hexString: "#9EA4C2"),
        medium: UIColor(hexString: "#939293"),
        heavy: UIColor(hexString: "#282C42"),
        dark: UIColor(hexString: "#1B1D2B")
        )
    let gray:level = level(
        num: 3,
        main: UIColor(hexString: "#D4D6D8"),
        pale: UIColor(hexString: "#B7BCC0"),
        light: UIColor(hexString: "#90969C"),
        medium: UIColor(hexString: "#555C63"),
        heavy: UIColor(hexString: "#272A2D"),
        dark: UIColor(hexString: "#111113")
        )
    let cyan:level = level(
        num: 4,
        main: UIColor(hexString: "#3B96F0"),
        pale: UIColor(hexString: "#C0EAFB"),
        light: UIColor(hexString: "#87D6F9"),
        medium: UIColor(hexString: "#53C1F6"),
        heavy: UIColor(hexString: "#2A6AA7"),
        dark: UIColor(hexString: "#1A4267")
        )
    let green:level = level(
        num: 5,
        main: UIColor(hexString: "#48A87E"),
        pale: UIColor(hexString: "#CBF1E5"),
        light: UIColor(hexString: "#99E1CB"),
        medium: UIColor(hexString: "#6DD4B3"),
        heavy: UIColor(hexString: "#337659"),
        dark: UIColor(hexString: "#1F4A38")
        )
    let blue:level = level(
        num: 6,
        main: UIColor(hexString: "#49AFCA"),
        pale: UIColor(hexString: "#B7F6FC"),
        light: UIColor(hexString: "#78EFF9"),
        medium: UIColor(hexString: "#61E8F8"),
        heavy: UIColor(hexString: "#337B8D"),
        dark: UIColor(hexString: "#1F4B56")
        )
    let orange:level = level(
        num: 7,
        main: UIColor(hexString: "#E97B32"),
        pale: UIColor(hexString: "#FAE3C0"),
        light: UIColor(hexString: "#F5C986"),
        medium: UIColor(hexString: "#F1AE53"),
        heavy: UIColor(hexString: "#AF5825"),
        dark: UIColor(hexString: "#6B3717")
        )
    let red:level = level(
        num: 8,
        main: UIColor(hexString: "#E1333D"),
        pale: UIColor(hexString: "#F6D2D3"),
        light: UIColor(hexString: "#EFA8AA"),
        medium: UIColor(hexString: "#E98184"),
        heavy: UIColor(hexString: "#E1272A"),
        dark: UIColor(hexString: "#961A1C")
        )
    let purple:level = level(
        num: 9,
        main: UIColor(hexString: "#A94CBA"),
        pale: UIColor(hexString: "#EBD7F0"),
        light: UIColor(hexString: "#D5ADDD"),
        medium: UIColor(hexString: "#CA8FD5"),
        heavy: UIColor(hexString: "#822495"),
        dark: UIColor(hexString: "#50195B")
    )
    enum levelNum:Int{
        case main, pale, light, medium, heavy, dark
    }
    
    // Main:0 Sub:1
    let textMainColorMap:[[Int]] = [
        [0, 0, 1, 0, 1, 1, 1, 1, 1, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    ]
    var textMainColor: UIColor = UIColor()
    var textSubColor: UIColor = UIColor()
    init(){
        textMainColor = self.navy.main
        textSubColor = self.white.main
    }
    
    func getUseTextColor(level: levelNum, colorNum: Int) -> UIColor{
        let row: [Int] = textMainColorMap[level.rawValue]
        let coulmn: Int = row[colorNum]
        switch coulmn {
        case 0:
            return textMainColor
        case 1:
            return textSubColor
        default:
            return textMainColor
        }
    }
}



// hex指定できるイニシャライザを追加
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
