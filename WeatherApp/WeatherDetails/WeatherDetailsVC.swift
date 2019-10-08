//
//  WeatherDetailsVC.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import UIKit

class WeatherDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: WeatherDetailsPresenterProtocol?
    
    private var currentDayData: WeatherResponse?
    
    private var weekDataList: [WeatherResponse]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    private func setUI(){
        tableView.register(UINib(nibName: "ForecastTVCell", bundle: nil), forCellReuseIdentifier: "ForecastTVCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 280
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    

}

extension WeatherDetailsVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTVCell", for: indexPath) as! ForecastTVCell
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //  let sectionView = tableView.dequeueReusableCell(withIdentifier: "CurrentDayTVSection") as! CurrentDayTVSection
        let sectionView = (Bundle.main.loadNibNamed("CurrentDayTVSection", owner: self, options: nil)![0] as? CurrentDayTVSection)
        if let currentDayData = self.currentDayData {
            sectionView?.configureSection(currentDayData: currentDayData)
        }
        return sectionView
        
    }
    

}
extension WeatherDetailsVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
}

extension WeatherDetailsVC : WeatherDetailsVCProtocol {
    func showCurrentDayData(response: WeatherResponse) {
        self.currentDayData = response
        tableView.reloadData()
    }
    
    func showForecastData(response: [WeatherResponse]) {
        
    }
    

}
