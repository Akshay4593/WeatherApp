//
//  CurrentDayTVSection.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 06/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import UIKit
import Kingfisher

protocol CurrentDayTVSectionDelegate: class{
    
    func goBtnTapped(city: String)
}

class CurrentDayTVSection: UITableViewCell {

    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var goBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var avgTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var horizontalLineLbl: UILabel!
    
    weak var delegate: CurrentDayTVSectionDelegate?
    
    private var city: String? = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureSection(currentDayData: WeatherResponse){
        cityLbl.text = currentDayData.name ?? ""
        
        if let mainData = currentDayData.main {
            avgTempLbl.text = "\(mainData.temp.inCelcius) °C"
            minTempLbl.text = "\(mainData.tempMin.inCelcius) °C"
            maxTempLbl.text = "\(mainData.tempMax.inCelcius) °C"
        }

        if let weatherData = currentDayData.weather?.first{
            descriptionLbl.text = weatherData.description
            let urlInString = weatherData.imageFullPath
            let imgUrl = URL(string: urlInString)
            imgView.kf.setImage(with: imgUrl)
        }
        
        city = currentDayData.name
        
    }
    
    
    func configureSection(dailyData: DailyData){
        
        cityLbl.text = dailyData.cityName
        
        avgTempLbl.text = "\(dailyData.avgTemp.inCelcius) °C"
        minTempLbl.text = "\(dailyData.minTemp.inCelcius) °C"
        maxTempLbl.text = "\(dailyData.maxTemp.inCelcius) °C"
        descriptionLbl.text = dailyData.desc
        if let urlInString = dailyData.imgUrl,
            let imgUrl = URL(string: urlInString) {
            imgView.kf.setImage(with: imgUrl)
        }
        
        
    }
    
    
    @IBAction func goBtnAction(_ sender: UIButton) {
        
        if let deleagte = delegate,
          let city = city{
            deleagte.goBtnTapped(city: city)
        }
    }
    
}
