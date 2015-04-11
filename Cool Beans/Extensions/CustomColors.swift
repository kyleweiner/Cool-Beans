//
//  CustomColors.swift
//  Cool Beans
//
//  Created by Kyle on 11/13/14.
//  Copyright (c) 2014 Kyle Weiner. All rights reserved.
//

extension UIColor {

    // MARK: Temperature Colors

    class func CBHotColor() -> UIColor {
        return UIColor(rgba: "#FF2851")
    }

    class func CBWarmColor() -> UIColor {
        return UIColor(rgba: "#FF9600")
    }

    class func CBCoolColor() -> UIColor {
        return UIColor(rgba: "#FFCD00")
    }

    class func CBColdColor() -> UIColor {
        return UIColor(rgba: "#54C7FC")
    }

    // MARK: Helpers

    // Credit: https://github.com/yeahdongcn/UIColor-Hex-Swift/
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0

        if rgba.hasPrefix("#") {
            let index   = advance(rgba.startIndex, 1)
            let hex     = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0

            if scanner.scanHexLongLong(&hexValue) {
                if count(hex) == 6 {
                    red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF) / 255.0
                } else if count(hex) == 8 {
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                } else {
                    print("invalid rgb string, length should be 7 or 9")
                }
            } else {
                println("scan hex error")
            }
        } else {
            print("invalid rgb string, missing '#' as prefix")
        }

        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

}