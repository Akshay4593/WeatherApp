//
//  ForecastTVCell.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 06/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import UIKit

class ForecastTVCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weekData: [WeatherResponse] = []
    var weeklyData: [WeeklyData] = []
    var showingDataFor: WheatherDetailsFor = .showingOfflineData
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    private func setUI(){
        
        collectionView.register(UINib(nibName: "ForecastCVCell", bundle: nil), forCellWithReuseIdentifier: "ForecastCVCell")
        
        collectionView.backgroundColor = Color.BackgroundLightBlue.value
        collectionView.dataSource = self
        collectionView.delegate = self        
        collectionView.reloadData()
        
    }
    
    func configureCell(data: [WeatherResponse]) {
        weekData = data
        collectionView.reloadData()
    }
    
    func configureCell(weeklyData: [WeeklyData]) {
        self.weeklyData = weeklyData
        collectionView.reloadData()
    }
    
    
}
extension ForecastTVCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch showingDataFor {
        case .showingApiData:
            return weekData.count
        default:
            return  weeklyData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCVCell", for: indexPath) as! ForecastCVCell
        
        switch showingDataFor {
        case .showingApiData:
            let dailyData = self.weekData[indexPath.item]
            cell.configureCell(data: dailyData)
            break
        case .showingOfflineData:
            let weekData = weeklyData[indexPath.row]
            cell.configureCell(data: weekData)
            break
        }
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemHeight: CGFloat = collectionView.frame.height
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - (5 * 5))/5
        let itemSize: CGSize = CGSize(width: itemWidth, height: itemHeight)
        return itemSize
    }
    
    
}

extension ForecastTVCell : UICollectionViewDelegate {
    
    
}

