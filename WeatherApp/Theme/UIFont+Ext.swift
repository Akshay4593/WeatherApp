//
//  UIFont+Ext.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 09/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation
import UIKit

enum Font: String {
    
    case Bold = "SFProText-Bold"
    case Light = "SFProText-Light"
    case Medium = "SFProText-Medium"
    case Regular = "SFProText-Regular"
    case SemiBold = "SFProText-Semibold"
    case Heavy = "SFProText-Heavy"
    
    var name: String {
        return self.rawValue
    }
}

extension UIFont {
    
    static func themeFont(font: Font, size: CGFloat) -> UIFont {
        return UIFont(name: font.name, size: size)!
    }
    
    open class func themeLightFont(of size: CGFloat) -> UIFont {
        return UIFont(name: Font.Light.name, size: size)!
    }
    
    open class func themeRegularFont(of size: CGFloat) -> UIFont {
        return UIFont(name: Font.Regular.name, size: size)!
    }
    
    static func themeMediumFont(of size: CGFloat) -> UIFont {
        return UIFont(name: Font.Medium.name, size: size)!
    }
    
    static func themeBoldFont(of size: CGFloat) -> UIFont {
        return UIFont(name: Font.Bold.name, size: size)!
    }
    
    static func themeHeavyFont(of size: CGFloat) -> UIFont {
        return UIFont(name: Font.Heavy.name, size: size)!
    }
    
}
