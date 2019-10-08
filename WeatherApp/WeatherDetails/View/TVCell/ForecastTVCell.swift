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
    
    var weekData: [WeatherResponse]?
    
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
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
//        let collectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
//        collectionViewFlowLayout?.minimumLineSpacing = 16
//        collectionViewFlowLayout?.minimumInteritemSpacing = 16
//        collectionViewFlowLayout?.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let cellWidth : CGFloat = (collectionView.frame.size.width) - (5*8) / 5.0
        let cellheight : CGFloat = collectionView.frame.size.height
        let cellSize = CGSize(width: 90 , height:130)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.reloadData()
    
    }
    
    func configureCell(data: [WeatherResponse]) {
        weekData = data
    }
    
    

}
extension ForecastTVCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCVCell", for: indexPath) as! ForecastCVCell
        if let weekData = self.weekData {
            let dailyData = weekData[indexPath.item]
            cell.configureCell(data: dailyData)
            
        }
        return cell
        
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let itemHeight: CGFloat = collectionView.frame.height
//        let itemWidth: CGFloat = (UIScreen.main.bounds.width - (5 * 4))/5
//        let itemSize: CGSize = CGSize(width: itemWidth, height: itemHeight)
//        return itemSize
//    }
    
    
    
}

extension ForecastTVCell : UICollectionViewDelegate {
    
    
}
