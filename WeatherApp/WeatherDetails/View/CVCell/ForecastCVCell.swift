//
//  ForecastCVCell.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 06/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import UIKit
import Kingfisher

class ForecastCVCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var tempLabl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTheme()
    }
    
    
    func setTheme() {
        
        AppTheme.applyThemeRegularFont(to: [tempLabl], size: 12.0)
        AppTheme.applyThemeMediumFont(to: [dayLbl], size: 16.0)
        containerView.backgroundColor = Color.BackgroundLightBlue.value

        AppTheme.applyThemeColor(to: [dayLbl, tempLabl], color: Color.White.value)
    
    }
    
    
    func configureCell(data: WeatherResponse){
        
        if let dateInTimestramp = data.date {
            let dateInDateFormat = Date(timeIntervalSince1970: dateInTimestramp )
            if let dayInWeek = dateInDateFormat.dayInWeek {
                dayLbl.text = dayInWeek
            }
        }
        
       if let mainData = data.main {
        
        let minTemp = mainData.tempMin.inCelcius
        let maxTemp = mainData.tempMax.inCelcius
        tempLabl.text = "\(minTemp)° /\(maxTemp)°"
        }
        
        if let weatherData = data.weather?.first {
            let urlInString = weatherData.imageFullPath
            let imgUrl = URL(string: urlInString)
            imgView.kf.setImage(with: imgUrl)
        }
    
        
    }
    
    func configureCell(data: WeeklyData) {
        
        let dateInTimestramp = data.dateInTimeStramp
        let dateInDateFormat = Date(timeIntervalSince1970: dateInTimestramp)
        
        if let dayInWeek = dateInDateFormat.dayInWeek {
            dayLbl.text = dayInWeek
        }
        
        let minTemp = data.minTemp.inCelcius
        let maxTemp = data.maxTemp.inCelcius
        
        tempLabl.text = "\(minTemp) °C/\(maxTemp) °C"
        
        if let urlInString = data.imgUrl,
             let imgUrl = URL(string: urlInString)  {
            imgView.kf.setImage(with: imgUrl)

        }
      
    }
  
}
