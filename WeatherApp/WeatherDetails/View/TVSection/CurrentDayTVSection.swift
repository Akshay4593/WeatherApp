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

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var upperView: UIView!
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
        setTheme()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setTheme(){
        
        AppTheme.applyThemeHeavyFont(to: [cityLbl] , size: 16.0)
        AppTheme.applyThemeBoldFont(to: [avgTempLbl], size: 20.0)
        AppTheme.applyThemeMediumFont(to: [maxTempLbl, minTempLbl], size: 14.0)
        AppTheme.applyThemeMediumFont(to: [descriptionLbl], size: 18.0)

        goBtn.setTitle(" > ", for: .normal)
        AppTheme.applyThemeBoldFont(to: [goBtn], size: 18.0)
        
        goBtn.backgroundColor = .clear
        goBtn.setTitleColor(Color.White.value, for: .normal)
        containerView.backgroundColor = Color.BackgroundLightBlue.value
        
        AppTheme.applyThemeColor(to: [cityLbl, avgTempLbl, minTempLbl, maxTempLbl,descriptionLbl], color: Color.White.value)

        horizontalLineLbl.backgroundColor = Color.White.value
        
        upperView.layer.borderWidth = 1.0
        upperView.layer.borderColor = Color.White.value.cgColor
        upperView.layer.cornerRadius = 20.0

    }
    
    
    func configureSection(currentDayData: WeatherResponse){
        cityLbl.text = currentDayData.name?.capitalized ?? ""
        
        if let mainData = currentDayData.main {
            avgTempLbl.text = "\(mainData.temp.inCelcius) °C"
            minTempLbl.text = "\(mainData.tempMin.inCelcius) °C"
            maxTempLbl.text = "\(mainData.tempMax.inCelcius) °C"
        }

        if let weatherData = currentDayData.weather?.first{
            descriptionLbl.text = weatherData.description.capitalized
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
