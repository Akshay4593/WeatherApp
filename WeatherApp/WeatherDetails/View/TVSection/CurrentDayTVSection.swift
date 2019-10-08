//
//  CurrentDayTVSection.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 06/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import UIKit

class CurrentDayTVSection: UITableViewCell {

    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var goBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var avgTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var horizontalLineLbl: UILabel!
    
    
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
            avgTempLbl.text = "\(mainData.temp )"
            minTempLbl.text = "\(mainData.tempMin )"
            maxTempLbl.text = "\(mainData.tempMax )"
        }
        
        if let weatherData = currentDayData.weather?.first{
            descriptionLbl.text = weatherData.description
            let imgUrl = weatherData.imageFullPath
        }
        
    }
    
}
