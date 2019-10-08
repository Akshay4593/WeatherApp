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
    
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var tempLabl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(data: WeatherResponse){
        
        if let dateInTimestramp = data.date {
            let dateInDateFormat = Date(timeIntervalSince1970: dateInTimestramp )
            if let dayInWeek = dateInDateFormat.dayInWeek {
                dayLbl.text = dayInWeek
            }
        }
        
       if let mainData = data.main {
        
        let minTemp = mainData.tempMin
        let maxTemp = mainData.tempMax
        tempLabl.text = "\(minTemp)/\(maxTemp)"
        }
        
        if let weatherData = data.weather?.first {
            let urlInString = weatherData.imageFullPath
            let imgUrl = URL(string: urlInString)
            imgView.kf.setImage(with: imgUrl)
        }
    
        
    }
  
}
