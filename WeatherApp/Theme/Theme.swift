//
//  Theme.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 09/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

import UIKit

class AppTheme {
    
    private static var sharedManager: AppTheme = {
        let theme = AppTheme()
        return theme
    }()
    
    public static func shared() -> AppTheme {
        return sharedManager
    }
    
    private init() {}
    
    public static func applyThemeRegularFont(to labels: [UILabel], size: CGFloat) {
        labels.forEach {
            $0.font = UIFont.themeRegularFont(of: size)
        }
    }
    
    public static func applyThemeRegularFont(to textView: [UITextView], size: CGFloat) {
        textView.forEach {
            $0.font = UIFont.themeRegularFont(of: size)
        }
    }
    
    public static func applyThemeMediumFont(to labels: [UILabel], size: CGFloat) {
        labels.forEach {
            $0.font = UIFont.themeMediumFont(of: size)
        }
    }
    
    public static func applyThemeLightFont(to labels: [UILabel], size: CGFloat) {
        labels.forEach {
            $0.font = UIFont.themeLightFont(of: size)
        }
    }
    
    public static func applyThemeBoldFont(to labels: [UILabel], size: CGFloat) {
        labels.forEach {
            $0.font = UIFont.themeBoldFont(of: size)
        }
    }
    
    public static func applyThemeHeavyFont(to labels: [UILabel], size: CGFloat) {
        labels.forEach {
            $0.font = UIFont.themeHeavyFont(of: size)
        }
    }
    
    public static func applyThemeRegularFont(to btns: [UIButton], size: CGFloat) {
        btns.forEach {
            $0.titleLabel?.font = UIFont.themeRegularFont(of: size)
        }
    }
    
    public static func applyThemeMediumFont(to btns: [UIButton], size: CGFloat) {
        btns.forEach {
            $0.titleLabel?.font = UIFont.themeMediumFont(of: size)
        }
    }
    
    public static func applyThemeLightFont(to btns: [UIButton], size: CGFloat) {
        btns.forEach {
            $0.titleLabel?.font = UIFont.themeLightFont(of: size)
        }
    }
    
    public static func applyThemeBoldFont(to btns: [UIButton], size: CGFloat) {
        btns.forEach {
            $0.titleLabel?.font = UIFont.themeBoldFont(of: size)
        }
    }
    
    public static func applyThemeRegularFont(to txtFields: [UITextField], size: CGFloat) {
        txtFields.forEach { text in
            text.font = UIFont.themeRegularFont(of: size)
        }
    }
    
    public static func applyThemeBoldFont(to txtFields: [UITextField], size: CGFloat) {
        txtFields.forEach { text in
            text.font = UIFont.themeBoldFont(of: size)
        }
    }
    
    public static func applyThemeColor(to labels: [UILabel], color: UIColor) {
        labels.forEach {
            $0.textColor = color
        }
    }
    
    public static func applyBackgroundThemeColor(to labels: [UILabel], color: UIColor) {
        labels.forEach {
            $0.backgroundColor = color
        }
    }
    
    
    public static func applyThemeColor(to buttons: [UIButton], color: UIColor) {
        buttons.forEach {
            $0.backgroundColor = color
        }
    }
    
    public static func applyTintColor(to buttons: [UIButton], color: UIColor) {
        buttons.forEach {
            $0.setTitleColor(color, for: .normal)
        }
    }
    
    
    public static func applyThemeTintColor(to txtFields: [UITextField], color: UIColor) {
        txtFields.forEach { text in
            text.tintColor = color
        }
    }
    
}
