//
//  UIColor.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 09/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation
import UIKit

enum Color: String {
    case Black = "#000000"
    case Black33 = "#333333"
    case White = "#FFFFFF"
    case Beige = "#f8f7f0"
    case Black_15 = "#25000000"
    case WaterMelon = "#FF4B5A"
    case BackgroundLightBlue = "#207ce5"
    
    
    case WaterMelon_95 = "#EF4B5A"
    case Greyish = "#AFAFAF"
    case GreenBlue = "#00CF70"
    case Silver = "#cbcbcb"
    case BrownishGray = "#6d6c62"
    case WarmGray = "#999999"
    case warm_grey_two = "#757575"
    case BrownishGray_two = "#666666"
    case BrownishGray_three = "#bbbbbb"
    case GreenBlueDark = "#00b260"
    case GreenDark = "#00B05F"
    case GreenLight = "#00cf70"
    
    
    //newColours
    case DeepSeaBlue = "#005191"
    case Greyish_brown = "#515151"
    case Cool_Blue = "#48acc5"
    case Topaz = "#1bc0a7"
    case Light_Gray = "#f5f5f5"
    case Grey = "#9a9a9a"
    
    
    case textGray = "888888"
    
    case GrayLight_Text = "#676767"
    case Browngrey_three = "#9b9b9b"
    case LighGrey_background = "#efefef"
    case Border_grey = "#eae9e9"
    case lineBackgroundColor = "#f1f1f1"
    case textGrey = "#878787"
    case backgroundViewGrey = "#ededed"
    case textView_border = "#979797"
    
    case Light_Greenish_Blue = "#6ceab1"
    
    
    var value: UIColor {
        return UIColor(hexString: self.rawValue)!
    }
    
}
